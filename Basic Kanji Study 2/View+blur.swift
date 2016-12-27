
import UIKit

extension UIView {
    
    func blurBackgroundExtraLight() {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.insertSubview(blurEffectView, at: 0)
    }
}
