//
//  DownloaderSession.swift
//  
//  Downloading data from server.
//  Callbacks are called in the main queue.
//
//  Created by Evgenii Neumerzhitckii on 21/08/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import Foundation

class TegDownloader {

  func dataWithUrl(url: String, onSuccess: (NSData, NSHTTPURLResponse?)->(),
    onError: ((NSHTTPURLResponse?, NSError)->())? = nil,
    onAlways: (()->())? = nil) -> NSURLSessionDataTask? {

    return AsyncDownloaderSession.sharedDownloader.dataWithUrl(url,
      onSuccess: { data, response in
        TegQ.main { onSuccess(data, response) }
      },
      onError: { response, error in
        if let currentOnError = onError {
          TegQ.main { currentOnError(response, error) }
        }
      },
      onAlways: {
        if let currentonAlways = onAlways {
          TegQ.main { currentonAlways() }
        }
      }
    )
  }
}
