import Foundation
import Alamofire

//created WikipediaAPIClient as a final class because no one else should be subclassing this

final class WikipediaAPIClient {

     private static let baseURL = "https://en.wikipedia.org/w/api.php?action=query&prop=pageimages&format=json&piprop=thumbnail&pithumbsize=96&pilimit=50&generator=prefixsearch&gpssearch="

    private static let otherInfoURL = "&gpslimit=50"

    static func generateWikipediaImages(for searchTerm: String, completion: @escaping (WikipediaAPIClientResponse) -> ()) {

    print("WikipediaAPIClient.\(#function)")

        let url = baseURL + searchTerm + otherInfoURL
        //print("SpoonacularAPIClient.\(#function) -- \(url)")

        Alamofire.request(url, method: .get).responseJSON {
            (response) in
            if let json = response.result.value {
                if let responseJSON = json as? [[String: Any]] {
                    completion(.success(responseJSON))
                } else {
                    completion(.failure(.nodata))
                }
            }
        }
    }


}
