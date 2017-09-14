import Foundation

final class WikipediaImageDataStore {
    static let shared: WikipediaImageDataStore = WikipediaImageDataStore()
    var generatedImages = [Image]()
    private init() {}

//
//    func fetchGeneratedImagessFromWikipedia(_ completion: @escaping () -> ()) {
//
//        WikipediaAPIClient.generateWikipediaImages(for: "Cat") { (result) in
//            switch result {
//            case .success(let jsonArray):
//                guard let jsonArray = jsonArray as? [[String: Any]] else {return }
//
//                print("The array of JSON is-------", jsonArray)
////                let queryList = jsonArray["query"]
////                print(queryList)
//                completion()
//            case .failure(let error):
//                print("WikipediaImageDataStore.\(#function) -- Failure: \(error)")
//            }
//        }
//    }
    
    
}
