//  
//  Singleton HTTP session object.
//
//  Usage:
//
//    TegDownloaderSession.session
//

import Foundation

private let tegSharedDownloaderSession = TegDownloaderSession()

class TegDownloaderSession {
  private let privateSession: NSURLSession!

  private class var shared: TegDownloaderSession {
    return tegSharedDownloaderSession
  }

  class var session: NSURLSession {
    return shared.privateSession
  }

  // Private initializer since this is a singleton class
  // and can only be created with DownloaderSession.sharedDownloader
  private init() {
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    privateSession = NSURLSession(configuration: config)
  }
}
