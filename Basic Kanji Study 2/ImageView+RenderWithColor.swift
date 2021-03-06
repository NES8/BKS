
import UIKit

extension UIImageView {
    
    func renderWithColor(_ color: UIColor) {
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}
