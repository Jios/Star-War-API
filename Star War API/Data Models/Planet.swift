import Foundation



struct Planet: Codable, DataModelProtocol
{
    // change to optional
    let name: String
    let diameter: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let gravity: String
    let population: String
    let climate: String
    let terrain: String
    let surfaceWater: String
    let residents: [String]
    let films: [String]
    let url: String
    let created: Date?
    let edited: Date
    
    var displayResouces: [(String, String?)] {
        return [("Name", name),
                ("Diameter", diameter),
                ("Rotation Period", rotationPeriod)]
    }
    
    var species: [String] { return [] }
    var starships: [String] { return [] }
    var vehicles: [String] { return [] }
    var characters: [String] { return residents }
    var planets: [String] { return [] }
}
