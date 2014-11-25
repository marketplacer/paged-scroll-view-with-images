//
//  ThingImageDownloader.swift
//
//  Manages download of a single image. Download task can be cancelled.
//
//  Created by Evgenii Neumerzhitckii on 14/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class TegImageDownloadTask {
  private var url: String
  private var downloadTask: NSURLSessionDataTask?
  
  init(url: String) {
    self.url = url
  }
  
  func download(onSuccess: (UIImage)->()) {
    if downloadTask != nil { return } // download already in progress
    startDownloading(onSuccess)
  }
  
  private func startDownloading(onSuccess: (UIImage)->()) {
    downloadTask = TegImageDownloader.download(url,
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
