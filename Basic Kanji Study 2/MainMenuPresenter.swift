
import Foundation

class MainMenuPresenter : BasePresenter {
    
    private let ui: MainMenuViewController
    private let studyConfig: StudyConfigUseCase
    private let navigator: RootNavigator

    init(view: MainMenuViewController,
         navigator: RootNavigator,
         studyConfigUseCase: StudyConfigUseCase) {
        self.ui = view
        self.navigator = navigator
        self.studyConfig = studyConfigUseCase
    }
    
    func viewWillAppear() {
        let studyViewModel = studyConfig.getLast()
        showStudyViewModel(viewModel: studyViewModel)
    }
    
    //MARK: Output
    
    func showStudyViewModel(viewModel: StudyViewModel) {
        ui.showConfiguration(config: viewModel)
    }
    
    //MARK: Input
    
    func startPressed(lessons: [Lesson], random: Bool, studyType: StudyType) {
        let listId = studyConfig.new(lessons: lessons, random: random, studyType: studyType)
        goTo(studyType: studyType, listId: listId)
    }
    
    func resumePressed(studyType: StudyType, favoriteSelected: Bool) {
        studyConfig.resume(studyType: studyType, favoriteSelected: favoriteSelected) { listId in
            self.goTo(studyType: studyType, listId: listId)
        }
    }
    
    //MARK: Navigation
    
    private func goTo(studyType: StudyType, listId: Int32) {
        switch studyType {
        case .kanji:
            navigator.goToKanjiStudy(listId: listId)
        case .vocabulary:
            navigator.goToVocabularyStudy(listId: listId)
        case .yomi:
            navigator.goToYomiStudy(listId: listId)
        }
    }
    
}
