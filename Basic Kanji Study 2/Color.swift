
import Foundation
import UIKit

private struct Palette {

    static let placeHolderColor = UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 1.0)
    
    static let tomato = UIColor(red: 0.9059, green: 0.298, blue: 0.2392, alpha: 1.0) //e74c3d
    static let jadeGreen = UIColor(red: 0.1529, green: 0.6824, blue: 0.3765, alpha: 1.0) //27ea60
    static let orangeLight = UIColor(red: 0.914, green: 0.631, blue: 0.129, alpha: 1.0)
    static let darkGray = UIColor(red: 0.294, green: 0.294, blue: 0.294, alpha: 1.0)
    static let grayText = UIColor(red: 0.753, green: 0.753, blue: 0.753, alpha: 1.0) //c0c0c0
    static let veryDarkGray = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1.0)
    
}

extension UIColor {

    //MARK: Defaults
    
    class func defaultBackgroundColor() -> UIColor {
        return UIColor.init(patternImage: UIImage(named: "bkg1")!)
    }
    
    class func defaultTextColor() -> UIColor {
        return UIColor.darkText
    }
    
    class func seletectTextColor() -> UIColor {
        return UIColor.white
    }
    
    class func defaultFillColor() -> UIColor {
        return UIColor.white.withAlphaComponent(0.3)
    }
    
    class func selectedFillColor() -> UIColor {
        return UIColor.purple
    }
    
    //MARK: Elements
    
//    class func placeHolderTextFieldColor() -> UIColor {
//        return Palette.placeHolderColor
//    }
    
}
