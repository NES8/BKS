
import Foundation
import CoreData

private struct DBKeys {
    static let DataBaseName = "Model2"
    static let KanjiEntityName = "Kanji"
    static let VocabularyEntityName = "Vocabulary"
    static let StudyOrderEntityName = "StudyOrder"
    static let ListEntityName = "List"
    static let MinIdValue = Int32(1)
    static let IdAttributeName = "id"
    static let LessonEntityName = "Lesson"
    static let LastAccessAttributeName = "lastAccessDate"
}

private struct SUDKeys {
    static let DBVersion = "DB version SUD"
}

class DBA {
    static let sharedInstance = DBA()
    
    private var newIdForVocabulary: Int32!
    private var newIdForOrder: Int32!
    private var newIdForList: Int32!
    private var lessonsDict = [Int32 : Lesson]()
    
    var dbVersion: Float! {
        get {
            if let value = UserDefaults.standard.value(forKey: SUDKeys.DBVersion) {
                return value as! Float
            } else {
                return 1
            }
        }
        set {
            UserDefaults.standard.set(dbVersion, forKey: SUDKeys.DBVersion)
        }
    }
    
    //MARK: Get
    
    func getStudyOrderInList(id: Int32) -> [StudyOrder] {
        let predicate = NSPredicate(format: "list.id == %d", id)
        return getAllManagedObjectsSortedById(forEntity: DBKeys.StudyOrderEntityName, withPredicate: predicate) as! [StudyOrder]
    }
    
//    func getKanjiInList(id: Int32) -> ([Kanji], Int32) {
//        let predicate = NSPredicate(format: "list.id == %d", id)
//        let studyOrders = getAllManagedObjectsSortedById(forEntity: DBKeys.StudyOrderEntityName, withPredicate: predicate) as! [StudyOrder]
//        var kanjis = [Kanji]()
//        
//        for order in studyOrders {
//            kanjis.append(order.kanji!)
//        }
//        return (kanjis, (studyOrders[0].list?.lastItemViewed)!)
//    }
    
    func getAllLessonsSorted() -> [Lesson] {
        return getAllManagedObjectsSortedById(forEntity: DBKeys.LessonEntityName) as! [Lesson]
    }
    
//    func getLessonsWithSelected() -> [Lesson] {
//
//        let lessons = getAllManagedObjectsSortedById(forEntity: DBKeys.LessonEntityName) as! [Lesson]
//        
//        if let list = getLastList() {
//            for lesson in list.lessons! {
//                let index = Int(lesson.id)
//                lessons[index].isSeleted = true
//            }
//        }
//                
//        return lessons
//    }
    
