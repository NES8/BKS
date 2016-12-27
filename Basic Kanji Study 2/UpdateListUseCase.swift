
import Foundation

class UpdateListUseCase {
    
    private let listId: Int32
    
    init(listId: Int32) {
        self.listId = listId
    }

    func execute(lastStudyOrderIdViewed: Int32) {
        DBA.sharedInstance.setLastItemIdViewed(id: lastStudyOrderIdViewed, inListWithId: listId)
    }
    
    func execute(favoriteSelected: Int32) {
        
    }
    
}
