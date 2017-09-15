import Foundation

//I thought long and hard about whether or not I needed a model class for this particular challenge. I thought that for organizational purposes I would keep my Image class in arather than having a generic dictionary that had two key, value pairs that conveyed the same thing.
class Image {

    //wanted to keep the title in so as to give the user (you) a little bit of background on what they were looking at
    var title: String
    //the link to the url string is represented by this property
    var thumbnail: String

    init(pageID: String, thumbnail: String) {
        self.title = pageID
        self.thumbnail = thumbnail
    }

}

//not sure we even need an Image class, the API calls themselves treat this model as throw away variables since they are constantly changing



