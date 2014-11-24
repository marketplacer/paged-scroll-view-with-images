//
//  ImageDownloader.swift
//
//  Downloads image from server.
//  If image is not found it still called onSuccess callback with 'no image' placeholder image.
//
//  Created by Evgenii Neumerzhitckii on 5/09/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class ImageDownloader {
  class func download(url: String, onSuccess: (UIImage)->(),
    onAlways: (()->())? = nil) -> NSURLSessionDataTask? {
      
    return TegDownloader.dataWithUrl(url,
      onSuccess: { (data, response) in
        self.handleResponse(data, response: response, onSuccess)
      },
      onAlways: {
        if let onAllwaysArgument = onAlways {
          TegQ.main { onAllwaysArgument() }
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
      TegQ.main { callback(image) }
    }
  }
  
  class private func handleError(callback: (UIImage)->()) {
    if let image = UIImage(named: "no_image.jpg") {
       TegQ.main { callback(image) }
    }
  }
}