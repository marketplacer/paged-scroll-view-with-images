//
//  TegPagesControlContainer.swift
//  paged-scroll-view-with-images
//
//  Created by Evgenii Neumerzhitckii on 25/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class TegPagedControlContainer: UIView {
  override func intrinsicContentSize() -> CGSize {
    if let firstSubview = subviews.first as? UIView {
      return CGSize(
        width: firstSubview.intrinsicContentSize().width,
        height: 20)
    }
    
    return super.intrinsicContentSize()
  }
}
