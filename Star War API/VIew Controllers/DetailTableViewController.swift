import UIKit



class DetailTableViewController: UITableViewController
{
    static let resourceCellIdentifier = "ResouceTableViewCell"

    
    var viewModel: DetailViewModel
    
    var spinnerVC = SpinnerViewController()
    
    
    
    init(_ model: DataModelProtocol)
    {
        viewModel = DetailViewModel(model: model)
        
        super.init(style: .plain)
    }
    
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupSubviews()
        
        fetchData(viewModel.model)
    }
}


// MARK: - #

fileprivate
extension DetailTableViewController
{
    func setupSubviews()
    {
        self.title = viewModel.title
        
        tableView.tableFooterView = UIView()
    }
}


// MARK: - # api

fileprivate
extension DetailTableViewController
{
    func fetchData(_ model: DataModelProtocol)
    {
        showSpinnerViewController(spinnerVC)
        
        DetailViewModel.fetchAdditionalModels(model) { [weak self] (sections, errorUrls) in
            guard let self = self else {
                return
            }
            
            self.viewModel.sections.append(contentsOf: sections)
            
            DispatchQueue.main.async {
                
                self.hideSpinnerViewController(self.spinnerVC)
                self.tableView.reloadData()
                
                if !errorUrls.isEmpty
                {
                    self.showAlertView("Fail to load \(errorUrls.count) resource(s)")
                }
            }
        }
    }
}


// MARK: - # Table view data source

extension DetailTableViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int
    {
        return viewModel.numberOfRows(in: section)
    }

    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String?
    {
        return viewModel.sectionTitle(at: section)
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: MasterViewController.cellIdentifier)
            ?? UITableViewCell(style: .value1,
                               reuseIdentifier: MasterViewController.cellIdentifier)
        
        let row = viewModel.rowData(at: indexPath)
        
        cell.textLabel?.text = row.title
        cell.detailTextLabel?.text = row.subtitle
        cell.accessoryType = row.isSelectable ? .disclosureIndicator : .none
        cell.selectionStyle = row.isSelectable ? .default : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath,
                              animated: true)
        
        let row = viewModel.rowData(at: indexPath)
        
        if let model = row.model
        {
            let viewCntrl = DetailTableViewController(model)
            
            navigationController?.pushViewController(viewCntrl,
                                                     animated: true)
        }
    }
}
