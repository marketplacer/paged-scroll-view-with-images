//
//  ThingImageDownloader.swift
//
//  Manages download of Thing images.
//
//  Created by Evgenii Neumerzhitckii on 14/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

//class ThingImageDownloader {
//  private var url: String!
//  private var downloadTask: NSURLSessionDataTask?
//  private var successCallbacks: [(UIImage, UIImage)->()] = []
//  
//  var monochromeImage:UIImage?
//  var colorImage:UIImage?
//  
//  init(imageUrl: String) {
//    url = imageUrl
//  }
//  
//  func download(callback: ((UIImage, UIImage)->())? = nil) {
//    if let passedCallback = callback {
//      self.successCallbacks.append(passedCallback)
//    }
//    
//    if downloadTask != nil { return } // download already in progress
//    
//    if let currentMonochromeImage = monochromeImage {
//      if let currentColorImage = colorImage {
//        // already downloaded image
//        onSuccess(currentMonochromeImage, colorImage: currentColorImage)
//        return
//      }
//    }
//    
//    startDownloading()
//  }
//  
//  private func startDownloading() {
//    downloadTask = ImageDownloader().download(url,
//      onSuccess: { monochromeImage, colorImage in
//        self.onSuccess(monochromeImage, colorImage: colorImage)
//      },
//      onAlways: {
//        self.downloadTask = nil
//      }
//    )
//  }
//  
//  func cancel() {
//    if let currentDownloadTask = downloadTask {
//      currentDownloadTask.cancel()
//      downloadTask = nil
//    }
//  }
//  
//  private func onSuccess(monochromeImage: UIImage, colorImage: UIImage) {
//    self.monochromeImage = monochromeImage
//    self.colorImage = colorImage
//    
//    
//    for callback in successCallbacks {
//      callback(monochromeImage, colorImage)
//    }
//    
//    self.successCallbacks = []
//  }
//}
