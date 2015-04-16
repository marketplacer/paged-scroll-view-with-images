//
//  TegPagesControlContainer.swift
//  paged-scroll-view-with-images
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
