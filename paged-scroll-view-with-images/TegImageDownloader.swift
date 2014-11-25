//
//  ImageDownloader.swift
//
//  Downloads image from server.
//  If image is not found it still called onSuccess callback with 'no image' placeholder image.
//
//  Callbacks are called in the main queue.
//
//  Created by Evgenii Neumerzhitckii on 25/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class TegImageDownloader {
  class func download(url: String, onSuccess: (UIImage)->(),
    onAlways: (()->())? = nil) -> NSURLSessionDataTask? {

    return TegAsyncImageDownloader.download(url,
      onSuccess: { image in
        TegQ.main { onSuccess(image) }
      },
      onAlways: {
        if let currentOnAlways = onAlways {
          TegQ.main { currentOnAlways() }
        }
      }
    )
  }
}