import Foundation



struct Starship: Codable, DataModelProtocol
{
    let name: String?
    let model: String?
    let starshipClass: String?
    let manufacturer: String?
    let costInCredits: String?
    let length: String?
    let crew: String?
    let passengers: String?
    let maxAtmospheringSpeed: String?
    let hyperdriveRating: String?
    let MGLT: String?
    let cargoCapacity: String?
    let consumables: String?
    let films: [String]?
    let pilots: [String]?
    let url: String
    let created: Date?
    let edited: Date?
    
    var displayResouces: [(String, String?)] {
        return [("Name", name),
                ("Created Date", createdDateString),
                ("Edited Date", editedDateString),
                ("Starship Class", starshipClass),
                ("Manufacturer", manufacturer)]
    }
    
    var characters: [String]? { return pilots }
}
