import Foundation



struct SearchResult<T: Codable>: Codable
{
    var next: String?
    var previous: String?
    let results: [T]
}
