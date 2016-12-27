
import Foundation

struct StudyViewModel {
    var lessons: [Lesson]!
    var canContinueKanji: Bool = false
    var canContinueVocabulary: Bool = false
    var canContinueYomi: Bool = false
    var favoriteSelected: Bool = false
    var randomSelected: Bool = false
    var studyType: StudyType = .kanji
}

class StudyConfigUseCase {
    
    var lastKanjiListId: Int32?
    var lastVocabularyListId: Int32?
    var lastYomiListId: Int32?
    
    func getLast() -> StudyViewModel {
        
        let lessons = DBA.sharedInstance.getAllLessonsSorted()
        
        if let list = DBA.sharedInstance.getLastList(studyType: nil) {
            var resumeKanji = false
            var resumeVocabulary = false
            var resumeYomi = false
            
            if let kanjiList = DBA.sharedInstance.getLastList(studyType: .kanji) {
                resumeKanji = true
                lastKanjiListId = kanjiList.id
            }
            
            if let vocabularyList = DBA.sharedInstance.getLastList(studyType: .vocabulary) {
                resumeVocabulary = true
                lastVocabularyListId = vocabularyList.id
            }
            
            if let yomiList = DBA.sharedInstance.getLastList(studyType: .yomi) {
                resumeYomi = true
                lastYomiListId = yomiList.id
            }
            
            for lesson in list.lessons! {
                let index = Int(lesson.id-1) //TODO: Això és una puta guarrada
                lessons[index].isSeleted = true
            }
            
            return StudyViewModel(lessons: lessons,
                                  canContinueKanji: resumeKanji,
                                  canContinueVocabulary: resumeVocabulary,
                                  canContinueYomi: resumeYomi,
                                  favoriteSelected: list.favoriteSelected,
                                  randomSelected: list.random,
                                  studyType: StudyType(rawValue: list.type)!)
        } else {
            return StudyViewModel(lessons: lessons,
                                  canContinueKanji: false,
                                  canContinueVocabulary: false,
                                  canContinueYomi: false,
                                  favoriteSelected: false,
                                  randomSelected: false,
                                  studyType: StudyType.kanji)
        }
    }
    
    func new(lessons: [Lesson], random: Bool, studyType: StudyType) -> Int32 {
        var selectedLessonsIds = [Int32]()
        
        for lesson in lessons {
            if lesson.isSeleted {
                selectedLessonsIds.append(lesson.id)
            }
        }
        
        let listId = DBA.sharedInstance.addList(selectedLessonsIds: selectedLessonsIds,
                                                random: random,
                                                studyType: studyType)
        
        return listId
    }
    
    func resume(studyType: StudyType, favoriteSelected: Bool, callback: @escaping (Int32) -> ()) {
        var lastListId: Int32?
        
        switch studyType {
        case .kanji:
            lastListId = lastKanjiListId
        case .vocabulary:
            lastListId = lastVocabularyListId
        case .yomi:
            lastListId = lastYomiListId
        }
        
        guard let listId = lastListId else {
            print("ERROR: ListId not found when resuming")
            return
        }
        
        DBA.sharedInstance.setFavoriteSelected(favoriteSelected: favoriteSelected, inListWithId: listId)
        callback(listId)
    }
    
}
