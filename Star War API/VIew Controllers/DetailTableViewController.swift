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
    func fetch<T: Codable>(_ urlStrings: [String]?,
                           type: T.Type,
                           completion: @escaping ([T]) -> Void)
    {
        guard let urlStrings = urlStrings else {
            completion([])
            return
        }
        
        APIClient.fetchResources(urlStrings,
                                 completion: { (result: Result<[T], NSError>) in
                                    
                                    switch result {
                                    case .success(let models):
                                        completion(models)

                                    case .failure(let error):
                                        self.showAlertView(error.description)
                                    }
                                 })
    }
    
    func fetchData(_ model: DataModelProtocol)
    {
        showSpinnerViewController(spinnerVC)
        
        var sections: [SectionData] = []
        
        let group = DispatchGroup()
        
        
        group.enter()
        
        fetch(model.films,
              type: Film.self) { (models) in
            
            let section = SectionData.section(models, title: "Films")
            sections.append(section)
            
            group.leave()
        }
        
        group.enter()
        
        fetch(model.species,
              type: Species.self) { (models) in
            
            let section = SectionData.section(models, title: "Species")
            sections.append(section)
            
            group.leave()
        }
        
        group.enter()
        
        fetch(model.starships,
              type: Starship.self) { (models) in
            
            let section = SectionData.section(models, title: "Starships")
            sections.append(section)
            
            group.leave()
        }
        
        group.enter()
        
        fetch(model.vehicles,
              type: Vehicle.self) { (models) in
            
            let section = SectionData.section(models, title: "Vehicles")
            sections.append(section)
            
            group.leave()
        }
        
        group.enter()
        
        fetch(model.characters,
              type: People.self) { (models) in
            
            let section = SectionData.section(models, title: "Character")
            sections.append(section)
            
            group.leave()
        }
        
        group.enter()
        
        fetch(model.planets,
              type: Planet.self) { (models) in
            
            let section = SectionData.section(models, title: "Planets")
            sections.append(section)
            
            group.leave()
        }
        
        
        
        group.notify(queue: .global()) {
            
            sections = sections.filter { !$0.rows.isEmpty || $0.title == nil }
            sections.sort(by: { $0.title! < $1.title!})
            
            self.viewModel.sections.append(contentsOf: sections)
            
            DispatchQueue.main.async {
                
                self.hideSpinnerViewController(self.spinnerVC)
                self.tableView.reloadData()
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
