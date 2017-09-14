import Foundation

//enum to help us understand what type of error we have, either we have received no data, or an actual error
enum WikipediaAPIClientError: Error {
    case nodata
    case error
}
