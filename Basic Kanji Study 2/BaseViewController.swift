
import UIKit

class BaseViewController : UIViewController {
    
    var lifecyclePresenter: BasePresenter? {
        return nil
    }
    
    lazy var loadingPopupView: LoadingPopupView = {
        let view = UIView.loadFromNibNamed("LoadingPopupView") as! LoadingPopupView
        let side = Keys.View.screenMinSize / 2
        let x = self.view.center.x - side/2
        let y = self.view.center.y - side/2
        view.frame = CGRect(x: x, y: y, width: side, height: side)
        return view
    }()
    
    lazy var messagePopupView: MessagePopupView = {
        let view = UIView.loadFromNibNamed("MessagePopupView") as! MessagePopupView
        let side = Keys.View.screenMinSize / 1.7
        let x = self.view.center.x - side/2
        let y = self.view.center.y - side/2
        view.frame = CGRect(x: x, y: y, width: side, height: side)
        return view
    }()

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
    
    func showLoadingPopUp() {
        self.view.addSubview(self.loadingPopupView)
    }
    
    func hideLoadingPopUp() {
        self.loadingPopupView.removeFromSuperview()
    }
    
    func showError(_ error: ErrorToShow) {
        switch error {
        case .nameNotValid:
            self.messagePopupView.titleLbl.text = "¡Ooops!"
            self.messagePopupView.messageLbl.text = "Por favor, introduce un nombre entre 2 y 20 letras"
        case .emailNotValid:
            self.messagePopupView.titleLbl.text = "¡Ooops!"
            self.messagePopupView.messageLbl.text = "Por favor, introduce un email válido"
        case .phoneNotValid:
            self.messagePopupView.titleLbl.text = "¡Ooops!"
            self.messagePopupView.messageLbl.text = "Por favor, introduce un teléfono válido"
        case .connectionError:
            self.messagePopupView.titleLbl.text = "Error de connexión"
            self.messagePopupView.messageLbl.text = "Por favor, vuelve a intentarlo pasados unos minutos"
        case .taxiIdNotValid:
            self.messagePopupView.titleLbl.text = "Id no válido"
            self.messagePopupView.messageLbl.text = "Por favor, introduce un id de taxi numérico"
        case .priceNotValid:
            self.messagePopupView.titleLbl.text = "Formato incorrecto"
            self.messagePopupView.messageLbl.text = "Por favor, introduce un precio correcto"
        case .messageError(let message):
            self.messagePopupView.titleLbl.text = "¡Error!"
            self.messagePopupView.messageLbl.text = message
        }
    
        self.view.addSubview(self.messagePopupView)
    }
}
