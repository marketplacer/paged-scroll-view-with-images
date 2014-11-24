//
//  TegScreenSize.swift
//  swippi
//
//  Created by Evgenii Neumerzhitckii on 23/09/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

var TegScreenSizeScale: CGFloat?
let tegScreenSizeBounds = UIScreen.mainScreen().bounds

let tegSCreenSizeForDevices = [
  TegScreenType.iPhone: CGPoint(x: 320, y: 480),
  TegScreenType.iPhone5: CGPoint(x: 320, y: 568),
  TegScreenType.iPhone6: CGPoint(x: 375, y: 667),
  TegScreenType.iPhone6Plus: CGPoint(x: 414, y: 736),
  TegScreenType.iPad: CGPoint(x: 768, y: 1024)
]

class TegScreenSize {
  class var minSide: CGFloat {
    let screenSize = tegScreenSizeBounds.size
    return min(screenSize.width, screenSize.height)
  }
  
  class var maxSide: CGFloat {
    let screenSize = tegScreenSizeBounds.size
    return max(screenSize.width, screenSize.height)
  }
  
  class func landscape(view: UIView) -> Bool {
    return view.bounds.width > view.bounds.height
  }

  class func navBarHeight(view: UIViewController) -> CGFloat {
    if let currentNavigationController = view.navigationController {
      return currentNavigationController.navigationBar.frame.size.height
    }

    return 44
  }

  class var scale: CGFloat {
    if TegScreenSizeScale == nil { TegScreenSizeScale = UIScreen.mainScreen().scale }
    return TegScreenSizeScale!
  }
}
