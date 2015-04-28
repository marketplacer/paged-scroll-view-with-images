import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var pageControl: UIPageControl!

  @IBOutlet var images: YiiPagedImages!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    images.settings.contentMode = UIViewContentMode.ScaleAspectFill
    images.setup()
  }

  @IBAction func addLocalImages(sender: AnyObject) {
    let imageNames = ["beaver.jpg", "hippo.jpg", "elephant.jpg"]
    for name in imageNames {
      if let image = UIImage(named: name) {
        images.add(image)
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

