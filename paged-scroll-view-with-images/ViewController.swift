//
//  ViewController.swift
//  paged-scroll-view-with-images
//
//  Created by Evgenii Neumerzhitckii on 24/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!

  override func viewDidLoad() {
    super.viewDidLoad()

    loadImages()
  }

  private func loadImages() {
    let imageNames = ["gibbon.jpg", "beaver.jpg", "hippo.jpg", "elephant.jpg"]

    for imageName in imageNames {
      ViewController.loadImage(imageName, scrollView: scrollView)
    }
  }

  private class func loadImage(name: String, scrollView: UIScrollView) {
    
  }
}

