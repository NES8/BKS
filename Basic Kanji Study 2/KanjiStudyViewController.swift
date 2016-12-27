
import UIKit
import ACEDrawingView

class KanjiStudyViewController: BaseViewController {

    @IBOutlet weak var kanjiLbl: UILabel!
    @IBOutlet weak var kunyomiLbl: UILabel!
    @IBOutlet weak var onyomiLbl: UILabel!
    @IBOutlet weak var meaningLbl: UILabel!
    @IBOutlet weak var word0Lbl: UILabel!
    @IBOutlet weak var word1Lbl: UILabel!
    @IBOutlet weak var word2Lbl: UILabel!
    @IBOutlet weak var word3Lbl: UILabel!
    @IBOutlet weak var word4Lbl: UILabel!
    @IBOutlet weak var word5Lbl: UILabel!
    @IBOutlet weak var word6Lbl: UILabel!
    @IBOutlet weak var word7Lbl: UILabel!
    @IBOutlet weak var word8Lbl: UILabel!
    @IBOutlet weak var word9Lbl: UILabel!
    @IBOutlet var wordLbls: [UILabel]!
    @IBOutlet weak var lessonLbl: UILabel!
    @IBOutlet weak var counterLbl: UILabel!
    @IBOutlet weak var strokeLbl: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var previousKanjiBtn: UIButton!
    @IBOutlet weak var nextKanjiBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet var clearViews: [UIView]!
    @IBOutlet weak var wordsStackView: UIStackView!
    @IBOutlet weak var kanjiAnimatedImageView: UIImageView!
    
    @IBOutlet weak var blackboardView: UIView!
    @IBOutlet weak var drawView: ACEDrawingView!
    @IBOutlet weak var boardOptionsView: UIView!
    @IBOutlet weak var boardUndoBtn: UIButton!
    @IBOutlet weak var boardCleanBtn: UIButton!
    @IBOutlet weak var kanjiDrawedImageView: UIImageView!
    @IBOutlet weak var kanjiDrawedHeightConstraint: NSLayoutConstraint!
    
    private var didLayoutSubviews = false
    
    var presenter: KanjiStudyPresenter!
    override var lifecyclePresenter: BasePresenter? {
        return presenter
    }

