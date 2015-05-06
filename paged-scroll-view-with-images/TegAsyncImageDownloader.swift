//
//  Downloads image from server.
//  If image is not found onSuccess callback is called with 'no image' placeholder image.
//
//  Note: callbacks are called asynchronously and NOT in the main queue.
//

import UIKit

class TegAsyncImageDownloader {
  func download(url: String, onSuccess: (UIImage)->(),
    onAlways: (()->())? = nil) -> NSURLSessionDataTask? {
      
    let requestIdentity = TegHttpRequestIdentity(url: url)

    return TegDownloaderAsync.load(requestIdentity,
      onSuccess: { [weak self] (data, response) in
        self?.handleResponse(data, response: response, callback: onSuccess)
      },
      onAlways: {
        if let onAllwaysArgument = onAlways {
          onAllwaysArgument()
        }
      }
    )
  }
  
  func validMimeType(mimeType: String) -> Bool {
    let validMimeTypes = ["image/jpeg", "image/pjpeg"]
    return contains(validMimeTypes, mimeType)
  }
  
  private func handleResponse(data: NSData, response: NSHTTPURLResponse, callback: (UIImage)->()) {
    if response.statusCode != 200 {
      handleError(callback)
      return
    }
    
    if let mimeType = response.MIMEType {
      if !validMimeType(mimeType) {
        handleError(callback)
        return
      }
    } else {
      handleError(callback)
      return
    }
    
    if let image = UIImage(data: data) {
      callback(image)
    }
  }
  
  private func handleError(callback: (UIImage)->()) {
    if let image = UIImage(named: "no_image.jpg") {
      callback(image)
    }
  }
}