import Foundation



struct MasterViewModel
{
    private var nextUrlString: String?
    
    var shouldReloadDataClosure: (() -> Void)?
    
    var characters: [People] = []
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
                self.characters = response!.results
            }
            else
            {
                self.characters.append(contentsOf: response!.results)
            }
            
            nextUrlString = response?.next
            
            shouldReloadDataClosure?()
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
}


extension MasterViewModel
{
    var numberOfSections: Int {
        return characters.count > 0 ? 1 : 0
    }
    
    func numberOfRows(in section: Int) -> Int
    {
        return characters.count
    }
    
    func title(at indexPath: IndexPath) -> String?
    {
        return characters[indexPath.row].name
    }
    
    func subtitle(at indexPath: IndexPath) -> String?
    {
        return characters[indexPath.row].gender
    }
    
    func character(at indexPath: IndexPath) -> People
    {
        return characters[indexPath.row]
    }
}
