import Foundation



struct MasterViewModel
{
    private var nextUrlString: String?
    private var arrPeople: [People] = []
    
    var isFetching = false
    
    var searchTerm: String? {
        didSet {
            nextUrlString = nil
        }
    }
    
    var response: SearchResult<People>? {
        didSet {
            if response!.previous == nil
            {
                self.arrPeople = response!.results
            }
            else
            {
                self.arrPeople.append(contentsOf: response!.results)
            }
            
            nextUrlString = response?.next
        }
    }
}


extension MasterViewModel
{
    var urlString: String {
        return nextUrlString ?? APIClient.root + "api/people/?search=" + (searchTerm ?? "")
    }
    
    var canFetchResults: Bool {
        return (nextUrlString != nil) && !isFetching
    }
    
    var numberOfPeople: Int {
        return arrPeople.count
    }
}


extension MasterViewModel
{
    var numberOfSections: Int {
        return arrPeople.count > 0 ? 1 : 0
    }
    
    func numberOfRows(in section: Int) -> Int
    {
        return arrPeople.count
    }
    
    func title(at indexPath: IndexPath) -> String?
    {
        return arrPeople[indexPath.row].name
    }
    
    func subtitle(at indexPath: IndexPath) -> String?
    {
        return arrPeople[indexPath.row].gender
    }
    
    func character(at indexPath: IndexPath) -> People
    {
        return arrPeople[indexPath.row]
    }
}
