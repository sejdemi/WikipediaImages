import UIKit

class WikipediaImageViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewCell: UIImageView!


//    weak var wikiImage: Image! {
//        didSet {
//            let thumbnail = wikiImage.thumbnail
//            let url = URL(string: thumbnail)
//            WikipediaAPIClient.downloadImage(at: url!) { (image) in
//                if thumbnail == "" {
//                    self.imageViewCell.image = #imageLiteral(resourceName: "black texture")
//                } else{
//                    self.imageViewCell.image = image
//                }
//            }
//        }
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
