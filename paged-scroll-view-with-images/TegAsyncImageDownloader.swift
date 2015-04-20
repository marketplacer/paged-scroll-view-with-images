//
//  Downloads image from server.
//  If image is not found it still called onSuccess callback with 'no image' placeholder image.
//
//  Callbacks are called asynchronously and NOT in the main queue.
//

import UIKit

class TegAsyncImageDownloader {
  class func download(url: String, onSuccess: (UIImage)->(),
    onAlways: (()->())? = nil) -> NSURLSessionDataTask? {
      
    return TegAsyncDownloaderSession.shared.dataWithUrl(url,
      onSuccess: { (data, response) in
        self.handleResponse(data, response: response, callback: onSuccess)
      },
      onAlways: {
        if let onAllwaysArgument = onAlways {
          onAllwaysArgument()
        }
      }
    )
  }
  
  class func validMimeType(mimeType: String) -> Bool {
    let validMimeTypes = ["image/jpeg", "image/pjpeg"]
    return contains(validMimeTypes, mimeType)
  }
  
  class private func handleResponse(data: NSData, response: NSHTTPURLResponse, callback: (UIImage)->()) {
    if response.statusCode != 200 {
      handleError(callback)
      return
    }
    
    if let currentMimeType = response.MIMEType {
      if !validMimeType(currentMimeType) {
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
  
  class private func handleError(callback: (UIImage)->()) {
    if let image = UIImage(named: "no_image.jpg") {
      callback(image)
    }
  }
}