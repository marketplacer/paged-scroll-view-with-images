//
//  PagesImagesCell.swift
//  paged-scroll-view-with-images
//

import UIKit

class TegPagedImagesCellView: UIView {
  var url: String?
  weak var delegate: TegPagedImagesCellViewDelegate?
  
  private let imageView = UIImageView()
  private var downloadTask: TegImageDownloadTask?
  private let settings: TegPagedImagesSettings
  
  init(frame: CGRect, settings: TegPagedImagesSettings) {
    self.settings = settings
    
    super.init(frame: frame)
    
    TegPagedImagesCellView.setupImageView(imageView, size: frame.size, contentMode: settings.contentMode)
    addSubview(imageView)
    clipsToBounds = true
    
    setupTap()
  }
  
  private func setupTap() {
    let tapGesture = UITapGestureRecognizer(target: self, action: "respondToTap:")
    addGestureRecognizer(tapGesture)
  }
  
  func respondToTap(gesture: UITapGestureRecognizer) {
    if downloadTask != nil { return } // downloading
    
    if let currentImage = imageView.image {
      delegate?.tegPagedImagesCellViewDelegate_onImageTapped(currentImage, gesture: gesture)
    }
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func showImage(image: UIImage) {
    imageView.alpha = 1
    imageView.image = image
  }
  
  private class func setupImageView(imageView: UIImageView, size: CGSize,
    contentMode:  UIViewContentMode) {
      
      imageView.frame = CGRect(origin: CGPoint(), size: size)
      imageView.contentMode = contentMode
  }
  
  // Called each time the cell is visible on screen when scrolling.
  // Note: called frequently on each scroll event.
  func cellIsVisible() {
    downloadImage()
  }
  
  // Called when cell is not visible on screen. Opposite of cellIsVisible method
  func cellIsInvisible() {
    cancelImageDownload()
  }
  
  func cancelImageDownload() {
    if let currentDownloadTask = downloadTask {
      currentDownloadTask.cancel()
      downloadTask = nil
    }
  }
  
  private func downloadImage() {
    if downloadTask != nil { return } // already downloading
    
    if let currentUrl = url {
      let newDownload = TegImageDownloadTask(url: currentUrl)
      
      newDownload.download { [weak self] image in
        self?.imagedDownloadComplete(image)
      }
      
      downloadTask = newDownload
    }
  }
  
  private func imagedDownloadComplete(image: UIImage) {
    url = nil
    downloadTask = nil
    fadeInImage(image)
  }
  
  func fadeInImage(image: UIImage, showOnlyIfNoImageShown: Bool = false) {
    let tempImageView = UIImageView(image: image)
    addSubview(tempImageView)
    
    TegPagedImagesCellView.setupImageView(tempImageView, size: frame.size,
      contentMode: settings.contentMode)
    
    tempImageView.alpha = 0
    UIView.animateWithDuration(settings.fadeInAnimationDuration, animations: {
        tempImageView.alpha = 1
        self.imageView.alpha = 0
      },
      completion: { finished in
        if !showOnlyIfNoImageShown || self.imageView.image == nil {
          self.showImage(image)
        }
        
        tempImageView.removeFromSuperview()
      }
    )
  }
}
