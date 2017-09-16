import Foundation
import UIKit

//I thought long and hard about whether or not I needed a model class for this particular challenge. I thought that for organizational purposes I would keep my Image class in arather than having a generic dictionary that had two key, value pairs that conveyed the same thing.
class Image {

    //wanted to keep the title in so as to give the user (you) a little bit of background on what they were looking at
//    var title: String
    //the link to the url string is represented by this property
    var thumbnail: String {
        didSet {
            let url = URL(string: thumbnail)
            WikipediaAPIClient.downloadImage(at: url!) { (image) in
                if image == nil {
                    self.image = UIImage(named: "black texure.jpg")
                } else{
                    self.image = image
                }
            }
        }
    }
//    var url: URL?
    var image: UIImage?

    init(thumbnail: String) {
//        self.title = pageID
        self.thumbnail = thumbnail
//        self.url = URL(string: thumbnail)
    }

}

//not sure we even need an Image class, the API calls themselves treat this model as throw away variables since they are constantly changing

extension Image {

    func downloadImage(handler: @escaping (Bool) -> Void) {
        guard let url = URL(string: thumbnail) else { (handler: handler); return }
        WikipediaAPIClient.downloadImage(at: url, handler: { image in
            if self.image == nil {
                self.setupNoImage(handler: handler)
                return
            }
            self.image = image
            handler(true)
        })
    }

    func setupNoImage(handler: @escaping (Bool) -> Void) {
        let randomNumber = Int(arc4random_uniform(4))
        let name = "CellBackground" + String(randomNumber)
        image = UIImage(named: "black texture.jpg")!
        handler(true)
    }
}

