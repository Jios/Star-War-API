import Foundation



protocol DataModelProtocol
{
    var url: String { get }
    var name: String? { get }
    var viewTitle: String { get }
    
    // basic info section
    var displayResouces: [(String, String?)] { get }
    
    // additional sections
    var films: [String]? { get }
    var species: [String]? { get }
    var starships: [String]? { get }
    var vehicles: [String]? { get }
    var characters: [String]? { get }
    var planets: [String]? { get }
    
    // dates
    var edited: Date? { get }
    var editedDateString: String? { get }
    
    var created: Date? { get }
    var createdDateString: String? { get }
}

extension DataModelProtocol
{
    var viewTitle: String {
        let thisType = type(of: self)
        let name = String(describing: thisType)
        
        return name
    }
    
    func additionalResouces() -> [(String, DataModelProtocol.Type, [String]?)]
    {
        return[("Films", Film.self, films),
               ("Species", Species.self, species),
               ("Starships", Starship.self, starships),
               ("Vehicles", Vehicle.self, vehicles),
               ("Poeple", People.self, characters),
               ("Planets", Planet.self, planets)]
    }
    
    var films: [String]? { return nil }
    var species: [String]? { return nil }
    var starships: [String]? { return nil }
    var vehicles: [String]? { return nil }
    var characters: [String]? { return nil }
    var planets: [String]? { return nil }

    var createdDateString: String? { return created?.string }
    var editedDateString: String?  { return edited?.string  }
}
