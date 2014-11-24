//
//  DownloaderSession.swift
//  
//  Singleton session object for downloading files.
//  Callbacks are called asynchronously and NOT in the main queue.
//
//  Use DownloaderSession.sharedDownloader to get the instance.
//
//  Created by Evgenii Neumerzhitckii on 21/08/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import Foundation

private let _sharedAsyncDownloader = AsyncDownloaderSession()

class AsyncDownloaderSession {
  private let session: NSURLSession!

  class var sharedDownloader: AsyncDownloaderSession {
    return _sharedAsyncDownloader
  }

  // Private initializer since this is a singleton class
  // and can only be created with DownloaderSession.sharedDownloader
  private init() {
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    session = NSURLSession(configuration: config)
  }

  func dataWithUrl(url: String, onSuccess: (NSData, NSHTTPURLResponse?)->(),
    onError: ((NSHTTPURLResponse?, NSError)->())? = nil,
    onAlways: (()->())? = nil) -> NSURLSessionDataTask? {

    if let nsUrl = NSURL(string: url) {
      var task = session.dataTaskWithURL(nsUrl) {
        (data, response, error) in

        if let alwaysHandler = onAlways {
          alwaysHandler()
        }
        
        let httpResponse = response as? NSHTTPURLResponse
          
        if httpResponse == nil {
          if let errorHandler = onError {
            errorHandler(httpResponse, error)
          }
          
          return
        }

        if error != nil {
          if let errorHandler = onError {
            errorHandler(httpResponse, error)
          }

          return
        }

        onSuccess(data, httpResponse)
      }
      task.resume()
      return task
    }
      
    return nil
  }
}
