//
//  ImageDownloader.swift
//
//  Downloads image from server. If image is not found - returns 'no image' image.
//
//  Created by Evgenii Neumerzhitckii on 5/09/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class ImageDownloader {
  let validMimeTypes = ["image/jpeg", "image/pjpeg"]
  
  func download(url: String, onSuccess: (UIImage)->(),
    onAlways: (()->())? = nil) -> NSURLSessionDataTask? {
      
    return AsyncDownloaderSession.sharedDownloader.dataWithUrl(url,
      onSuccess: { (data, response) in
        if let currentResponse = response {
          self.handleResponse(data, response: currentResponse, onSuccess)
        } else {
          self.handleError(onSuccess)
        }
      },
      onAlways: {
        if let onAllwaysArgument = onAlways {
          TegQ.main { onAllwaysArgument() }
        }
      }
    )
  }
  
  func validMimeType(mimeType: String) -> Bool {
    return contains(validMimeTypes, mimeType)
  }
  
  private func handleResponse(data: NSData, response: NSHTTPURLResponse, callback: (UIImage)->()) {
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
  
  private func handleError(callback: (UIImage)->()) {
    if let image = UIImage(named: "no_image.jpg") {
       TegQ.main { callback(image) }
    }
  }
}