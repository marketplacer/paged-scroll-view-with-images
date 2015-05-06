//
//  Manages download of an image. It aborts an ongoing download on deinit.
//
//  Note: This class is designed to download a single image. If download(fromUrl:,onSuccess:) method
//    is called multiple times only the first call will work.
//

import UIKit

public class TegSingleImageDownloadManager {
  private var downloadTask: NSURLSessionDataTask?
  public var downloader = TegImageDownloader()
  
  private var downloadStarted = false
  
  public init() { }
  
  deinit {
    cancel()
  }
  
  func download(fromUrl url: String, onSuccess: (UIImage)->()) {
    if downloadStarted { return } // Download started. This class only downloads a single image
    downloadStarted = true
    
    startDownloading(fromUrl: url, onSuccess: onSuccess)
  }
  
  private func startDownloading(fromUrl url: String, onSuccess: (UIImage)->()) {
    downloadTask = downloader.download(url,
      onSuccess: { image in
        onSuccess(image)
      },
      onAlways: { [weak self] in
        self?.downloadTask = nil
      }
    )
  }
  
  private func cancel() {
    downloadTask?.cancel()
    downloadTask = nil
  }
}
