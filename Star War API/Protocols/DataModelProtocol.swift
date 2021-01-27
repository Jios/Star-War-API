import Foundation



protocol DataModelProtocol
{
    var url: String { get }
    var name: String { get }
    
    // basic info section
    var displayResouces: [(String, String?)] { get }
    
    // additional sections
    var films: [String] { get }
    var species: [String] { get }
    var starships: [String] { get }
    var vehicles: [String] { get }
    var characters: [String] { get }
    var planets: [String] { get }
    
    // dates
    var edited: Date { get }
    var editedDateString: String? { get }
    
    // note: disable created date because Vehicle object has inconsistent date formats: .iso8601 and .iso8601 with milliseconds
//    var created: Date? { get }
//    var createdDateString: String? { get }
}

extension DataModelProtocol
{
//    var createdDateString: String? { return created?.string }
    var editedDateString: String?  { return edited.string  }
}
