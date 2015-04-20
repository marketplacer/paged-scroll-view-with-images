import UIKit

enum TegColor: String {
  case Bag = "#2bb999"
  case Heart = "#ea3160"
    
  case Shade10 = "#000000"
  case Shade20 = "#1C1C1C"
  case Shade30 = "#383838"
  case Shade40 = "#545454"
  case Shade50 = "#707070"
  case Shade60 = "#8C8C8C"
  case Shade70 = "#A8A8A8"
  case Shade80 = "#C4C4C4"
  case Shade90 = "#E0E0E0"
  case Shade95 = "#F0F0F0"
  case Shade100 = "#FFFFFF"
  
  var uiColor: UIColor {
    return TegUIColor.fromHexString(rawValue)
  }
}
