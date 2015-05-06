//
//  Describes an HTTP request: url, HTTP method, body data etc.
//

import Foundation

public struct TegHttpRequestIdentity
{
  public let url: String
  public let method: TegHttpMethod
  public let requestBody: NSData?
  public let contentType: TegHttpContentType
  public let httpHeaders: [TegHttpHeader]
  public let mockedResponse: String?

  init(url: String,
    method: TegHttpMethod,
    requestBody: NSData?,
    contentType: TegHttpContentType,
    httpHeaders: [TegHttpHeader],
    mockedResponse: String?) {

    self.url = url
    self.method = method
    self.requestBody = requestBody
    self.contentType = contentType
    self.httpHeaders = httpHeaders
    self.mockedResponse = mockedResponse
  }

  public init(url: String) {
    self.url = url
    method = TegHttpMethod.Get
    requestBody = nil
    contentType = TegHttpContentType.Unspecified
    httpHeaders = []
    self.mockedResponse = nil
  }

  init(identityToCopy: TegHttpRequestIdentity, httpHeaders: [TegHttpHeader]) {
    url = identityToCopy.url
    method = identityToCopy.method
    requestBody = identityToCopy.requestBody
    contentType = identityToCopy.contentType
    mockedResponse = identityToCopy.mockedResponse
    self.httpHeaders = httpHeaders
  }

  public var nsUrl: NSURL? {
    return NSURL(string: url)
  }
}
