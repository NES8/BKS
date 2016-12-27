
import Foundation

class SplashPresenter : BasePresenter {
    private weak var ui: SplashViewController?
    private let navigator: RootNavigator
    
    init(ui: SplashViewController,
         navigator: RootNavigator
        ) {
        self.ui = ui
        self.navigator = navigator
    }
    
    @objc func viewDidAppear() {
        
        let now = NSDate()
        
        let defaults = UserDefaults.standard
        if let _ = defaults.object(forKey: "BonNadal2016") {
            DBA.sharedInstance.loadDataBase()
            didFinishedSplashScreen()
        } else {
            ui?.showMessage()
            let deadlineTime = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.esborrarAquestaPutaMerda()  
            }
        }
        
        
//        DBA.sharedInstance.loadDataBase()

        print("He trigat \(now.timeIntervalSinceNow * -1) en carregar la base de dades")
        
//        didFinishedSplashScreen()
        
    }
    
    func esborrarAquestaPutaMerda() {
        DBA.sharedInstance.loadDataBase()
        ui?.enableNextBtn()
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "BonNadal2016")
    }
    
    func didFinishedSplashScreen() {
        navigator.goToMainMenu()
    }
}
