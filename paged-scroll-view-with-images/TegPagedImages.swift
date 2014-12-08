//
//  PagedScrollViewWithImages.swift
//  paged-scroll-view-with-images
//
//  Created by Evgenii Neumerzhitckii on 24/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class TegPagedImages {
  class func loadImage(image: UIImage, scrollView: UIScrollView,
    imageSize: CGSize, contentMode: UIViewContentMode, delegate: TegPagedImagesCellViewDelegate?) {

      let cell = addCell(scrollView, imageSize: imageSize, contentMode: contentMode)
      cell.delegate = delegate
      cell.showImage(image)
  }

  class func addUrl(url: String, scrollView: UIScrollView, imageSize: CGSize,
    placeholderImage: UIImage?, contentMode: UIViewContentMode,
    delegate: TegPagedImagesCellViewDelegate?) {

      let cell = addCell(scrollView, imageSize: imageSize, contentMode: contentMode)
      cell.delegate = delegate

      if let currentPlaceholderImage = placeholderImage {
        cell.showImage(currentPlaceholderImage)
      }

      cell.url = url
  }

  private class func addCell(scrollView: UIScrollView, imageSize: CGSize,
    contentMode: UIViewContentMode) -> TegPagedImagesCellView {

      let cellFrame = CGRect(
        origin: CGPoint(x: contentRightEdge(scrollView), y:0),
        size: imageSize
      )

      let cell = TegPagedImagesCellView(frame: cellFrame, contentMode: contentMode)
      scrollView.addSubview(cell)
      updateScrollViewContentSize(scrollView)
      return cell
  }

  private class func updateScrollViewContentSize(scrollView: UIScrollView) {
    var rightEdge = contentRightEdge(scrollView)

    if rightEdge == 0 { return }

    scrollView.contentSize = CGSize(
      width: rightEdge,
      height: scrollView.bounds.height)
  }

  private class func contentRightEdge(scrollView: UIScrollView) -> CGFloat {
    var rightEdge: CGFloat = 0

    for view in scrollView.subviews {
      if let cellView = view as? TegPagedImagesCellView {
        let viewsRightEdge = cellView.frame.origin.x + cellView.frame.width
        if viewsRightEdge > rightEdge {
          rightEdge = viewsRightEdge
        }
      }
    }

    return rightEdge
  }

  class func subviewVisible(scrollView: UIScrollView, subview: UIView) -> Bool {
    return CGRectIntersectsRect(scrollView.bounds, subview.frame)
  }

  // When subview is offscreen, is it offscreen by a little?
  // This is used in order NOT to cancel download for cells
  // when scroll view animation overshoots a bit
  // and shows the edge of next cell
  class func isSubviewNearScreenEdge(scrollView: UIScrollView, subview: UIView) -> Bool {
    let maxOffscreenDistance: CGFloat = 50

    // subview is to the right of the visible viewport
    if subview.frame.minX > scrollView.bounds.maxX {
      return abs(subview.frame.minX - scrollView.bounds.maxX) < maxOffscreenDistance
    }

    // subview is to the left of the visible viewport
    if subview.frame.maxX < scrollView.bounds.minX {
      return abs(scrollView.bounds.minX - subview.frame.maxX) < maxOffscreenDistance
    }

    return true
  }
}
