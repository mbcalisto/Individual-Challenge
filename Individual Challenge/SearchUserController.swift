//
//  ViewModel.swift
//  Individual Challenge
//
//  Created by Mateus Calisto on 13/10/22.
//

import UIKit

class SearchUserController: UIViewController {
    let errorMessageLabel = UILabel()
    let searchField: SearchField = {
        let search = SearchField()
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    let rootVC = UserRepositoryController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        searchField.delegate = self
    }
}

extension SearchUserController  {
    func style() {
        self.navigationController?.navigationBar.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.2.gobackward"), style: .plain, target: self, action: #selector(SearchedUsers))
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.text = "The username cannot be blank."
        errorMessageLabel.isHidden = true
    }
    
    func layout() {
        view.addSubview(errorMessageLabel)
        view.addSubview(searchField)
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height/4),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            errorMessageLabel.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 5),
            errorMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
    }
    
    @objc func SearchedUsers(){
        let rootVC = SearchedUsersController()
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
}

extension SearchUserController: SearchFieldDelegate {
    func getFromAPI(with text: String?) {
        Task{
            API.searchUser(username: "\(text!)") { (repos) in
                if let repos {
                    self.rootVC.repos = repos
                    DispatchQueue.main.async {
                        CoreDataManager.shared.createName(name: "\(text!)")
                        self.navigationController?.pushViewController(self.rootVC, animated: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessageLabel.text = "User Not Found"
                        self.errorMessageLabel.isHidden = false
                    }
                }
            }
        }
    }
    
    func changeErrorLabel(with text: String?, isHidden: Bool) {
        guard let errorLabel = text else {
            return
        }
        errorMessageLabel.text = errorLabel
        errorMessageLabel.isHidden = isHidden
    }
}
