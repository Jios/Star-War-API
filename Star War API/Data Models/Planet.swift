import Foundation



struct Planet: Codable, DataModelProtocol
{
    let name: String?
    let diameter: String?
    let rotationPeriod: String?
    let orbitalPeriod: String?
    let gravity: String?
    let population: String?
    let climate: String?
    let terrain: String?
    let surfaceWater: String?
    let residents: [String]?
    let films: [String]?
    let url: String
    let created: Date?
    let edited: Date?
    
    var displayResouces: [(String, String?)] {
        return [("Name", name),
                ("Created Date", createdDateString),
                ("Edited Date", editedDateString),
                ("Diameter", diameter),
                ("Rotation Period", rotationPeriod)]
    }
    
    var characters: [String]? { return residents }
}
