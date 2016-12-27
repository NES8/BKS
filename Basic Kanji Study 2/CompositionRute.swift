
import Foundation
import UIKit

class CompositionRute {
    static let sharedInstance = CompositionRute()

    weak var navigator : RootNavigator?

    func getSplashViewController() -> SplashViewController {
        let vc = loadRootViewController("Splash") as! SplashViewController
        vc.presenter = SplashPresenter(ui: vc, navigator: navigator!)
        return vc
    }

    func getMainMenu() -> UIViewController {
        let vc = loadRootViewController("MainMenu") as! MainMenuViewController
        vc.presenter = MainMenuPresenter(view: vc, navigator: navigator!, studyConfigUseCase: StudyConfigUseCase())
        return vc
    }
    
    func getKanjiStudy(listId: Int32, isYomi: Bool) -> UIViewController {
        let vc = loadRootViewController("KanjiStudy") as! KanjiStudyViewController
        let presenter = KanjiStudyPresenter(view: vc,
                                            getStudyOrderUseCase: GetStudyOrderUseCase(listId: listId),
                                            updateFavorteUseCase: UpdateFavoriteUseCase(listId: listId),
                                            updateListUseCase: UpdateListUseCase(listId: listId),
                                            isYomi: isYomi)
        vc.presenter = presenter
        return vc
    }
    
    func getVocabularyStudy(listId: Int32) -> UIViewController {
        let vc = loadRootViewController("VocabularyStudy") as! VocabularyStudyViewController
        let presenter = VocabularyStudyPresenter(view: vc,
                                                 getStudyOrderUseCase: GetStudyOrderUseCase(listId: listId),
                                                 updateFavorteUseCase: UpdateFavoriteUseCase(listId: listId),
                                                 updateListUseCase: UpdateListUseCase(listId: listId))
        vc.presenter = presenter
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
