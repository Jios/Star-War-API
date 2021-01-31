import Foundation



struct SectionData
{
    var title: String?
    var rows: [RowData] = []
    
    static func section(_ models: [DataModelProtocol],
                        title: String) -> SectionData
    {
        var section = SectionData(title: title)
        
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
