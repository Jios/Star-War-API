import Foundation



struct Vehicle: Codable, DataModelProtocol
{
    let name: String
    let model: String
    let vehicleClass: String
    let manufacturer: String
    let length: String
    let costInCredits: String
    let crew: String
    let passengers: String
    let maxAtmospheringSpeed: String
    let cargoCapacity: String
    let consumables: String
    let films: [String]
    let pilots: [String]
    let url: String
//    let created: Date?    // has inconsistent date formats: .iso8601 and .iso8601 with milliseconds
    let edited: Date
    
    var displayResouces: [(String, String?)] {
        return [("Vehicle Class", vehicleClass),
                ("Manufacturer", manufacturer)]
    }
    var created: Date? { return nil }
    var species: [String] { return [] }
    var starships: [String] { return [] }
    var vehicles: [String] { return [] }
    var characters: [String] { return pilots }
    var planets: [String] { return [] }
}
