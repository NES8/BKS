
import Foundation
import UIKit

class CompositionRute {
    static let sharedInstance = CompositionRute()

    weak var navigator : RootNavigator?

    func getMainMenu() -> UIViewController {
        let vc = loadRootViewController("MainMenu") as! MainMenuViewController
        vc.presenter = MainMenuPresenter(view: vc, getStudyConfigUseCase: GetStudyConfigUseCase())
        return vc
    }
    
    //MARK: Private methods
    
    fileprivate func loadRootViewController(_ storyboardName: String) -> UIViewController {
        return loadViewController("Root VC", fromStoryboard: storyboardName)
    }
    
    fileprivate func loadViewController(_ name: String, fromStoryboard storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: name)
    }
}
