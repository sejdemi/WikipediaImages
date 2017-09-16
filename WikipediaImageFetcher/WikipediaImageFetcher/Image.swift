import Foundation
import UIKit

//I thought long and hard about whether or not I needed a model class for this particular challenge. I thought that for organizational purposes I would keep my Image class in arather than having a generic dictionary that had two key, value pairs that conveyed the same thing. The API gets called so many times so, which made me feel that the Image class was almost "throwaway" variables"
class Image {
    //wanted to keep the title in so as to give the user (you) a little bit of background on what they were looking at
//    var title: String
    //the link to the url string is represented by this property, kept in the force unwrap because I know for a fact that there will be a thumbnail string of some sort. I provide a default in the WikipediaApiClient class.
    var thumbnail: String {

        didSet {

            let url = URL(string: thumbnail)

            //made sure to ensure that the image was weak self to try to decrease reference count and avoid retain cycles/strong reference cycle
            WikipediaAPIClient.downloadImage(at: url!) { (image) in

                    self.image = image
            }
        }
    }

    var image: UIImage?

    init(thumbnail: String) {

        self.thumbnail = thumbnail
    }

}

//download each individual image and specify a true boolean value if successful
extension Image {

    func downloadImage(handler: @escaping (Bool) -> Void) {

        guard let url = URL(string: thumbnail) else { (handler: handler); return }

        WikipediaAPIClient.downloadImage(at: url, handler: { (image) in

            self.image = image

            handler(true)

        })
    }

}

