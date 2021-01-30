import Foundation



struct Vehicle: Codable, DataModelProtocol
{
    let name: String?
    let model: String?
    let vehicleClass: String?
    let manufacturer: String?
    let length: String?
    let costInCredits: String?
    let crew: String?
    let passengers: String?
    let maxAtmospheringSpeed: String?
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
                ("Vehicle Class", vehicleClass),
                ("Manufacturer", manufacturer)]
    }
    
    var characters: [String]? { return pilots }
}
