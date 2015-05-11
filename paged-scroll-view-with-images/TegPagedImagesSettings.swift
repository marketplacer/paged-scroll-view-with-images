import UIKit

public struct TegPagedImagesSettings {
  public var fadeInAnimationDuration: NSTimeInterval = 0.3
  public var contentMode = UIViewContentMode.ScaleAspectFit
  public var placeholderImageName = "paged-scroll-view-with-images-placeholder.png"
  public var singleImageDownloadImageFactory = TegSingleImageDownloadManagerFactory()
}
