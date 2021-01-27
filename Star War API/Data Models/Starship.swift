import Foundation



struct Starship: Codable, DataModelProtocol
{
    let name: String
    let model: String
    let starshipClass: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let crew: String
    let passengers: String
    let maxAtmospheringSpeed: String
    let hyperdriveRating: String
    let MGLT: String
    let cargoCapacity: String
    let consumables: String
    let films: [String]
    let pilots: [String]
    let url: String
    let created: Date?
    let edited: Date
    
    var displayResouces: [(String, String?)] {
        return [("Starship Class", starshipClass),
                ("Manufacturer", manufacturer)]
    }
    
    var species: [String] { return [] }
    var starships: [String] { return [] }
    var vehicles: [String] { return [] }
    var characters: [String] { return pilots }
    var planets: [String] { return [] }
}
