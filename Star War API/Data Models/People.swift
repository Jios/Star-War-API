import Foundation



struct People: Codable, DataModelProtocol
{
    let name: String?
    let gender: String?
    let height: String?
    let mass: String?
    let homeworld: String?
    let films: [String]?
    let species: [String]?
    let starships: [String]?
    let vehicles: [String]?
    let url: String
    let birthYear: String?
    let eyeColor: String?
    let hairColor: String?
    let created: Date?
    let edited: Date?
}


extension People
{
    var displayResouces: [(String, String?)] {
        return [("Name", name),
                ("Created Date", createdDateString),
                ("Edited Date", editedDateString),
                ("Gender", gender),
                ("Height", height)]
    }
    
    var planets: [String]? {
        guard let homeworld = homeworld else {
            return nil
        }
        
        return [homeworld]
    }
}
