//
//  Helper functions to work with arrays.
//

import Foundation

public struct TegArray {
  public static func getByIndex<T>(index: Int, array: [T]) -> T? {
    if index < 0 || index >= array.count { return nil }
    return array[index]
  }

  public static func uniq<S: SequenceType, E: Hashable where E==S.Generator.Element>(source: S) -> [E] {
    var seen: [E:Bool] = [:]
    return filter(source) { seen.updateValue(true, forKey: $0) == nil }
  }
  
  // Returns the first element for which the condition is true
  public static func firstWhere<T>(array: [T], condition: (T)->(Bool)) -> T? {
    for item in array {
      if condition(item) {
        return item
      }
    }
    
    return nil
  }
  
  public static func removeAtIndexSafe<T>(index: Int, inout array: [T]) {
    if index < 0 || index >= array.count { return }

    array.removeAtIndex(index)
  }
  
  public static func convert<T>(array: [AnyObject]) -> [T] {
    var result = [T]()
    
    for item in array {
      if let item = item as? T {
        result.append(item)
      }
    }
    
    return result
  }
  
  // Convert NSArray to Swift array
  public static func convertNSArray<T>(arr: NSArray) -> [T] {
    var result = [T]()
    for obj in arr {
      if let objCast = obj as? T {
        result.append(objCast)
      }
    }
    
    return result
  }
}
