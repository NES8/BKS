
import Foundation

class GetStudyOrderUseCase {
    
    private let listId: Int32
    
    init(listId: Int32) {
        self.listId = listId
    }
    
    func execute() -> [StudyOrder] {
        return DBA.sharedInstance.getStudyOrderInList(id: listId)
    }

}
