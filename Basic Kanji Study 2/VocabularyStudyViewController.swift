
import UIKit

class VocabularyStudyViewController: BaseViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var kanjiLbl: UILabel!
    @IBOutlet weak var readingLbl: UILabel!
    @IBOutlet weak var meaningLbl: UILabel!
    @IBOutlet weak var counterLbl: UILabel!
    @IBOutlet var clearViews: [UIView]!
    @IBOutlet weak var topView: UIView!
        
    private var didLayoutSubviews = false
    
    var presenter: VocabularyStudyPresenter!
    override var lifecyclePresenter: BasePresenter? {
        return presenter
    }

    override func viewDidLoad() {
        configView()
        
        configButtons()
        
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(nextStepPushed))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !didLayoutSubviews {
            didLayoutSubviews = true
            topView.blurBackgroundExtraLight()
        }
    }
    
    private func configButtons() {
        backBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        favoriteBtn.addTarget(self, action: #selector(favoritePushed), for: .touchUpInside)
        previousBtn.addTarget(self, action: #selector(previousVocabularyPushed), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(nextVocabularyPushed), for: .touchUpInside)
        
        LayoutAssistant.buttonClose(backBtn)
        LayoutAssistant.buttonFavorite(favoriteBtn)
        LayoutAssistant.buttonPreviousElement(previousBtn)
        LayoutAssistant.buttonNextElement(nextBtn)
    }
    
    private func configView() {
        kanjiLbl.font = .japo(70)
        readingLbl.font = .light(30)
        meaningLbl.font = .light(30)
        
        for view in clearViews {
            view.backgroundColor = .clear
        }
        
        topView.backgroundColor = UIColor.selectedFillColor().withAlphaComponent(0.5)
        LayoutAssistant.topCounterLbl(counterLbl)
        
        topView.backgroundColor = .clear

    }

    //MARK: Output
    
    func configStep0(vocabulary: Vocabulary, counter: String) {
        readingLbl.isHidden = true
        meaningLbl.isHidden = true
        
        counterLbl.text = counter
        kanjiLbl.text = vocabulary.word
        readingLbl.text = vocabulary.reading
        meaningLbl.text = vocabulary.meaning
    }
    
    func configStep1() {
        readingLbl.isHidden = false
        meaningLbl.isHidden = false
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
    
    func nextVocabularyPushed() {
        presenter.nextKanji()
    }
    
    func previousVocabularyPushed() {
        presenter.previousKanji()
    }
    
    //MARK: Navigation
    
    func close() {
        self.dismiss(animated: true, completion: nil)
    }

}
