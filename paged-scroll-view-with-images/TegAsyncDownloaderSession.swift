//
//  DownloaderSession.swift
//  
//  Singleton session object for downloading files.
//  Callbacks are called asynchronously and NOT in the main queue.
//
//  Use TegAsyncDownloaderSession.shared to get the instance.
//
//  Created by Evgenii Neumerzhitckii on 21/08/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import Foundation

private let tegSharedAsyncDownloader = TegAsyncDownloaderSession()

class TegAsyncDownloaderSession {
  private let session: NSURLSession!

  class var shared: TegAsyncDownloaderSession {
    return tegSharedAsyncDownloader
  }

  // Private initializer since this is a singleton class
  // and can only be created with DownloaderSession.sharedDownloader
  private init() {
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    session = NSURLSession(configuration: config)
  }

  func dataWithUrl(url: String,
    onSuccess: (NSData, NSHTTPURLResponse)->(),
    onError: ((NSError, NSHTTPURLResponse?)->())? = nil,
    onAlways: (()->())? = nil) -> NSURLSessionDataTask? {

    if let nsUrl = NSURL(string: url) {
      println("HTTP GET \(url)")
      var task = session.dataTaskWithURL(nsUrl) {
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
      
    return nil
  }
}
