//
//  List of custom error codes for this app.
//

import Foundation

enum TegError: Int {
  case HttpCouldNotParseUrlString = 1
  
  // There is a response from server, but it is not 200
  case HttpNot200FromServer = 2
  
  case HttpFailedToConvertResponseToText = 3
  
  // Response is received and is 200 but the iOS app can not accept it for some other reasons,
  // like a parsing error.
  case HttpUnexpectedResponse = 4

  var nsError: NSError {
    let domain = NSBundle.mainBundle().bundleIdentifier ?? "teg.unknown.domain"
    return NSError(domain: domain, code: rawValue, userInfo: nil)
  }
}
