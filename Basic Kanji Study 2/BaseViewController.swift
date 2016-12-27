
import UIKit

class BaseViewController : UIViewController {
    
    var lifecyclePresenter: BasePresenter? {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lifecyclePresenter?.viewDidLoad?()
        self.view.backgroundColor = UIColor.defaultBackgroundColor()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lifecyclePresenter?.viewWillAppear?()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lifecyclePresenter?.viewWillDisappear?()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lifecyclePresenter?.viewDidAppear?()
    }
        
    func showError(_ error: ErrorToShow) {
//        switch error {
//        case .priceNotValid:
//            self.messagePopupView.titleLbl.text = "Formato incorrecto"
//            self.messagePopupView.messageLbl.text = "Por favor, introduce un precio correcto"
//        case .messageError(let message):
//            self.messagePopupView.titleLbl.text = "¡Error!"
//            self.messagePopupView.messageLbl.text = message
//        }
//    
//        self.view.addSubview(self.messagePopupView)
    }
}
