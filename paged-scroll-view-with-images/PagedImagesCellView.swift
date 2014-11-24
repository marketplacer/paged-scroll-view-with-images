//
//  PagesImagesCell.swift
//  paged-scroll-view-with-images
//
//  Created by Evgenii Neumerzhitckii on 24/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class PagedImagesCellView: UIView {
  var url: String?
  
  private let imageView = UIImageView()
  private var downloadTask: ImageDownloadTask?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupImageView()
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func showImage(image: UIImage) {
    imageView.image = image
  }
  
  private func setupImageView() {
    addSubview(imageView)
    imageView.frame = CGRect(origin: CGPoint(), size: frame.size)
    imageView.contentMode = UIViewContentMode.ScaleAspectFit
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
  
  private func cancelImageDownload() {
    if let currentDownloadTask = downloadTask {
      currentDownloadTask.cancel()
      downloadTask = nil
    }
  }
  
  private func downloadImage() {
    if downloadTask != nil { return } // already downloading
    
    if let currentUrl = url {
      let newDownload = ImageDownloadTask(url: currentUrl)
      
      newDownload.download { image in
        self.imagedDownloadComplete(image)
      }
      
      downloadTask = newDownload
    }
  }
  
  private func imagedDownloadComplete(image: UIImage) {
    url = nil
    showImage(image)
    downloadTask = nil
  }
}
