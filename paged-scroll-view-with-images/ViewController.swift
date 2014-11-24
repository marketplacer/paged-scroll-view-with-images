//
//  ViewController.swift
//  paged-scroll-view-with-images
//
//  Created by Evgenii Neumerzhitckii on 24/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var pageControl: UIPageControl!

  override func viewDidLoad() {
    super.viewDidLoad()

    loadImages()
    scrollView.delegate = self
  }

  private func loadImages() {
    scrollView.layoutIfNeeded()
    let imageSize = scrollView.bounds.size
    let imageNames = ["gibbon.jpg", "beaver.jpg", "hippo.jpg", "elephant.jpg"]
    PagedScrollViewWithImages.loadImages(imageNames, scrollView: scrollView, imageSize: imageSize)

    setupPageControl(imageNames.count)
  }

  private func setupPageControl(numberOfPages: Int) {
    pageControl.backgroundColor = nil
    pageControl.numberOfPages = numberOfPages
    pageControl.currentPage = 0
  }

  override func shouldAutorotate() -> Bool {
    return false
  }

  override func supportedInterfaceOrientations() -> Int {
    return UIInterfaceOrientation.Portrait.rawValue
  }
}

typealias UIScrollViewDelegate_implementation = ViewController

extension UIScrollViewDelegate_implementation {
  func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    let xOffset = scrollView.contentOffset.x
    let currentPage = Int(xOffset / scrollView.frame.size.width)
    pageControl.currentPage = currentPage
  }
}

