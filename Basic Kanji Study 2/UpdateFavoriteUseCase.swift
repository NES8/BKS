
import Foundation

class UpdateFavoriteUseCase {
    
    private let listId: Int32
    
    init(listId: Int32) {
        self.listId = listId
    }
    
    func execute(status: Bool, kanji: Kanji) {
        DBA.sharedInstance.setFavorite(status: status, elementWithId: kanji.id, inListWithId: listId)
    }
    
    func execute(status: Bool, vocabulary: Vocabulary) {
        DBA.sharedInstance.setFavorite(status: status, elementWithId: vocabulary.id, inListWithId: listId)
    }
    
}
