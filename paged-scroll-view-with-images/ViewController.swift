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
  
  @IBAction func addMoreImages(sender: AnyObject) {
    let imageUrls = [
      "http://www.furnitureexchange.com.au/dbimages/bike/fn_large/236/100092236/popup/28-10-2013_10-44-03_AM.jpg",
      "http://www.tinitrader.com.au/dbimages/bike/fn_large/336/100183336/popup/Digga_Dog140827576653f09536b9c68.jpg",
      "http://www.renoexchange.com.au//dbimages/bike/fn_large/18/100095018/popup/Hood_and_cabinet.jpg",
      "http://unknown.com/image_not_exist.jpg"
    ]
    
    for imageUrl in imageUrls {
      images.addUrl(imageUrl)
    }
  }
}

