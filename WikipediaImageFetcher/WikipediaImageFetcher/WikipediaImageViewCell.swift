import UIKit

class WikipediaImageViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewCell: UIImageView!
    weak var delegate: VisibleCellsProtocol!
    var indexPath: Int!

    var image: Image! {
        didSet {
            self.setCellImage()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCellImage() {
        self.image.setImage { _ in
            if self.delegate.visibleCells.contains(self.indexPath) {
                self.image.image = self.image.image
            }
        }
    }
    
    
    
    
}
