import Foundation



struct DetailViewModel
{
    var model: DataModelProtocol
    var sections: [SectionData] = []
    
    init(model: DataModelProtocol)
    {
        self.model = model
        
        var section = SectionData(title: "Resources")
        
        for resouce in self.model.displayResouces
        {
            let row = RowData(title: resouce.0, subtitle: resouce.1)
            section.rows.append(row)
        }
        
        sections.append(section)
    }
    
    var title: String {
        return model.viewTitle
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func numberOfRows(in section: Int) -> Int
    {
        return sections[section].rows.count
    }
    
    func sectionTitle(at section: Int) -> String?
    {
        return sections[section].title
    }
    
    func rowData(at indexPath: IndexPath) -> RowData
    {
        return sections[indexPath.section].rows[indexPath.row]
    }
}


// MARK: - # api

extension DetailViewModel
{
    static
    func fetchAdditionalModels(_ model: DataModelProtocol,
                               completion: @escaping (([SectionData], [String]) -> Void))
    {
        var sections: [SectionData] = []
        var errorUrlStrings: [String] = []
        
        let group = DispatchGroup()
        
        
        group.enter()
        
        APIClient.fetchResources(model.films,
                                 type: Film.self) { (models, errorUrls) in
            
            let section = SectionData.section(models,
                                              title: "Films")
            sections.append(section)
            errorUrlStrings.append(contentsOf: errorUrls)
            
            group.leave()
        }
        
        group.enter()
        
        APIClient.fetchResources(model.species,
                                 type: Species.self) { (models, errorUrls) in
            
            let section = SectionData.section(models,
                                              title: "Species")
            sections.append(section)
            errorUrlStrings.append(contentsOf: errorUrls)
            
            group.leave()
        }
        
        group.enter()
        
        APIClient.fetchResources(model.starships,
                                 type: Starship.self) { (models, errorUrls) in
            
            let section = SectionData.section(models,
                                              title: "Starships")
            sections.append(section)
            errorUrlStrings.append(contentsOf: errorUrls)
            
            group.leave()
        }
        
        group.enter()
        
        APIClient.fetchResources(model.vehicles,
                                 type: Vehicle.self) { (models, errorUrls) in
            
            let section = SectionData.section(models,
                                              title: "Vehicles")
            sections.append(section)
            errorUrlStrings.append(contentsOf: errorUrls)
            
            group.leave()
        }
        
        group.enter()
        
        APIClient.fetchResources(model.characters,
                                 type: People.self) { (models, errorUrls) in
            
            let section = SectionData.section(models,
                                              title: "Character")
            sections.append(section)
            errorUrlStrings.append(contentsOf: errorUrls)
            
            group.leave()
        }
        
        group.enter()
        
        APIClient.fetchResources(model.planets,
                                 type: Planet.self) { (models, errorUrls) in
            
            let section = SectionData.section(models,
                                              title: "Planets")
            sections.append(section)
            errorUrlStrings.append(contentsOf: errorUrls)
            
            group.leave()
        }
        
        
        
        group.notify(queue: .global()) {
            
            sections = sections.filter { !$0.rows.isEmpty || $0.title == nil }
            sections.sort(by: { $0.title! < $1.title!})
            
            completion(sections, errorUrlStrings)
        }
    }
}
