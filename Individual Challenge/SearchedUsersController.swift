import UIKit

class SearchedUsersController: UIViewController {
    let names = CoreDataManager.shared.fetchNames()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var repos: [User] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var sortedRepos: [User] { repos.sorted(by: { $0.id > $1.id }) }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        view.backgroundColor = .systemBackground
    }
}

extension SearchedUsersController  {
    
    func style() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.register(SearchedTableViewCell.self, forCellReuseIdentifier: SearchedTableViewCell.cellId)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func layout() {
        
    }
}

extension SearchedUsersController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCellModel = names[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchedTableViewCell.cellId, for: indexPath) as? SearchedTableViewCell else { return UITableViewCell()}
        
        cell.configureSearched(nameLabel: currentCellModel.name!.uppercased())
        cell.tintColor = .black
        
        return cell
    }
}
