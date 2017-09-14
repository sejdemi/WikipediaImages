import Foundation


class Image {

    let pageID: String
    let thumbnail: String

    init(pageID: String, thumbnail: String) {
        self.pageID = pageID
        self.thumbnail = thumbnail
    }

}



//class Image  {
//    let thumbnail: String
//    let pageKey: String
//
//    init?(dictionary: [String: Any]) {
//        guard let id = dictionary["query"] as? [String: Any],
//            let pages = id["pages"] as? [String: Any],
//            let pageKey = pages.keys as? String,
//            let pageID = pages[pageKey] as? [String: Any],
//            let source = pageID["thumbnail"] as? [String: Any],
//            let thumbnail = source["source"] as? String else {
//                return nil
//        }
//        
//        self.pageKey = pageKey
//        self.thumbnail = thumbnail
//    }
//    
//}
