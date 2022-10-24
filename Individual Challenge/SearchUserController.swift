//
//  ViewModel.swift
//  Individual Challenge
//
//  Created by Mateus Calisto on 13/10/22.
//

import UIKit

class SearchUserController: UIViewController {
    let stackView = UIStackView()
    let insertUser = UITextField()
    let searchButton = UIButton()
    let errorMessageLabel = UILabel()
    let imageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }
}

extension SearchUserController  {
    func style() {
        self.navigationController?.navigationBar.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.2.gobackward"), style: .plain, target: self, action: #selector(SearchedUsers))
        
        insertUser.translatesAutoresizingMaskIntoConstraints = false
        insertUser.placeholder = "Username"
        insertUser.textAlignment = .center
        insertUser.font = UIFont.preferredFont(forTextStyle: .title1)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("Search", for: [])
        searchButton.configuration = .filled()
        searchButton.addTarget(self, action: #selector(searchFunc), for: .touchUpInside)
        searchButton.layer.cornerRadius = 5
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.text = "The username cannot be blank."
        errorMessageLabel.isHidden = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "git-removed")
        
    }
    
    func layout() {
        
        stackView.addArrangedSubview(insertUser)
        stackView.addArrangedSubview(searchButton)
        view.addSubview(imageView)
        view.addSubview(stackView)
        view.addSubview(errorMessageLabel)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 10),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 10),
        ])
        NSLayoutConstraint.activate([
            insertUser.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            insertUser.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            insertUser.topAnchor.constraint(equalTo: stackView.topAnchor),
        ])
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
            errorMessageLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ])
        
    }
    @objc func SearchedUsers(){
        let rootVC = SearchedUsersController()
        self.navigationController?.pushViewController(rootVC, animated: true)
      }
    
    @objc func searchFunc() {
        
        
        if insertUser.text == "" {
            errorMessageLabel.text = "The username cannot be blank."
            errorMessageLabel.isHidden = false
            
        }else{
            Task{
                let rootVC = UserRepositoryController()
                API.searchUser(username: "\(insertUser.text!)") { (repos) in
                    if let repos {
                        rootVC.repos = repos
                        
                        DispatchQueue.main.async {
                            
                            
                            CoreDataManager.shared.createName(name: "\(self.insertUser.text!)")

                            
                            self.errorMessageLabel.isHidden = true
                            self.navigationController?.pushViewController(rootVC, animated: true)
                           
                            
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.errorMessageLabel.text = "User not found."
                            self.errorMessageLabel.isHidden = false
                            
                        }
                    }
                    
                }
            }
        }
    }
}


