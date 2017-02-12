
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
        return "Informació:\n\nL’app desa cada un dels últims casos d’estudi (kanji, vocabulari, yomi), de forma que amb el botó ‘continuar’ es pot seguir on s'estava.\n\nL’ordre (random o no) queda definit el primer cop. Els favorits són propis de cada cas d’estudi."
    }

}
