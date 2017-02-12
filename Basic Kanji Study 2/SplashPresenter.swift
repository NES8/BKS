
import Foundation

class SplashPresenter : BasePresenter {
    private weak var ui: SplashViewController?
    private let navigator: RootNavigator
    
    private let defaults = UserDefaults.standard
    private let kSUD = "FirstUpdate2" //"BonNadal2016"
    
    init(ui: SplashViewController,
         navigator: RootNavigator
        ) {
        self.ui = ui
        self.navigator = navigator
    }
    
    @objc func viewDidAppear() {
        
        let now = NSDate()
        
        if let _ = defaults.object(forKey: kSUD) {
            DBA.sharedInstance.loadDataBase()
            didFinishedSplashScreen()
        } else {
            ui?.showMessage()
            let deadlineTime = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.loadAndUpdateAndShowMessage()
            }
        }
        
        
//        DBA.sharedInstance.loadDataBase()

        print("He trigat \(now.timeIntervalSinceNow * -1) en carregar la base de dades")
        
//        didFinishedSplashScreen()
        
    }
    
    func loadAndUpdateAndShowMessage() {
        DBA.sharedInstance.loadDataBase()
        DBA.sharedInstance.updateDataBase()
        ui?.enableNextBtn()
        defaults.set(true, forKey: kSUD)
    }
    
    func didFinishedSplashScreen() {
        navigator.goToMainMenu()
    }
}
