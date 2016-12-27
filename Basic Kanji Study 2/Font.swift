
import UIKit

private struct Name {
    static let lightForSmallSize = "SFUIText-Light"
    static let lightForBigSize = "SFUIDisplay-Light"
    static let regularForSmallSize = "SFUIText-Regular"
    static let regularForBigSize = "SFUIDisplay-Regular"
    static let semiboldForSmallSize = "SFUIText-Semibold"
    static let semiboldForBigSize = "SFUIDisplay-Semibold"
    static let symbol = "motor"
    static let kanji = "EPSON-KYOKASHO"
}

extension UIFont {
    
    class func light(_ size: CGFloat) -> UIFont {
        let adaptedSize = LayoutAssistant.sizeAdaptedToScreen(size)
        if adaptedSize < 20 {
            return UIFont(name: Name.lightForSmallSize, size: adaptedSize)!
        } else {
            return UIFont(name: Name.lightForBigSize, size: adaptedSize)!
        }
    }
    
    class func regular(_ size: CGFloat) -> UIFont {
        let adaptedSize = LayoutAssistant.sizeAdaptedToScreen(size)
        if adaptedSize < 20 {
            return UIFont(name: Name.regularForSmallSize, size: adaptedSize)!
        } else {
            return UIFont(name: Name.regularForBigSize, size: adaptedSize)!
        }
    }
    
    class func semibold(_ size: CGFloat) -> UIFont {
        let adaptedSize = LayoutAssistant.sizeAdaptedToScreen(size)
        if adaptedSize < 20 {
            return UIFont(name: Name.semiboldForSmallSize, size: adaptedSize)!
        } else {
            return UIFont(name: Name.semiboldForBigSize, size: adaptedSize)!
        }
    }
    
    class func japo(_ size: CGFloat) -> UIFont {
        let adaptedSize = LayoutAssistant.sizeAdaptedToScreen(size)
        return UIFont(name: Name.kanji, size: adaptedSize)!
    }
    
    class func symbol(_ size: CGFloat) -> UIFont {
        let adaptedSize = LayoutAssistant.sizeAdaptedToScreen(size)
        return UIFont(name: Name.symbol, size: adaptedSize)!
    }
}
