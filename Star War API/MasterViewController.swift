import UIKit



class MasterViewController: UIViewController
{
    static let cellIdentifier = "CharacterTableViewCell"
    
    
    private var spinnerVC = SpinnerViewController()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    lazy var viewModel: MasterViewModel = {
        var vm = MasterViewModel()
        
        vm.shouldReloadDataClosure = {
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        }
        
        return vm
    }()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupSubviews()
        fetchPeople()
    }
}
    

// MARK: - # set up

fileprivate
extension MasterViewController
{
    func setupSubviews()
    {
        self.title = "Star War Characters"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
        searchBar.delegate = self
    }
}


fileprivate
extension MasterViewController
{
    @objc
    func fetchPeople()
    {
        guard let url = URL(string: viewModel.urlString) else {
            
//            let userInfo = ["message": "Invalid URL"]
//            let error = NSError(domain: "SWAPI",
//                                code: -1,
//                                userInfo: userInfo)
//
//            completion(Result.failure(error))
            
            return
        }
        
        viewModel.isFetching = true
        
        showSpinnerViewController(spinnerVC)
        
        
        APIClient.fetchResouce(url) { [weak self] (result: Result<SearchResult<People>, NSError>) in
//        }
//        APIClient.fetchPeople(viewModel.urlString) { [weak self] (result: Result<SearchResult<People>, NSError>) in
            
            guard let self = self else {
                return
            }
            
            self.hideSpinnerViewController(self.spinnerVC)
            self.viewModel.isFetching = false
            
            switch result {
            case .success(let searchResult):
                
                self.viewModel.response = searchResult
                
            case .failure(let error):
                self.showAlertView(error.description)
            }
        }
    }
}


// MARK: - # timer

fileprivate
extension MasterViewController
{
    func startSearchTimer(delay: TimeInterval = 0.5)
    {
        self.perform(#selector(fetchPeople),
                     with: nil,
                     afterDelay: delay)
    }
    
    func stopPreviousSearchTimer()
    {
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(fetchPeople),
                                               object: nil)
    }
}


// MARK: - # UISearchBarDelegate

extension MasterViewController: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        viewModel.searchTerm = nil
        
        stopPreviousSearchTimer()
        startSearchTimer()
        
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String)
    {
        viewModel.searchTerm = searchText
        
        stopPreviousSearchTimer()
        startSearchTimer()
    }
}


// MARK: - # UITableViewDataSource

extension MasterViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: MasterViewController.cellIdentifier)
            ?? UITableViewCell(style: .subtitle,
                               reuseIdentifier: MasterViewController.cellIdentifier)
        
        cell.textLabel?.text = viewModel.title(at: indexPath)
        cell.detailTextLabel?.text = viewModel.subtitle(at: indexPath)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}


// MARK: - # UITableViewDelegate

extension MasterViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath,
                              animated: true)
        
        let character = viewModel.character(at: indexPath)
        
        let viewCntrl = DetailTableViewController(character)
        
        navigationController?.pushViewController(viewCntrl,
                                                 animated: true)
    }
}


// MARK: - # UIScrollViewDelegate

extension MasterViewController: UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        view.endEditing(true)
        
        guard viewModel.canFetchResults else {
            return
        }
        
        let offset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height

        if (maxOffset - offset) <= 0
        {
            fetchPeople()
        }
    }
}
