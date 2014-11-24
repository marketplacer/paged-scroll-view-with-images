//
//  PagesImagesCell.swift
//  paged-scroll-view-with-images
//
//  Created by Evgenii Neumerzhitckii on 24/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class PagedImagesCellView: UIView {
  private let imageView = UIImageView()
  
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
}
