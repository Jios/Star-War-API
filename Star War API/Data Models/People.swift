import Foundation



struct People: Codable, DataModelProtocol
{
    // change to optional
    let name: String
    let gender: String
    let height: String // it will cause crash for unexpected data
    let mass: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let starships: [String]
    let vehicles: [String]
    let url: String
    let birthYear: String
    let eyeColor: String
    let hairColor: String
    let created: Date?
    let edited: Date
}


extension People
{
    var displayResouces: [(String, String?)] {
        return [("Name", name),
                ("Gender", gender),
                ("Height", height)]
    }
    var characters: [String] { return [] }
    var planets: [String] { return [homeworld] }
}
