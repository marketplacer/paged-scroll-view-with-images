//
//  ThingImageDownloader.swift
//
//  Manages download of a single image. Download task can be cancelled.
//
//  Created by Evgenii Neumerzhitckii on 14/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class ImageDownloadTask {
  private var url: String
  private var downloadTask: NSURLSessionDataTask?
  var image:UIImage?
  
  init(imageUrl: String) {
    self.url = imageUrl
  }
  
  func download(onSuccess: (UIImage)->()) {
    if downloadTask != nil { return } // download already in progress
    
    if let currentImage = image {
      // Image has been already downloaded
      onSuccess(currentImage)
      return
    }
 
    startDownloading(onSuccess)
  }
  
  private func startDownloading(onSuccess: (UIImage)->()) {
    downloadTask = ImageDownloader.download(url,
      onSuccess: { image in
        onSuccess(image)
      },
      onAlways: {
        self.downloadTask = nil
      }
    )
  }
  
  func cancel() {
    if let currentDownloadTask = downloadTask {
      currentDownloadTask.cancel()
      downloadTask = nil
    }
  }
}
