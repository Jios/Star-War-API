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


extension DetailViewModel
{
    func fetchFilms(_ urlStrings: [String],
                    group: DispatchGroup,
                    completion: @escaping (Result<SectionData, NSError>) -> Void)
    {
        group.enter()
        
        APIClient.fetchResources(urlStrings,
                                 completion: { (result: Result<[Film], NSError>) in
                                    
                                    switch result {
                                    case .success(let models):
                                        let section = SectionData.section(models,
                                                                                title: "Species")

                                        completion(Result.success(section))

                                    case .failure(let error):
                                        completion(Result.failure(error))
                                    }
                                    
                                    group.leave()
                                 })
    }
}
