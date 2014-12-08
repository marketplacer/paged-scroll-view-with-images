//
//  PagedStoryboardObject.swift
//  paged-scroll-view-with-images
//
//  Created by Evgenii Neumerzhitckii on 24/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class YiiPagedImages: NSObject, UIScrollViewDelegate {
  @IBOutlet weak var scrollView: UIScrollView!
  private let pageControl = UIPageControl()
  private let pagedControlContainer = TegPagedControlContainer()

  weak var delegate: TegPagedImagesCellViewDelegate?

  var contentMode = UIViewContentMode.ScaleAspectFit

  var placeholderImageName = "paged-scroll-view-with-images-placeholder.jpg"

  deinit {
    cancelImageDownloads()
  }

  func setup() {
    scrollView.delegate = self
    pageControl.backgroundColor = nil
    setupPageControl()
  }

  func add(image: UIImage) {
    TegPagedImages.loadImage(image, scrollView: scrollView,
      imageSize: imageSize, contentMode: contentMode, delegate: delegate)

    updateNumberOfPages()
  }

  func addRemote(url: String) {
    TegPagedImages.addUrl(url, scrollView: scrollView, imageSize: imageSize,
      placeholderImage: placeholderImage, contentMode: contentMode, delegate: delegate)

    updateNumberOfPages()
  }

  private func setupPageControl() {
    if let currentSuperview = scrollView.superview {

      currentSuperview.addSubview(pagedControlContainer)
      pagedControlContainer.addSubview(pageControl)
      pagedControlContainer.backgroundColor = TegColors.Shade60.uiColor.colorWithAlphaComponent(0.2)
      pagedControlContainer.layer.cornerRadius = 10

      pagedControlContainer.setTranslatesAutoresizingMaskIntoConstraints(false)
      pageControl.setTranslatesAutoresizingMaskIntoConstraints(false)

      // Align page control container with the bottom of the scroll view
      TegAutolayoutConstraints.alignSameAttributes(pagedControlContainer, toItem: scrollView, constraintContainer: currentSuperview, attribute: NSLayoutAttribute.Bottom, margin: -5)

      // Horizontally center page control container with the scroll view
      TegAutolayoutConstraints.centerX(pagedControlContainer, viewTwo: scrollView, constraintContainer: currentSuperview)

      // Fill page control to the width of its container
      TegAutolayoutConstraints.fillParent(pageControl, parentView: pagedControlContainer, margin: 7,
        vertically: false)

      // Vertically align page control and its container
      TegAutolayoutConstraints.centerY(pageControl, viewTwo: pagedControlContainer,
        constraintContainer: currentSuperview)

      updateNumberOfPages()
    }
  }

  private var imageSize: CGSize {
    scrollView.layoutIfNeeded()
    return scrollView.bounds.size
  }

  private var placeholderImage: UIImage? {
    return UIImage(named: placeholderImageName)
  }

  private func updateNumberOfPages() {
    let numberOfPages = scrollView.subviews.count
    pageControl.numberOfPages = numberOfPages
    pagedControlContainer.invalidateIntrinsicContentSize()
    pagedControlContainer.hidden = numberOfPages < 2
  }

  private func updateCurrentPage() {
    let xOffset = scrollView.contentOffset.x + scrollView.frame.size.width / 2
    let currentPage = Int(xOffset / scrollView.frame.size.width)
    pageControl.currentPage = currentPage
  }

  private func notifyCellAboutTheirVisibility() {
    for cell in cellViews {
      if TegPagedImages.subviewVisible(scrollView, subview: cell) {
        cell.cellIsVisible()
      } else {
        if !TegPagedImages.isSubviewNearScreenEdge(scrollView, subview: cell) {
          // Do not send 'invisible' message to cell if it is still nearby
          // This prevents cancelling download for the cell that was shown for a moment
          // with spring animation
          cell.cellIsInvisible()
        }
      }
    }
  }

  private func cancelImageDownloads() {
    for cell in cellViews {
      cell.cancelImageDownload()
    }
  }

  private var cellViews: [TegPagedImagesCellView] {
    return scrollView.subviews.filter { return $0 is TegPagedImagesCellView }.map { $0 as TegPagedImagesCellView }
  }
}

// UIScrollViewDelegate
// --------------------------

typealias UIScrollViewDelegate_implementation = YiiPagedImages

extension UIScrollViewDelegate_implementation {
  func scrollViewDidScroll(scrollView: UIScrollView) {
    updateCurrentPage()
    notifyCellAboutTheirVisibility()
  }
}