//
//  Helper functions to work with strings.
//

import Foundation

public struct TegString {
  public static func blank(text: String) -> Bool {
    let trimmed = text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    return trimmed.isEmpty
  }

  public static func trim(text: String) -> String {
    return text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
  }

  public static func contains(text: String, substring: String,
    ignoreCase: Bool = false,
    ignoreDiacritic: Bool = false) -> Bool {

    var options = NSStringCompareOptions.allZeros

    if ignoreCase { options |= NSStringCompareOptions.CaseInsensitiveSearch }
    if ignoreDiacritic { options |= NSStringCompareOptions.DiacriticInsensitiveSearch }

    return text.rangeOfString(substring, options: options) != nil
  }
  
  //
  // Joins elements of the array into a string with separator.
  // Blank elements are skipped.
  //
  public static func joinNonBlank(array: [String], separator: String ) -> String {
    let nonBlankStrings = array.filter { !self.blank($0) }
    return separator.join(nonBlankStrings)
  }
  
  
  //
  // Returns a single space if string is empty.
  // It is used to set UITableView cells labels as a workaround.
  //
  public static func singleSpaceIfEmpty(text: String) -> String {
    if text == "" {
      return " "
    }
    
    return text
  }
}
