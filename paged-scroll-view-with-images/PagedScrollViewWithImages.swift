//
//  PagedScrollViewWithImages.swift
//  paged-scroll-view-with-images
//
//  Created by Evgenii Neumerzhitckii on 24/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class PagedScrollViewWithImages {

  class func loadImages(imageNames: [String], scrollView: UIScrollView, imageSize: CGSize) {
    for (index, imageName) in enumerate(imageNames) {
      let imageView = loadImage(imageName, scrollView: scrollView, imageSize: imageSize)

      let xPosition:CGFloat = CGFloat(index) * imageSize.width

      imageView.frame.origin = CGPoint(
        x: xPosition,
        y: 0
      )
    }

    updateScrollViewContentSize(scrollView)
  }

  private class func loadImage(name: String,
    scrollView: UIScrollView, imageSize: CGSize) -> UIImageView {

    let imageView = createImageView(name)

    imageView.frame = CGRect(origin: CGPoint(), size: imageSize)

    scrollView.addSubview(imageView)

    return imageView
  }

  private class func createImageView(imageName: String) -> UIImageView {
    let imageView = UIImageView()
    imageView.contentMode = UIViewContentMode.ScaleAspectFit

    if let currentImage = UIImage(named: imageName) {
      imageView.image = currentImage
    }
    
    return imageView
  }

  private class func updateScrollViewContentSize(scrollView: UIScrollView) {
    var rightEdge: CGFloat = 0

    for view in scrollView.subviews {
      if let imageView = view as? UIImageView {
        let viewsRightEdge = imageView.frame.origin.x + imageView.frame.width
        if viewsRightEdge > rightEdge {
          rightEdge = viewsRightEdge
        }
      }
    }

    if rightEdge == 0 { return }

    scrollView.contentSize = CGSize(
      width: rightEdge,
      height: scrollView.bounds.height)
  }
}
