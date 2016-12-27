
import UIKit

class LessonCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = Keys.View.elementBorderWidth
        self.layer.borderColor = UIColor.defaultTextColor().cgColor
        self.layer.cornerRadius = Keys.View.lessonCollectionCellSize.width / 2
        self.clipsToBounds = true
        
        titleLbl.font = .light(20)
    }
    
    func setSelected(selected: Bool) {
        if selected {
            self.backgroundColor = UIColor.selectedFillColor()
            titleLbl.textColor = UIColor.seletectTextColor()
            self.layer.borderColor = UIColor.seletectTextColor().cgColor
        } else {
            self.backgroundColor = UIColor.defaultFillColor()
            titleLbl.textColor = UIColor.defaultTextColor()
            self.layer.borderColor = UIColor.defaultTextColor().cgColor
        }
    }

}
