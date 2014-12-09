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

    images.contentMode = UIViewContentMode.ScaleAspectFill
    images.setup()
  }

  @IBAction func addLocalImages(sender: AnyObject) {
    let imageNames = ["beaver.jpg", "hippo.jpg", "elephant.jpg"]
    for name in imageNames {
      if let currentImage = UIImage(named: name) {
        images.add(currentImage)
      }
    }
  }
  
  @IBAction func addRemoteImages(sender: AnyObject) {
    let imageUrls = [
      "https://raw.githubusercontent.com/exchangegroup/paged-scroll-view-with-images/master/graphics/beaver.jpg",
      "https://raw.githubusercontent.com/exchangegroup/paged-scroll-view-with-images/master/graphics/elephant.jpg",
      "https://raw.githubusercontent.com/exchangegroup/paged-scroll-view-with-images/master/graphics/gibbon.jpg",
      "http://unknown.com/image_not_exist.jpg"
    ]
    
    for imageUrl in imageUrls {
      images.addRemote(imageUrl)
    }
  }
}

