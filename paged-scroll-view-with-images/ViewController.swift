//
//  ViewController.swift
//  paged-scroll-view-with-images
//
//  Created by Evgenii Neumerzhitckii on 24/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!

  override func viewDidLoad() {
    super.viewDidLoad()

    loadImages()
  }

  private func loadImages() {
    scrollView.layoutIfNeeded()
    let imageSize = scrollView.bounds.size
    let imageNames = ["gibbon.jpg", "beaver.jpg", "hippo.jpg", "elephant.jpg"]
    PagedScrollViewWithImages.loadImages(imageNames, scrollView: scrollView, imageSize: imageSize)
  }

  override func shouldAutorotate() -> Bool {
    return false
  }

  override func supportedInterfaceOrientations() -> Int {
    return UIInterfaceOrientation.Portrait.rawValue
  }
}

