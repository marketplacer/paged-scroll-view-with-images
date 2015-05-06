//
//  Sends an HTTP request and handles reponse.
//
//  Note: callbacks are called asynchronously and NOT in the main queue.
//

import Foundation

class TegDownloaderAsync {
  class func load(requestIdentity: TegHttpRequestIdentity,
    onSuccess: (NSData, NSHTTPURLResponse)->(),
    onError: ((NSError, NSHTTPURLResponse?)->())? = nil,
    onAlways: (()->())? = nil) -> NSURLSessionDataTask? {
      
    if let nsUrl = requestIdentity.nsUrl {
      
      TegDownloaderAsync.logRequest(requestIdentity)
      
      return load(nsUrl,
        requestIdentity: requestIdentity,
        onSuccess: onSuccess,
        onError: onError,
        onAlways: onAlways
      )
    } else {
      if let alwaysHandler = onAlways {
        alwaysHandler()
      }
      
      if let errorHandler = onError {
        let error = TegError.HttpCouldNotParseUrlString.nsError
        errorHandler(error, nil)
      }
    }
    
    return nil
  }
  
  private class func load(nsUrl: NSURL,
    requestIdentity: TegHttpRequestIdentity,
    onSuccess: (NSData, NSHTTPURLResponse)->(),
    onError: ((NSError, NSHTTPURLResponse?)->())? = nil,
    onAlways: (()->())? = nil) -> NSURLSessionDataTask? {

    if let mockedResponse = requestIdentity.mockedResponse {
      return respondWithMockedData(mockedResponse, nsUrl: nsUrl,
        requestIdentity: requestIdentity, onSuccess: onSuccess)
    }

    let urlRequest = NSMutableURLRequest(URL: nsUrl)
    urlRequest.HTTPMethod = requestIdentity.method.rawValue
    urlRequest.HTTPBody = requestIdentity.requestBody
      
    if requestIdentity.contentType != TegHttpContentType.Unspecified {
      urlRequest.addValue(requestIdentity.contentType.rawValue, forHTTPHeaderField: "Content-Type")
    }

    for httpHeader in requestIdentity.httpHeaders {
      urlRequest.addValue(httpHeader.value, forHTTPHeaderField: httpHeader.field)
    }
      
    var task = TegDownloaderSession.session.dataTaskWithRequest(urlRequest) {
      (data, response, error) in
      
      if let alwaysHandler = onAlways {
        alwaysHandler()
      }
      
      if let httpResponse = response as? NSHTTPURLResponse {
        if error == nil {
          onSuccess(data, httpResponse)
        } else {
          if let errorHandler = onError {
            errorHandler(error, httpResponse)
          }
        }
      } else {
        if let errorHandler = onError {
          errorHandler(error, nil)
        }
      }
    }
      
    task.resume()
    return task
  }

  private class func respondWithMockedData(
    mockedResponse: String,
    nsUrl: NSURL,
    requestIdentity: TegHttpRequestIdentity,
    onSuccess: (NSData, NSHTTPURLResponse)->()) -> NSURLSessionDataTask {

    let data = mockedResponse.dataUsingEncoding(NSUTF8StringEncoding)!
    let httpUrlResponse = NSHTTPURLResponse(URL: nsUrl, statusCode: 200,
      HTTPVersion: nil, headerFields: nil)!

    TegQ.runAfterDelay(0.3) { onSuccess(data, httpUrlResponse) }
    return TegMockedNSUrlSessionDataTask()
  }

  // Log
  // ---------------
  
  private class func logRequest(requestIdentity: TegHttpRequestIdentity) {
    let mocked = requestIdentity.mockedResponse == nil ? "" : "Mocked "
    println("HTTP \(mocked)\(requestIdentity.method.rawValue) \(requestIdentity.url)")

    if let requestBody = requestIdentity.requestBody {
      if requestBody.length < 1024 * 10 {
        if var currentString = NSString(data: requestBody, encoding: NSUTF8StringEncoding) {
          if messageIsSensitive(currentString as String) {
            currentString = "****** hidden ******"
          }

          println("----- Request body ------\n\(currentString)\n-----")
        }
      }
    }
  }

  private class func messageIsSensitive(message: String) -> Bool {
    let sensitiveMessages = [
      "access_token"
    ]

    for substring in sensitiveMessages {
      if TegString.contains(message, substring: substring, ignoreCase: true) {
        return true
      }
    }

    return false
  }
}