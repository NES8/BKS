
import UIKit

class MainMenuViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private let cellReuseIdentifier = "Cell"
    private var allLessons = [Lesson]()
    private var didLayoutSubviews = false
    private var favoriteSelected = false
    private var canContinueKanji = false
    private var canContinueVocabulary = false
    private var canContinueYomi = false
    
    @IBOutlet weak var studyTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var course1Btn: UIButton!
    @IBOutlet weak var course2Btn: UIButton!
    @IBOutlet weak var course3aBtn: UIButton!
    @IBOutlet weak var course3bBtn: UIButton!
    
    
    @IBOutlet weak var randomBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var optionsBtn: UIButton!
    @IBOutlet weak var emptyBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var presenter: MainMenuPresenter!
    override var lifecyclePresenter: BasePresenter? {
        return presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.registerNib(nibName: "LessonCell", forCellReuseIdentifier: cellReuseIdentifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 8, right: 0)
        
        configView()    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !didLayoutSubviews {
            didLayoutSubviews = true
            configRandomBtn()
            configResumeBtn()
            configFavoriteBtn()
        }
    }
    
    //MARK: Init View
    
    private func configView() {
        
        collectionView.backgroundColor = .clear
        
        studyTypeSegmentedControl.tintColor = .selectedFillColor()
        
        course1Btn.tintColor = .selectedFillColor()
        course2Btn.tintColor = .selectedFillColor()
        course3aBtn.tintColor = .selectedFillColor()
        course3bBtn.tintColor = .selectedFillColor()
        course1Btn.titleLabel?.font = .light(13)
        course2Btn.titleLabel?.font = .light(13)
        course3aBtn.titleLabel?.font = .light(13)
        course3bBtn.titleLabel?.font = .light(13)
        
        let randomImage = UIImage(named: "icon_random")?.withRenderingMode(.alwaysTemplate)
        randomBtn.setImage(randomImage, for: .normal)
        
        let startImage = UIImage(named: "icon_start")?.withRenderingMode(.alwaysTemplate)
        startBtn.setImage(startImage, for: .normal)
        startBtn.imageView?.renderWithColor(.selectedFillColor())
        
        menuView.backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
        
        optionsBtn.isHidden = true
        emptyBtn.setTitleColor(.clear, for: .normal)        
    }
    
    //MARK: Config View
    
    private func coursePushed(sender: UIButton, course: Int) {
        let courseId = Int16(course)
        let newSeletedValue = !sender.isSelected
        sender.isSelected = newSeletedValue
        for lesson in allLessons {
            if lesson.course == courseId {
                lesson.isSeleted = newSeletedValue
            }
        }
        reloadCollectionView()
    }

    private func configRandomBtn() {
        randomBtn.layer.cornerRadius = randomBtn.frame.size.width / 2
        randomBtn.layer.borderWidth = Keys.View.elementBorderWidth
    }
    
    private func configResumeBtn() {
        continueBtn.setTitleColor(.selectedFillColor(), for: .normal)
        continueBtn.setTitleColor(UIColor.selectedFillColor().withAlphaComponent(0.5), for: .disabled)
        continueBtn.titleLabel?.font = .regular(30)
    }
    
    private func configFavoriteBtn() {
        favoriteBtn.setTitleColor(.selectedFillColor(), for: .normal)
        favoriteBtn.setTitleColor(UIColor.selectedFillColor().withAlphaComponent(0.5), for: .disabled)
        favoriteBtn.titleLabel?.font = .symbol(30)
    }
    
    private func randomBtnSet(selected: Bool) {
        randomBtn.isSelected = selected
        
        if selected {
            randomBtn.imageView?.renderWithColor(.seletectTextColor())
            randomBtn.backgroundColor = .selectedFillColor()
            randomBtn.layer.borderColor = UIColor.seletectTextColor().cgColor
        } else {
            randomBtn.imageView?.renderWithColor(.selectedFillColor())
            randomBtn.backgroundColor = .clear
            randomBtn.layer.borderColor = UIColor.selectedFillColor().cgColor
        }
    }
    
    private func checkIfAtLeastOneLessonIsSelected() -> Bool {
        var found = false
        var i = 0
        while(!found && i<allLessons.count) {
            let lesson = allLessons[i]
            if lesson.isSeleted {
                found = true
            } else {
                i += 1
            }
        }
        return found
    }
    
    private func checkIfAllLessonsOfOneCourseAreSelected(courseId: Int16) -> Bool {
        var found = false
        var i = 0
        while(!found && i<allLessons.count) {
            let lesson = allLessons[i]
            if lesson.course == courseId && !lesson.isSeleted {
                found = true
            } else {
                i += 1
            }
        }
        return !found
    }

    //MARK: Output
    
    func showConfiguration(config: StudyViewModel) {
        canContinueKanji = config.canContinueKanji
        canContinueVocabulary = config.canContinueVocabulary
        canContinueYomi = config.canContinueYomi
        let canContinue = canContinueKanji || canContinueVocabulary || canContinueYomi
        let studySelected = parseStudyTypeToStudySelected(studyType: config.studyType)
        
        studyTypeSegmentedControl.selectedSegmentIndex = studySelected
        allLessons = config.lessons
        continueBtn.isHidden = !canContinue
        favoriteBtn.isHidden = !canContinue
        emptyBtn.isHidden = !canContinue
        
        randomBtnSet(selected: config.randomSelected)
        
        reloadCollectionView()
        
        configRandomBtn()
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
        reloadOptionsAfterLessonChange()
    }
    
    private func reloadOptionsAfterLessonChange() {
        startBtn.isEnabled = checkIfAtLeastOneLessonIsSelected()
        course1Btn.isSelected = checkIfAllLessonsOfOneCourseAreSelected(courseId: Int16(1))
        course2Btn.isSelected = checkIfAllLessonsOfOneCourseAreSelected(courseId: Int16(2))
        course3aBtn.isSelected = checkIfAllLessonsOfOneCourseAreSelected(courseId: Int16(3))
        course3bBtn.isSelected = checkIfAllLessonsOfOneCourseAreSelected(courseId: Int16(4))
    }
    
    //MARK: Input
    
    @IBAction func randomPushed(_ sender: UIButton) {
        randomBtnSet(selected: !sender.isSelected)
    }
    
    @IBAction func course1Pushed(_ sender: UIButton) {
        coursePushed(sender: sender, course: 1)
    }
    
    @IBAction func course2Pushed(_ sender: UIButton) {
        coursePushed(sender: sender, course: 2)
    }

    @IBAction func course3aPushed(_ sender: UIButton) {
        coursePushed(sender: sender, course: 3)
    }
    
    @IBAction func course3bPushed(_ sender: UIButton) {
        coursePushed(sender: sender, course: 4)
    }
    
    @IBAction func startPushed(_ sender: UIButton) {
        let studyType = parseStudySelectedToStudyType(studySelected: studyTypeSegmentedControl.selectedSegmentIndex)
        presenter.startPressed(lessons: allLessons,
                               random: randomBtn.isSelected,
                               studyType: studyType)
    }
    
    @IBAction func resumePushed(_ sender: UIButton) {
        let studyType = parseStudySelectedToStudyType(studySelected: studyTypeSegmentedControl.selectedSegmentIndex)
        presenter.resumePressed(studyType: studyType,
                                favoriteSelected: favoriteSelected)
    }
    
    @IBAction func favoritePushed(_ sender: UIButton) {
        favoriteSelected = !favoriteSelected
        let title = favoriteSelected ? Keys.Symbol.favoriteFilled : Keys.Symbol.favoriteEmpty

        UIView.performWithoutAnimation {
            sender.setTitle(title, for: .normal)
            sender.layoutIfNeeded()
        }
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let studyType = parseStudySelectedToStudyType(studySelected: sender.selectedSegmentIndex)
        switch studyType {
        case .kanji:
            favoriteBtn.isEnabled = canContinueKanji
            continueBtn.isEnabled = canContinueKanji
        case .vocabulary:
            favoriteBtn.isEnabled = canContinueVocabulary
            continueBtn.isEnabled = canContinueVocabulary
        case .yomi:
            favoriteBtn.isEnabled = canContinueYomi
            continueBtn.isEnabled = canContinueYomi
        }
    }
    
    //MARK: Parse
    
    private func parseStudySelectedToStudyType(studySelected: Int) -> StudyType {
        switch studySelected {
        case 0:
            return .kanji
        case 1:
            return .vocabulary
        case 2:
            return .yomi
        default:
            return .kanji
        }
    }
    
    private func parseStudyTypeToStudySelected(studyType: StudyType) -> Int {
        switch studyType {
        case .kanji:
            return 0
        case .vocabulary:
            return 1
        case .yomi:
            return 2
        }
    }

    //MARK: CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allLessons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! LessonCell
        let lessonIndex = allLessons.count - indexPath.row - 1
        let lesson = allLessons[lessonIndex]
        
        cell.titleLbl.text = String(lesson.id)
        cell.setSelected(selected: lesson.isSeleted)
        
        return cell
    }

    //MARK: CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return Keys.View.lessonCollectionCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let lessonIndex = allLessons.count - indexPath.row - 1
        allLessons[lessonIndex].isSeleted = !allLessons[lessonIndex].isSeleted
        collectionView.reloadItems(at: [indexPath])
        reloadOptionsAfterLessonChange()
    }
}
