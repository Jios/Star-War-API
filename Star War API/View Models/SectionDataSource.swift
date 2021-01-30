import Foundation



struct SectionDataSource
{
    var title: String?
    var rows: [RowData] = []
    
    static func section(_ models: [DataModelProtocol],
                        title: String) -> SectionDataSource
    {
        var section = SectionDataSource(title: title)
        
        for model in models
        {
            let row = RowData(title: model.name,
                              subtitle: nil,
                              isSelectable: true,
                              model: model)
            
            section.rows.append(row)
        }
        
        return section
    }
}
