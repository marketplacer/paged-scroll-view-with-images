//
//  PagesImagesCell.swift
//  paged-scroll-view-with-images
//
//  Created by Evgenii Neumerzhitckii on 24/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class TegPagedImagesCellView: UIView {
  var url: String?
  weak var delegate: TegPagedImagesCellViewDelegate?

  private let imageView = UIImageView()
  private var downloadTask: TegImageDownloadTask?

  internal let imageViewContentMode: UIViewContentMode!

  init(frame: CGRect, contentMode: UIViewContentMode) {
    self.imageViewContentMode = contentMode

    super.init(frame: frame)

    TegPagedImagesCellView.setupImageView(imageView, size: frame.size, contentMode: contentMode)
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
      delegate?.tegPagedImagesCellViewDelegate_onImageTapped(currentImage)
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

      newDownload.download { image in
        self.imagedDownloadComplete(image)
      }

      downloadTask = newDownload
    }
  }

  private func imagedDownloadComplete(image: UIImage) {
    url = nil
    downloadTask = nil
    fadeInImage(image)
  }

  private func fadeInImage(image: UIImage) {
    let downloadedImageView = UIImageView(image: image)
    addSubview(downloadedImageView)

    TegPagedImagesCellView.setupImageView(downloadedImageView, size: frame.size,
      contentMode: imageViewContentMode)

    downloadedImageView.alpha = 0
    UIView.animateWithDuration(0.2, animations: {
      downloadedImageView.alpha = 1
      self.imageView.alpha = 0
      },
      completion: { finished in
        self.showImage(image)
        downloadedImageView.removeFromSuperview()
      }
    )
  }
}
