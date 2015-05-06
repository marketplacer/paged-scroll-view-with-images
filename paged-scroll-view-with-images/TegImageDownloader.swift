//
//  Downloads image from server.
//  If image is not found it still calls onSuccess callback with 'no image' placeholder image.
//
//  Note: callbacks are called in the main queue.
//
//  To download an image we typically use TegImageDownloadManager class that automatically handles
//  image download cancellation.
//

import UIKit

public class TegImageDownloader {
  private let asyncDownloader = TegAsyncImageDownloader()
  
  public init() { }

  public func download(url: String, onSuccess: (UIImage)->(),
    onAlways: (()->())? = nil) -> NSURLSessionDataTask? {

    return asyncDownloader.download(url,
      onSuccess: { image in
        TegQ.main { onSuccess(image) }
      },
      onAlways: {
        if let onAlways = onAlways {
          TegQ.main { onAlways() }
        }
      }
    )
  }
}
