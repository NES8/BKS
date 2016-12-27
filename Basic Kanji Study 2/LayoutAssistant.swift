
import Foundation
import UIKit

private struct Size {
    static let elementCornerRadius = CGFloat(8)
    static let elementBorderWidth = CGFloat(1)
    static let fontSizeButtonDefault = CGFloat(15)
}

class LayoutAssistant {
    static let sharedInstance = LayoutAssistant()

    static let isPad = UIDevice.current.userInterfaceIdiom == .pad
    static let screenSizeLong: CGFloat = UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height ? UIScreen.main.bounds.size.width : UIScreen.main.bounds.size.height
    static let screenSizeShort: CGFloat = UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height ? UIScreen.main.bounds.size.width : UIScreen.main.bounds.size.height
    static let screenCoefficient: CGFloat = CGFloat(screenSizeShort / (isPad ? 756 : 320))

    
    //MARK: Size
    
    static func sizeAdaptedToScreen(_ size: CGFloat) -> CGFloat {
        return size * screenCoefficient
    }
    
    //MARK: BarButtons
        
    static func barButtonBack(target: AnyObject, action: Selector) -> UIBarButtonItem {
        let barBtn = UIBarButtonItem(title: "m", style: .done, target: target, action: action)
        let attributes = [ NSFontAttributeName : UIFont.symbol(15) ]
        barBtn.setTitleTextAttributes(attributes, for: UIControlState())
        return barBtn
    }
    
    //MARK: Buttons
    
    static func buttonRounded(_ button: UIButton, color: UIColor) {
        button.backgroundColor = .clear
        button.layer.cornerRadius = Size.elementCornerRadius
        button.layer.borderColor = color.cgColor
        button.layer.borderWidth = Size.elementBorderWidth
        button.setTitleColor(color, for: UIControlState())
        button.titleLabel?.font = UIFont.light(Size.fontSizeButtonDefault)
        button.addTarget(LayoutAssistant.sharedInstance, action: #selector(buttonRoundedStateHighlighted(_:)), for: .touchDown)
        button.addTarget(LayoutAssistant.sharedInstance, action: #selector(buttonRoundedStateNormal(_:)), for: .touchUpInside)
        button.addTarget(LayoutAssistant.sharedInstance, action: #selector(buttonRoundedStateNormal(_:)), for: .touchUpOutside)
    }
    
    static func buttonMainMenu(_ button: UIButton, imageName: String) {
        button.layer.cornerRadius = Keys.View.elementCornerRadius
        button.layer.borderWidth = Keys.View.elementBorderWidth
        button.layer.borderColor = UIColor.defaultPrimaryColor().cgColor
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.renderWithColor(.defaultPrimaryColor())
        button.tintColor = .defaultPrimaryColor()
    }

    
    //MARK: Buttons private
    
    @objc fileprivate func buttonRoundedStateHighlighted(_ sender: UIButton) {
        sender.layer.borderColor = sender.titleLabel?.textColor.withAlphaComponent(0.4).cgColor
    }
    
    @objc fileprivate func buttonRoundedStateNormal(_ sender: UIButton) {
        sender.layer.borderColor = sender.titleLabel?.textColor.withAlphaComponent(1.0).cgColor
    }

}
