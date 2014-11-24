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
  @IBOutlet weak var pageControl: UIPageControl!

  @IBOutlet var images: YiiPagedImages!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    images.setup()
    loadImages()
  }

  private func loadImages() {
    let imageNames = ["gibbon.jpg", "beaver.jpg", "hippo.jpg", "elephant.jpg"]
    for name in imageNames {
      if let currentImage = UIImage(named: name) {
        images.load(currentImage)
      }
    }
  }
  
  @IBAction func loadMoreImages(sender: AnyObject) {
  }
}

