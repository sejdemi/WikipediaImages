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
                if let queryJSON = responseJSON["query"] as? [String: Any] {
                    if let pages = queryJSON["pages"] as? [String: Any] {


                        //                guard let queryResult = responseJSON["query"] else {return }
                        //                    let pageResult = queryResult["pages"]!
//                        print(pages)

                        for image in pages {
                            image.key
                            print(image.key)
                        }
                        completion(.success([responseJSON])) //why is this an array?
                    }
                }

            }else {
                completion(.failure(.nodata))
            }


        }
    }

    private func fetchImageLinksFromJSON(from json: [String: Any]) -> [Image] {
        var imageList = [Image]()

        if let queryResults = json["query"] as? [String: Any] {

            if let pageResults = queryResults["page"] as? [String: Any] {


                for image in pageResults {

//                    if let image = Image(pageID: image.key, thumbnail: "")
                }

            }


        }

        return imageList
    }

    //
    //    private func getImageLinksFromJSON(from json: [String: Any]) -> [Image] {
    //    var imageList = [Image]()
    //    let queries = json["query"] as? [String: Any]
    //    let
    //    
    //    return imageList
    //}
    
}