    override func viewDidLoad() {
        configView()
        
        configButtons()

        super.viewDidLoad()
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(nextStepPushed))
//        self.view.addGestureRecognizer(tap)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !didLayoutSubviews {
            didLayoutSubviews = true
            topView.blurBackgroundExtraLight()
            configBlackboard()
            configNextStep()
            kanjiDrawedHeightConstraint.constant = kanjiLbl.bounds.size.height * 0.8
        }
    }
    
    private func configNextStep() {
        let nextStepBtn = UIButton(frame: view.bounds)
        nextStepBtn.addTarget(self, action: #selector(nextStepPushed), for: .touchUpInside)
        view.insertSubview(nextStepBtn, at: 0)

        wordsStackView.isUserInteractionEnabled = false
    }
    
    private func configBlackboard() {
        let imageView = UIImageView(image: UIImage(named: "blackboardBkg"))
        let frame = CGRect(x: 0, y: 0, width: blackboardView.frame.size.width, height: blackboardView.frame.size.height)
        imageView.frame = frame
        blackboardView.insertSubview(imageView, at: 0)
        boardOptionsView.backgroundColor = .clear
        drawView.backgroundColor = .clear
        drawView.lineColor = .white
        drawView.lineWidth = LayoutAssistant.sizeAdaptedToScreen(5)
        configBoardButton(boardUndoBtn)
        configBoardButton(boardCleanBtn)
        boardUndoBtn.addTarget(self, action: #selector(boardUndoPushed), for: .touchUpInside)
        boardCleanBtn.addTarget(self, action: #selector(boardCleanPushed), for: .touchUpInside)
    }
    
    private func configBoardButton(_ button: UIButton) {
        button.setTitleColor(UIColor.selectedFillColor(), for: .normal)
        button.titleLabel?.font = .symbol(14)
        button.backgroundColor = UIColor.defaultFillColor().withAlphaComponent(0.4)
        button.layer.cornerRadius = button.frame.size.width / 2
    }
    
    private func configButtons() {
        backBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        favoriteBtn.addTarget(self, action: #selector(favoritePushed), for: .touchUpInside)
        previousKanjiBtn.addTarget(self, action: #selector(previousKanjiPushed), for: .touchUpInside)
        nextKanjiBtn.addTarget(self, action: #selector(nextKanjiPushed), for: .touchUpInside)
        
        LayoutAssistant.buttonClose(backBtn)
        LayoutAssistant.buttonFavorite(favoriteBtn)
        LayoutAssistant.buttonPreviousElement(previousKanjiBtn)
        LayoutAssistant.buttonNextElement(nextKanjiBtn)
    }
    
    private func configView() {
        kanjiLbl.font = .japo(80)
        kunyomiLbl.font = .japo(20)
        onyomiLbl.font = .japo(20)
        meaningLbl.font = .light(20)
        for lbl in wordLbls {
            lbl.font = .light(14)
        }
        
        LayoutAssistant.topCounterLbl(counterLbl)
        LayoutAssistant.topCounterLbl(lessonLbl)
        LayoutAssistant.topCounterLbl(strokeLbl)
        
        topView.backgroundColor = .clear
        for view in clearViews {
            view.backgroundColor = .clear
            view.isUserInteractionEnabled = false
        }
        
        kanjiAnimatedImageView.layer.cornerRadius = Keys.View.elementCornerRadius
        kanjiAnimatedImageView.clipsToBounds = true
    }
    
    //MARK: Output
    
    private func configKanjiValues(kanji: Kanji, counter: String) {
        kanjiLbl.text = kanji.kanji
        kunyomiLbl.text = kanji.kunyomi
        onyomiLbl.text = kanji.onyomi
        meaningLbl.text = kanji.meaning
        lessonLbl.text = String(format: "L\(kanji.lesson.id)")
        counterLbl.text = counter
        strokeLbl.text = String(format: "(\(kanji.strokes))")
    }

    
    func configKanjiStep0(kanji: Kanji, counter: String) {
        configKanjiValues(kanji: kanji, counter: counter)
        
        kanjiLbl.isHidden = false
        kunyomiLbl.isHidden = true
        onyomiLbl.isHidden = true
        meaningLbl.isHidden = true
        for lbl in wordLbls {
            lbl.isHidden = true
        }
        blackboardView.isHidden = true
    }
    
    func configYomiStep0(kanji: Kanji, counter: String) {
        configKanjiValues(kanji: kanji, counter: counter)
        
        kanjiLbl.isHidden = true
        kunyomiLbl.isHidden = false
        onyomiLbl.isHidden = false
        meaningLbl.isHidden = false
        for lbl in wordLbls {
            lbl.isHidden = true
        }
        drawView.clear()
        blackboardView.isHidden = false
        kanjiDrawedImageView.image = nil
        
        kanjiAnimatedImageView.loadGif(name: String(kanji.id))
        kanjiAnimatedImageView.isHidden = true
    }
    
    func configKanjiStep1(words: [String]) {
        kanjiLbl.isHidden = false
        kunyomiLbl.isHidden = false
        onyomiLbl.isHidden = false
        meaningLbl.isHidden = false

        word0Lbl.text = words.count > 0 ? words[0] : nil
        word1Lbl.text = words.count > 1 ? words[1] : nil
        word2Lbl.text = words.count > 2 ? words[2] : nil
        word3Lbl.text = words.count > 3 ? words[3] : nil
        word4Lbl.text = words.count > 4 ? words[4] : nil
        word5Lbl.text = words.count > 5 ? words[5] : nil
        word6Lbl.text = words.count > 6 ? words[6] : nil
        word7Lbl.text = words.count > 7 ? words[7] : nil
        word8Lbl.text = words.count > 8 ? words[8] : nil
        word9Lbl.text = words.count > 9 ? words[9] : nil
        
        for lbl in wordLbls {
            if let text = lbl.text , text.characters.count > 0 {
                lbl.isHidden = false
            } else {
                lbl.isHidden = true
            }
        }
    }
    
    func configYomiStep1(words: [String]) {
        configKanjiStep1(words: words)
        
        blackboardView.isHidden = true
        kanjiDrawedImageView.image = drawView.image
        kanjiDrawedImageView.renderWithColor(.black)
        kanjiAnimatedImageView.isHidden = false
    }
    
    func configStep2(words: [String]) {
        kanjiLbl.isHidden = false
        kunyomiLbl.isHidden = false
        onyomiLbl.isHidden = false
        meaningLbl.isHidden = false
        
        word0Lbl.text = words.count > 0 ? words[0] : nil
        word1Lbl.text = words.count > 1 ? words[1] : nil
        word2Lbl.text = words.count > 2 ? words[2] : nil
        word3Lbl.text = words.count > 3 ? words[3] : nil
        word4Lbl.text = words.count > 4 ? words[4] : nil
        word5Lbl.text = words.count > 5 ? words[5] : nil
        word6Lbl.text = words.count > 6 ? words[6] : nil
        word7Lbl.text = words.count > 7 ? words[7] : nil
        word8Lbl.text = words.count > 8 ? words[8] : nil
        word9Lbl.text = words.count > 9 ? words[9] : nil
        
        for lbl in wordLbls {
            if let text = lbl.text , text.characters.count > 0 {
                lbl.isHidden = false
            } else {
                lbl.isHidden = true
            }
        }
        kanjiAnimatedImageView.isHidden = true
    }
    
    func showFavoriteStatus(_ status: Bool) {
        let title = status ? Keys.Symbol.favoriteFilled : Keys.Symbol.favoriteEmpty
        
        UIView.performWithoutAnimation {
            favoriteBtn.setTitle(title, for: .normal)
            favoriteBtn.layoutIfNeeded()
        }
    }
    
    //MARK: Input
    
    func nextStepPushed() {
        presenter.nextStep()
    }
    
    func favoritePushed() {
        presenter.favoritePressed()
    }
    
    func nextKanjiPushed() {
        presenter.nextKanji()
    }
    
    func previousKanjiPushed() {
        presenter.previousKanji()
    }
    
    func boardCleanPushed() {
        drawView.clear()
    }
    
    func boardUndoPushed() {
        if drawView.canUndo() {
            drawView.undoLatestStep()
        }
    }
    
    //MARK: Navigation
    
    func close() {
        self.dismiss(animated: true, completion: nil)
    }

}
