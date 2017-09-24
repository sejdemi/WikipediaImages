import Foundation
import Alamofire

//created WikipediaAPIClient as a final class because no one else should be subclassing this

final class WikipediaAPIClient {

    private static let baseURL = "https://en.wikipedia.org/w/api.php?action=query&prop=pageimages&format=json&piprop=thumbnail&pithumbsize=96&pilimit=50&generator=prefixsearch&gpssearch="
    
    private static let otherInfoURL = "&gpslimit=50"

    static func generateWikipediaImages(for searchTerm: String, completion: @escaping (WikipediaAPIClientResponse) -> ()) {

        let url = baseURL + searchTerm + otherInfoURL
        //the URL will constantly change depending on the water user inputs into the text field
        Alamofire.request(url, method: .get).responseJSON { (response) in

            guard let json = response.result.value else {return}

            if let responseJSON = json as? [String: Any] {

                let imageDetails = getImageDetails(from: responseJSON)
                //                print(imageDetails)
                completion(.success(imageDetails))

            } else {
                completion(.failure(.nodata))
            }
        }
    }
}

private func getImageDetails(from json: [String: Any]) -> [Image] {

    var imageArray = [Image]()

    let queryJSON = json["query"] as? [String: Any] ?? ["": ""]

    let pagesJSON = queryJSON["pages"] as? [String: Any] ?? ["": ""]

    for page in pagesJSON {

        //provide default thumbnail value in case of no existing image
        let image = Image(thumbnail: "https://media.timeout.com/images/103444978/image.jpg")

        let valueJSON = page.value as? [String: Any] ?? ["": ""]

        if let urlJSON = valueJSON["thumbnail"] as? [String: Any]  {
            //continue further subscripting we are finally able to get the URL!
            image.thumbnail = urlJSON["source"] as? String ?? ""
        }

        imageArray.append(image)
    }

    return imageArray
}


//download each image and and pass in the image into the closure
extension WikipediaAPIClient {

    static func downloadImage(at url: URL, handler: @escaping (UIImage?) -> Void) {

        let session = URLSession.shared

        let request = URLRequest(url: url)

        session.dataTask(with: request, completionHandler: { data, response, error in

            DispatchQueue.main.async {

                guard let rawData = data, let image = UIImage(data: rawData)

                    else { handler(nil); return }

                handler(image)
            }

        }).resume() //this actually calls the function
    }
}




/* Initially, I wrote this function like this:

 private func getImageDetails(from json: [String: Any]) -> [Image] {
 //    var imageArray = [Image]()

 let queryJSON = json["query"] as? [String: Any] ?? ["" : ""]

 if let queryJSON = json["query"] as? [String: Any] {
 if let pagesJSON = queryJSON["pages"] as? [String: Any] {
 for page in pagesJSON {
 let image = Image(pageID: "", thumbnail: "")
 if let valueJSON = page.value as? [String: Any]{
 image.title = valueJSON["title"] as? String ?? ""
 if let urlJSON = valueJSON["thumbnail"] as? [String: Any] {
 image.thumbnail = urlJSON["source"] as? String ?? ""
 }
 //                    imageArray.append(image)
 Image.imageArray.append(image)
 //                    print(image.thumbnail)
 }

 }
 }
 }
 return Image.imageArray
 }

 I tried to avoid the pyramid of doom by using the nil coalescing operators instead. I am fully aware that this may not be the best use of error handling, I know that traditionally many people use do, try, catch, but I did not want to make my API Client class' code be particularly long. Just wanted to prove my insight on that.
 */
