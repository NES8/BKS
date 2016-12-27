
import UIKit

extension UIScreen {
    
    public func isNotRetina() -> Bool {
        return UIScreen.main.scale < CGFloat(2.0)
    }
    
    public func isRetina() -> Bool {
        return UIScreen.main.scale == CGFloat(2.0)
    }
    
    public func isRetinaHD() -> Bool {
        return UIScreen.main.scale > CGFloat(2.0)
    }
}
