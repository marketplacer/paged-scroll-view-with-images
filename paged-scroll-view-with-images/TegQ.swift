//
//  TegDispatchAsync.swift
//  
//  A shortcut to run code asynchronously or in main queue
//
//  Created by Evgenii Neumerzhitckii on 18/09/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import Foundation

class TegQ {
  class func async(block: ()->()) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
  }
  
  class func main(block: ()->()) {
    dispatch_async(dispatch_get_main_queue(), block)
  }
  
  class func runAfterDelay(delaySeconds: Double, block: ()->()) {
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delaySeconds * Double(NSEC_PER_SEC)))
    dispatch_after(time, dispatch_get_main_queue(), block)
  }
}
