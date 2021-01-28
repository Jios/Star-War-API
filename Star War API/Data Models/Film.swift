import Foundation



struct Film: Codable, DataModelProtocol
{
    let title: String
    let episodeId: Int
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    let species: [String]
    let starships: [String]
    let vehicles: [String]
    let characters: [String]
    let planets: [String]
    let url: String
    
    let created: Date?
    let edited: Date
    
    var name: String {
        return title
    }
    
    var displayResouces: [(String, String?)] {
        return [("Name", name),
                ("Director", director),
                ("Producer", producer)]
    }
    
    var films: [String] {
        return []
    }
}
