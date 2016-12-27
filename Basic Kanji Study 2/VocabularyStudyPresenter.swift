
import Foundation

class VocabularyStudyPresenter : BasePresenter {
    
    private let ui: VocabularyStudyViewController
    private let getStudyOrder: GetStudyOrderUseCase
    private let updateFavorte: UpdateFavoriteUseCase
    private let updateList: UpdateListUseCase
    
    private var studyOrders: [StudyOrder]!
    private var orderIndex: Int = 0 {
        didSet {
            if orderIndex >= studyOrders.count {
                orderIndex = 0
            } else if orderIndex < 0 {
                orderIndex = studyOrders.count-1
            }
        }
    }
    
    private var step = 0 {
        didSet {
            if step > 1 {
                step = 0
                orderIndex += 1
            }
        }
    }
    
    //MARK: Init
    
    init(view: VocabularyStudyViewController,
         getStudyOrderUseCase: GetStudyOrderUseCase,
         updateFavorteUseCase: UpdateFavoriteUseCase,
         updateListUseCase: UpdateListUseCase) {
        ui = view
        getStudyOrder = getStudyOrderUseCase
        updateFavorte = updateFavorteUseCase
        updateList = updateListUseCase
    }

    
    func viewDidLoad() {
        let orders = getStudyOrder.execute()
        let list = orders[0].list
        
        if list.favoriteSelected {
            var favoriteOrders = [StudyOrder]()
            for order in orders {
                if order.favorite {
                    favoriteOrders.append(order)
                }
            }
            
            studyOrders = favoriteOrders.count > 0 ? favoriteOrders : orders
            
        } else {
            studyOrders = orders
        }
        
        orderIndex = indexForStudyOrder(id: list.lastStudyOrderIdViewed)
        
        showStep()
    }
    
    private func indexForStudyOrder(id: Int32) -> Int {
        var i = 0
        var found = false
        
        while !found && i<studyOrders.count {
            if studyOrders[i].id == id {
                found = true
            } else {
                i += 1
            }
        }
        
        return found ? i : 0
    }
        
    //MARK: Input
    
    func nextStep() {
        step = step+1
        showStep()
    }
    
    func nextKanji() {
        step = 0
        orderIndex = orderIndex+1
        showStep()
    }
    
    func previousKanji() {
        step = 0
        orderIndex = orderIndex-1
        showStep()
    }
    
    func favoritePressed() {
        let studyOrder = studyOrders[orderIndex]
        let newStatus = !studyOrder.favorite
        updateFavorte.execute(status: newStatus, vocabulary: studyOrder.vocabulary!)
        showFavorite(status: newStatus)
    }
    
    //MARK: Output
    
    private func showStep() {
        
        switch step {
        case 0:
            let studyOrder = studyOrders[orderIndex]
            let counter = String(format: "\(orderIndex+1) / \(studyOrders.count)")
            ui.configStep0(vocabulary: studyOrder.vocabulary!, counter: counter)
            ui.showFavoriteStatus(studyOrder.favorite)
            updateList.execute(lastStudyOrderIdViewed: studyOrder.id)
        case 1:
            ui.configStep1()
        default:
            ui.configStep1()
        }
    }
    
    func showFavorite(status: Bool) {
        ui.showFavoriteStatus(status)
    }
    
}
