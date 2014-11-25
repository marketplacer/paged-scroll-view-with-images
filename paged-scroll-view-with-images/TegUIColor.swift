//
//  TegUIColor.swift
//  swippi
//
//  Created by Evgenii Neumerzhitckii on 3/10/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

public class TegUIColor {
  public class func fromHexString(rgba: String) -> UIColor {
    var red: CGFloat   = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat  = 0.0
    var alpha: CGFloat = 1.0
    
    if !rgba.hasPrefix("#") {
      println("Warning: TegUIColor.fromHexString, # character missing")
      return UIColor()
    }
    
    let index = advance(rgba.startIndex, 1)
    let hex = rgba.substringFromIndex(index)
    let scanner = NSScanner(string: hex)
    var hexValue: CUnsignedLongLong = 0
    
    if !scanner.scanHexLongLong(&hexValue) {
      println("Warning: TegUIColor.fromHexString, error scanning hex value")
      return UIColor()
    }

    if countElements(hex) == 6 {
      red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
      green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
      blue  = CGFloat(hexValue & 0x0000FF) / 255.0
    } else if countElements(hex) == 8 {
      red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
      green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
      blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
      alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
    } else {
      println("Warning: TegUIColor.fromHexString, invalid rgb string, length should be 7 or 9")
      return UIColor()
    }
   
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
  }
}
