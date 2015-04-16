import UIKit

var TegScreenSizeScale: CGFloat?
let tegScreenSizeBounds = UIScreen.mainScreen().bounds

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
