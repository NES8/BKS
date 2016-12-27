
import UIKit

enum TargetId {
    case passenger
    case driver
}

struct Keys {
    
    fileprivate static let host = "http://taxiplus.pixind.net/api/v1/"
    
    struct Url {
        static let taxis = "\(host)taxis"
        static let passengers = "\(host)passengers"
        static let runs = "\(host)runs"
    }
    
    struct View {
        static let elementCornerRadius = CGFloat(8)
        static let elementBorderWidth = CGFloat(1)
        static let fontSizeButtonDefault = CGFloat(16)
        static let screenMinSize = UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height ? UIScreen.main.bounds.size.width : UIScreen.main.bounds.size.height
        static let screenCoefficient = CGFloat(Keys.View.screenMinSize / (UIDevice.current.userInterfaceIdiom == .phone ? 320 : 756))
    }
    
    struct FontSize {
        static let textViewCountDownLbl = CGFloat(12)
        static let filterSample = CGFloat(14)
        static let filterValue = CGFloat(14)
    }
    
    struct Symbol {
        static let check = "U"
        static let clearText = "8"
        static let warning = "a"
        static let padlock = "h"
        static let nameEntry = "C"
        static let email = "M"
        static let phone = "r"
        static let backBtn = "m"
        static let taxiBtn = "e"
        static let runsListBtn = "6"
        static let wrench = "t"
    }
    
    struct Text {
        static let sufixCurrency = " €"
    }
}
