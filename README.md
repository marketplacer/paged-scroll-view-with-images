# Paged scroll view with images on iOS with Swift

This demo app shows how to display images in a scroll view with page indicator.

Images can be assigned with UIImage object or loaded from server with a URL.


<img src='https://dl.dropboxusercontent.com/u/11143285/bikeexchange/github_images/paged-scroll-view-screenshot.jpg?v=2' width='414' alt='Paged scroll view with image for iOS'>


## Usage

1. Add NSObject to storyboard. Assign `YiiPagedImages` class to it.
1. Make an outlet in your view controller from this NSObject.
1. Add a scroll view to your storyboard and connect it with `scrollView` variable in `YiiPagedImages.swift` file.
1. Call `setup()` method on the object in your ViewController's `viewDidLoad`.
1. Add UIImage with `add` method or load remote image with URL with `addRemote` method.

Use `contentMode` of `YiiPagedImages` to change image scaling mode.

## Attribution

Photos are taken from following sources:

**Gibbon**: http://www.freeimages.com/photo/813595

**Beaver**: http://www.freeimages.com/photo/813598

**Hippo**: http://www.freeimages.com/photo/1354132

**Elephant**: http://www.freeimages.com/photo/1352145

**Leaves** http://www.freeimages.com/photo/1445006?forcedownload=1


## Project Home

[https://github.com/exchangegroup/paged-scroll-view-with-images](https://github.com/exchangegroup/paged-scroll-view-with-images)
