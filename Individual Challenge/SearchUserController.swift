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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension SearchUserController  {
    func style() {
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
    }
    
    func layout() {
        stackView.addArrangedSubview(insertUser)
        stackView.addArrangedSubview(searchButton)
        view.addSubview(stackView)
        view.addSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
    
    @objc func searchFunc() {
        if insertUser.text == "" {
            errorMessageLabel.isHidden = false
           
        }else{
            Task{
                let rootVC = UserRepositoryController()
                
                API.searchUser(username: "\(insertUser.text!)") {
                    (repos) in
                    rootVC.repos = repos
                                    }
                errorMessageLabel.isHidden = true
            
                navigationController?.pushViewController(rootVC, animated: true)
            }
        }
    }
}

/*
 1. Pegar dados da search e fazer uma request pra API.
 2. Depois de ter o model vindo da API, fazer requisicao pra proxima controller, mandando esse model no init dela. (injecao de dependencia) nome bonito pra UserRepositoryController(repos: repos)
 3. Na UserRepositoryController, configurar delegate e dataSource pra usar o array repos :)
 4. *MAGIC*
 */
