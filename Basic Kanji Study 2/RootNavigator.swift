
import UIKit

class RootNavigator {
    
    var compositionRute: CompositionRute
    var currentViewController: UIViewController?
    
    var currentNavigationController: UINavigationController? {
        return currentViewController as? UINavigationController
    }

    func goToMainMenu() {
        let vc = compositionRute.getMainMenu()
        if let appDelegate = UIApplication.shared.delegate, let window = appDelegate.window {
            window!.rootViewController = vc
            UIView.transition(with: window!, duration: 0.35, options: .transitionCrossDissolve, animations: {
                window!.rootViewController = vc
            }, completion: { finished in
                if finished {
                    self.currentViewController = vc
                }
            })
        }
    }

    func goToKanjiStudy(listId: Int32) {
        let vc = compositionRute.getKanjiStudy(listId: listId, isYomi: false)
        currentViewController?.present(vc, animated: true, completion: nil)
    }
    
    func goToYomiStudy(listId: Int32) {
        let vc = compositionRute.getKanjiStudy(listId: listId, isYomi: true)
        currentViewController?.present(vc, animated: true, completion: nil)
    }
    
    func goToVocabularyStudy(listId: Int32) {
        let vc = compositionRute.getVocabularyStudy(listId: listId)
        currentViewController?.present(vc, animated: true, completion: nil)
    }
    
    //MARK: Init
    
    init(compositionRute: CompositionRute) {
        self.compositionRute = compositionRute
        self.compositionRute.navigator = self
    }
    
    convenience init() {
        self.init(compositionRute: CompositionRute.sharedInstance)
    }
    
    func installRootViewController(_ window: UIWindow) {
        let vc = compositionRute.getSplashViewController()
        vc.presenter = SplashPresenter(ui: vc, navigator: self)
        currentViewController = vc
        
        let animation = CATransition()
        animation.duration = 0.35
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = true
        animation.type = kCATransitionFade
        
        window.setRootViewController(vc, transition: animation)
    }

}
