
import UIKit

struct Keys {
    
    fileprivate static let host = "http://www.ferdex.com/BKS/"
    
    struct Url {
        static let version = "\(host)versio.txt"
        static let allData = "\(host)kanjis.txt"
    }
    
    struct Runtime {
        static let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    }
    
    struct View {
        static let elementCornerRadius = CGFloat(8)
        static let elementBorderWidth = CGFloat(1)
        static let lessonCollectionCellSize = Keys.Runtime.isIpad ? CGSize(width: 100, height: 100) : CGSize(width: 50, height: 50)
        static let screenMinSize = UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height ? UIScreen.main.bounds.size.width : UIScreen.main.bounds.size.height
        static let screenCoefficient = CGFloat(Keys.View.screenMinSize / (UIDevice.current.userInterfaceIdiom == .phone ? 320 : 756))
    }
    
    struct FontSize {
        static let textViewCountDownLbl = CGFloat(12)
        static let filterSample = CGFloat(14)
        static let filterValue = CGFloat(14)
    }
    
    struct Symbol {
        static let favoriteFilled = "Ç"
        static let favoriteEmpty = "J"
        static let check = "U"
        static let clearText = "8"
        static let close = "l"
        static let warning = "a"
        static let backBtn = "m"
        static let nextBtn = "n"
    }
}
