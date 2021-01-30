import Foundation



struct Species: Codable, DataModelProtocol
{
    let name: String?
    let classification: String?
    let designation: String?
    let averageHeight: String?
    let averageLifespan: String?
    let eyeColors: String?
    let hairColors: String?
    let skinColors: String?
    let language: String?
    let homeworld: String?
    let people: [String]?
    let films: [String]?
    let url: String
    let created: Date?
    let edited: Date?
    
    var displayResouces: [(String, String?)] {
        return [("Name", name),
                ("Created Date", createdDateString),
                ("Edited Date", editedDateString),
                ("Classification", classification),
                ("Designation", designation)]
    }
    
    var characters: [String]? { return people }
    var planets: [String]? {
        guard let homeworld = homeworld else {
            return nil
        }
        
        return [homeworld]
    }
}
