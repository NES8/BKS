
import UIKit

class SplashViewController: BaseViewController {

    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    var presenter: SplashPresenter!
    override var lifecyclePresenter: BasePresenter? {
        return presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .defaultBackgroundColor()
        
        messageLbl.isHidden = true
        nextBtn.isHidden = true
    }
    
    func showMessage() {
        messageLbl.text = message()
        messageLbl.font = .light(20)
        messageLbl.isHidden = false
        nextBtn.setTitleColor(.selectedFillColor(), for: .normal)
        nextBtn.setTitleColor(UIColor.selectedFillColor().withAlphaComponent(0.4), for: .disabled)
        nextBtn.addTarget(self, action: #selector(nextPushed), for: .touchUpInside)
        nextBtn.titleLabel?.font = .regular(14)
        nextBtn.isEnabled = false
        nextBtn.isHidden = false
    }
    
    func enableNextBtn() {
        nextBtn.isEnabled = true
    }
    
    func nextPushed() {
        presenter.didFinishedSplashScreen()
    }
    
    func message() -> String {
        if UIScreen.main.isNotRetina() {
            return "Hola Lili\n\nDesitjo que t’agradi\naquest regal\nfet amb tota la il·lusió"
        } else if UIScreen.main.isRetinaHD() {
            return "Hola Sergi\n\nEspero que\nhagis passat un\nBon Nadal\ni tinguis un\nFeliç 2017"
        } else {
            return "Carregant...\nUn moment, si us plau"
        }
    }

}
