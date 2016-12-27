
import Foundation

class KanjiStudyPresenter : BasePresenter {
    
    private let ui: KanjiStudyViewController
    private let getStudyOrder: GetStudyOrderUseCase
    private let updateFavorte: UpdateFavoriteUseCase
    private let updateList: UpdateListUseCase
    private let isYomi: Bool
    
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
            if step > 2 {
                step = 0
                orderIndex += 1
            }
        }
    }
    
    //MARK: Init
    
    init(view: KanjiStudyViewController,
         getStudyOrderUseCase: GetStudyOrderUseCase,
         updateFavorteUseCase: UpdateFavoriteUseCase,
         updateListUseCase: UpdateListUseCase,
         isYomi: Bool) {
        ui = view
        getStudyOrder = getStudyOrderUseCase
        updateFavorte = updateFavorteUseCase
        updateList = updateListUseCase
        self.isYomi = isYomi
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
    
    //MARK: Get
    
    private func getWords(kanji: Kanji) -> [String] {
        var words = [String]()
        var vocabularies = Array(kanji.vocabularies!)
        
        vocabularies.sort {
            return $0.id < $1.id
        }
        
        for vocabulary in vocabularies {
            words.append(vocabulary.word)
        }
        
        return words
    }
    
    private func getDefinitions(kanji: Kanji) -> [String] {
        var definitions = [String]()
        var vocabularies = Array(kanji.vocabularies!)
        
        vocabularies.sort {
            return $0.id < $1.id
        }
        
        for vocabulary in vocabularies {
            let definition = String("\(vocabulary.word) -- \(vocabulary.reading) -- \(vocabulary.meaning)")
            definitions.append(definition!)
        }
        
        return definitions
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
        updateFavorte.execute(status: newStatus, kanji: studyOrder.kanji!)
        showFavorite(status: newStatus)
    }
    
    //MARK: Output
    
    private func showStep() {
        let studyOrder = studyOrders[orderIndex]
        
        switch step {
        case 0:
            let counter = String(format: "\(orderIndex+1) / \(studyOrders.count)")
            if isYomi {
                ui.configYomiStep0(kanji: studyOrder.kanji!, counter: counter)
            } else {
                ui.configKanjiStep0(kanji: studyOrder.kanji!, counter: counter)
            }
            ui.showFavoriteStatus(studyOrder.favorite)
            updateList.execute(lastStudyOrderIdViewed: studyOrder.id)
        case 1:
            let words = getWords(kanji: studyOrder.kanji!)
            if isYomi {
                ui.configYomiStep1(words: words)
            } else {
                ui.configKanjiStep1(words: words)
            }
        case 2:
            let definitions = getDefinitions(kanji: studyOrder.kanji!)
            ui.configStep2(words: definitions)
        default: break
        }
    }
    
    private func showFavorite(status: Bool) {
        ui.showFavoriteStatus(status)
    }
    
}
