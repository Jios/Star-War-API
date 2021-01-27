import Foundation



struct DetailViewModel
{
    var model: DataModelProtocol
    var sections: [SectionDataSource] = []
    
    init(model: DataModelProtocol)
    {
        self.model = model
        
        var section = SectionDataSource(title: "Resources")
        
        for resouce in self.model.displayResouces
        {
            let row = RowData(title: resouce.0, subtitle: resouce.1)
            section.rows.append(row)
        }
        
        sections.append(section)
    }
    
    var title: String {
        return model.name
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func numberOfRows(in section: Int) -> Int
    {
        return sections[section].rows.count
    }
    
    func sectionTitle(at section: Int) -> String
    {
        return sections[section].title
    }
    
    func rowData(at indexPath: IndexPath) -> RowData
    {
        return sections[indexPath.section].rows[indexPath.row]
    }
}
