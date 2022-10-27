import UIKit
import SDWebImage

protocol UserRepositoryDelegate: AnyObject {
    func didSend(repos: [User])
}

class UserRepositoryController: UIViewController {
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
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        view.backgroundColor = .systemBackground
    }
    
    func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.addSubview(imageView)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellId)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height/2),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -35),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension UserRepositoryController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCellModel = sortedRepos[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellId, for: indexPath) as? TableViewCell else { return UITableViewCell()}
        
        cell.configure(nameLabel: currentCellModel.name.uppercased(), languageLabel: currentCellModel.language ?? "")
        cell.tintColor = .black
        
        let image_url = URL(string: sortedRepos[0].owner.avatar_url)
        
        imageView.sd_setImage(with: image_url, placeholderImage: UIImage(named: "placeholder.png"))
        imageView.sd_setImage(with: image_url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: "https://wwww.github.com/\(repos)") {
            UIApplication.shared.open(url)
        }
    }
    
}
