import Foundation
import Alamofire

//created WikipediaAPIClient as a final class because no one else should be subclassing this

final class WikipediaAPIClient {

    private static let baseURL = "https://en.wikipedia.org/w/api.php?action=query&prop=pageimages&format=json&piprop=thumbnail&pithumbsize=96&pilimit=50&generator=prefixsearch&gpssearch="
    private static let otherInfoURL = "&gpslimit=50"

    static func generateWikipediaImages(for searchTerm: String, completion: @escaping (WikipediaAPIClientResponse) -> ()) {
        let url = baseURL + searchTerm + otherInfoURL
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

    if let queryJSON = json["query"] as? [String: Any] {
        if let pagesJSON = queryJSON["pages"] as? [String: Any] {
            for page in pagesJSON {
                let image = Image(pageID: "", thumbnail: "")
                if let valueJSON = page.value as? [String: Any]{
                    image.title = valueJSON["title"] as? String ?? ""
                    if let urlJSON = valueJSON["thumbnail"] as? [String: Any] {
                        image.thumbnail = urlJSON["source"] as? String ?? ""
                    }
                    imageArray.append(image)
                    print(image.thumbnail)
                }
                
            }
        }
    }
    
    return imageArray
}