    func getLastList(studyType: StudyType?) -> List? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: DBKeys.ListEntityName)
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: DBKeys.LastAccessAttributeName, ascending: false)]
        
        if let studyType = studyType {
            let predicate = NSPredicate(format: "type == %@", studyType.rawValue)
            fetchRequest.predicate = predicate
        }
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            if results.count > 0 {
                return results.first as? List
            } else {
                return nil
            }
        } catch {
            fatalError("ERROR getLastList")
        }

    }
    
    //MARK: Add
    
    func addList(selectedLessonsIds: [Int32], random: Bool, studyType: StudyType) -> Int32 {
        
        let list = addOrCreateManagedObject(withId: newIdForList, forEntity: DBKeys.ListEntityName) as! List
        list.creationDate = NSDate()
        list.lastAccessDate = NSDate()
        list.random = random
        list.lastStudyOrderIdViewed = 0
        list.type = studyType.rawValue
        list.favoriteSelected = false //??
        
        for id in selectedLessonsIds {
            list.addToLessons(lessonsDict[id]!)
        }
        
        if case studyType = StudyType.vocabulary {
            
            var words = [Vocabulary]()

            if random {
                var selectedWords = [Vocabulary]()
                
                for lesson in list.lessons! {
                    for kanji in lesson.kanjis! {
                        let vocaArray = Array(kanji.vocabularies!)
                        selectedWords.append(contentsOf: vocaArray)
                    }
                }
                
                while selectedWords.count > 0 {
                    let randomIndex = Range(0 ..< selectedWords.count).randomInt
                    words.append(selectedWords[randomIndex])
                    selectedWords.remove(at: randomIndex)
                }
                
            } else { //Sorted
                
                var predicates = [NSPredicate]()
                for lesson in list.lessons! {
                    let predicate = NSPredicate(format: "kanji.lesson.id == %d", lesson.id)
                    predicates.append(predicate)
                }
                
                let predicate: NSPredicate = NSCompoundPredicate(type: .or, subpredicates: predicates)
                
                words = getAllManagedObjectsSortedById(forEntity: DBKeys.VocabularyEntityName, withPredicate: predicate) as! [Vocabulary]
            }
            
            //Create Order
            
            for word in words {
                
                let order = addOrCreateManagedObject(withId: newIdForOrder, forEntity: DBKeys.StudyOrderEntityName) as! StudyOrder
                order.favorite = false
                order.vocabulary = word
                order.list = list
                
                newIdForOrder = newIdForOrder+1
            }

        } else { //Kanji or Yomi study type
            
            var kanjis = [Kanji]()
            
            //Get kanjis
            
            if random {
                var selectedKanjis = [Kanji]()
                
                for lesson in list.lessons! {
                    let lessonKanjis = Array(lesson.kanjis!)
                    selectedKanjis.append(contentsOf: lessonKanjis)
                }
                
                while selectedKanjis.count > 0 {
                    let randomIndex = Range(0 ..< selectedKanjis.count).randomInt //Range(0 ... selectedKanjis.count-1) is more efficient
                    kanjis.append(selectedKanjis[randomIndex])
                    selectedKanjis.remove(at: randomIndex)
                }
                
            } else { //Sorted
                
                var predicates = [NSPredicate]()
                for lesson in list.lessons! {
                    let predicate = NSPredicate(format: "lesson.id == %d", lesson.id)
                    predicates.append(predicate)
                }
                
                let predicate: NSPredicate = NSCompoundPredicate(type: .or, subpredicates: predicates)
                
                kanjis = getAllManagedObjectsSortedById(forEntity: DBKeys.KanjiEntityName, withPredicate: predicate) as! [Kanji]
            }
            
            //Create Order
            
            for kanji in kanjis {
                
                let order = addOrCreateManagedObject(withId: newIdForOrder, forEntity: DBKeys.StudyOrderEntityName) as! StudyOrder
                order.favorite = false
                order.kanji = kanji
                order.list = list
                
                newIdForOrder = newIdForOrder+1
            }
        }
        
        newIdForList = newIdForList+1
        
        saveMainContext()
        
        return list.id
    }
    
    private func addKanji(num id: Int32,
                          lesson lessonNumber: Int32,
                          kanji: String,
                          strokes: Int16,
                          meaning: String,
                          kunyomi: String,
                          onyomi: String) -> Kanji {
        let newKanji = addOrCreateManagedObject(withId: id, forEntity: DBKeys.KanjiEntityName) as! Kanji
        newKanji.kanji = kanji
        newKanji.strokes = strokes
        newKanji.meaning = meaning
        newKanji.kunyomi = kunyomi
        newKanji.onyomi = onyomi

        if let lessonObject = lessonsDict[lessonNumber] {
            newKanji.lesson = lessonObject
        } else {
            let lessonObject = addOrCreateManagedObject(withId: lessonNumber, forEntity: DBKeys.LessonEntityName) as! Lesson
            lessonObject.course = parseLessonNumberToCourse(lessonNumber: lessonNumber)
            newKanji.lesson = lessonObject
            self.lessonsDict[lessonNumber] = lessonObject
        }
    
        return newKanji
    }
    
    private func addVocabulary(word: String,
                               reading: String,
                               meaning: String,
                               kanji: Kanji) {
        let newVocabulary = addOrCreateManagedObject(withId: self.newIdForVocabulary, forEntity: DBKeys.VocabularyEntityName) as! Vocabulary
        newVocabulary.word = word
        newVocabulary.reading = reading
        newVocabulary.meaning = meaning
        newVocabulary.kanji = kanji
        
        self.newIdForVocabulary = self.newIdForVocabulary+1
    }
    
    //MARK: Update
    
    func setFavorite(status: Bool, elementWithId elementId: Int32, inListWithId listId: Int32) {

        let predicate = NSPredicate(format: "list.id == %d AND (kanji.id == %d OR vocabulary.id == %d)", listId, elementId, elementId)
        let studyOrders = getAllManagedObjectsSortedById(forEntity: DBKeys.StudyOrderEntityName, withPredicate: predicate) as! [StudyOrder]
        
        guard studyOrders.count == 1 else {
            fatalError("ERROR updating a favorite")
        }
        
        let order = studyOrders[0]
        order.favorite = status

        saveMainContext()
    }
    
    func setLastItemIdViewed(id: Int32, inListWithId listId: Int32) {
        let list = getManagedObject(withId: listId, inEntity: DBKeys.ListEntityName) as! List
        
        list.lastStudyOrderIdViewed = id
        list.lastAccessDate = NSDate()
        
        saveMainContext()
    }
    
    func setFavoriteSelected(favoriteSelected: Bool, inListWithId listId: Int32) {
        let list = getManagedObject(withId: listId, inEntity: DBKeys.ListEntityName) as! List
        
        list.favoriteSelected = favoriteSelected
        
        saveMainContext()
    }
    
    //MARK: Parse
    
    func insertDataText(text: String, callback: () -> Void) {
        let lines = text.components(separatedBy: "@")
        
        guard lines.count > 0 else {
            return
        }
        
        for (index, element) in lines.enumerated() {
            print("\(index) = \(element)")
            let line = element.components(separatedBy: "\t")
            
            if line.count >= 8 { //8 és el mínim de columnes que ha de tenir un kanji en l'excel
                
                let kanji = addKanji(num: Int32(line[0])!,
                                     lesson: Int32(line[1])!,
                                     kanji: line[2],
                                     strokes: Int16(line[3])!,
                                     meaning: line[4],
                                     kunyomi: line[5],
                                     onyomi: line[6])
                
                var i = 7
                while i<line.count {
                    if line[i].characters.count > 0 {
                        print("add word[\(i)]: \(line[i])")
                        addVocabulary(word: line[i],
                                      reading: line[i+1],
                                      meaning: line[i+2],
                                      kanji: kanji)
                    }

                    i = i+3
                }
            }
        }
        
        saveMainContext()
        
        callback()
    }
    
    private func parseLessonNumberToCourse(lessonNumber: Int32) -> Int16 {
        if lessonNumber <= 12 {
            return Int16(1)
        } else if lessonNumber <= 24 {
            return Int16(2)
        } else if lessonNumber <= 36 {
            return Int16(3)
        } else if lessonNumber <= 48 {
            return Int16(4)
        } else {
            return Int16(5)
        }
    }
    
    //MARK: Init
        
    func loadDataBase() {
        newIdForVocabulary = getNewId(forEntity: DBKeys.VocabularyEntityName)
        newIdForOrder = getNewId(forEntity: DBKeys.StudyOrderEntityName)
        newIdForList = getNewId(forEntity: DBKeys.ListEntityName)
        
        let allLessons = getAllManagedObjectsSortedById(forEntity: DBKeys.LessonEntityName) as! [Lesson]
        if allLessons.count == 0 {
            loadInitialData()
        } else {
            for lesson in allLessons {
                self.lessonsDict[lesson.id] = lesson
            }
        }
        
        print("Data base loaded")
    }
    
    private func loadInitialData() {
        guard let filePath = Bundle.main.path(forResource: "InitialData", ofType: "txt") else {
            fatalError("ERROR InitialData.txt not found")
        }
        
        do {
            let text = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
            insertDataText(text: text) {
                print("Initial Data Inserted in data base")
            }
        } catch {
            fatalError("ERROR reading InitialData.txt \(error)")
        }
    }
    
    //MARK: Private methods
    
    private func getManagedObject(withId id: Int32, inEntity entityName: String) -> NSManagedObject {
        let predicate = NSPredicate(format: "id == %d", id)
        let allObjects = getAllManagedObjectsSortedById(forEntity: entityName, withPredicate: predicate)
        
        guard allObjects.count == 1 else {
            fatalError("ERROR getting managed object by id")
        }
        
        return allObjects.first!
    }
    
    private func getNewId(forEntity entityName: String) -> Int32 {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: DBKeys.IdAttributeName, ascending: false)]
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            if results.count > 0 {
                let max = results.first
                let id = max?.value(forKey: DBKeys.IdAttributeName) as! Int32
                return id+1
            } else {
                return DBKeys.MinIdValue
            }
        } catch {
            fatalError("ERROR fetching for getNewId")
        }
    }
    
    private func addOrCreateManagedObject(withId id: Int32, forEntity entityName: String) -> NSManagedObject {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext) else {
            fatalError("ERROR: Could not find entity name \(entityName)")
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            if results.count > 0 {  // exist
                return results[0] as! NSManagedObject
            } else {                //create
                let managedObject = NSManagedObject(entity: entity, insertInto: managedObjectContext)
                managedObject.setValue(id, forKey: DBKeys.IdAttributeName)
                return managedObject
            }
        } catch {
            fatalError("ERROR fetching for addOrCreateManagedObject")
        }
    }
    
    private func getAllManagedObjectsSortedById(forEntity entityName: String,
                                                withPredicate predicate: NSPredicate? = nil) -> [NSManagedObject] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: DBKeys.IdAttributeName, ascending: true)]
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            return results
        } catch {
            fatalError("ERROR fetching for getAllManagedObjectsSortedByIdForEntity: \(entityName)")
        }
    }
    
    //MARK: DataBase Administrator methods
    
    private func saveMainContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                fatalError("Error saving main managed object context! \(error)")
            }
        }
    }
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: DBKeys.DataBaseName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    private lazy var applicationDocumentsDirectory: URL = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let persistentStoreURL = self.applicationDocumentsDirectory.appendingPathComponent("\(DBKeys.DataBaseName).sqlite")
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                               configurationName: nil,
                                               at: persistentStoreURL,
                                               options: nil)
        } catch {
            fatalError("Persistent store error! \(error)")
        }
        
        return coordinator
    }()
    
    private lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()

}
