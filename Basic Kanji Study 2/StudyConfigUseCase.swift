
import Foundation

struct StudyViewModel {
    var lessons: [Lesson]!
    var canContinue: Bool = false
    var favoriteSelected: Bool = false
    var randomSelected: Bool = false
    var studyType: StudyType = .kanji
}

class GetStudyConfigUseCase {
    
    func last() -> StudyViewModel {
        
        let lessons = DBA.sharedInstance.getAllLessonsSorted()
        
        if let list = DBA.sharedInstance.getLastList(), let listLessons = list.lessons as? Set<Lesson> {
            for lesson in listLessons {
                let index = Int(lesson.id)
                lessons[index].isSeleted = true
            }
            
            return StudyViewModel(lessons: lessons,
                                              canContinue: true,
                                              favoriteSelected: list.favoriteSelected,
                                              randomSelected: list.random,
                                              studyType: StudyType(rawValue: list.type)!)
        } else {
            return StudyViewModel(lessons: lessons,
                                  canContinue: false,
                                  favoriteSelected: false,
                                  randomSelected: false,
                                  studyType: StudyType.kanji)
        }
    }
}
