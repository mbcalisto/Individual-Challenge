//
//  SearchField.swift
//  Individual Challenge
//
//  Created by Mateus Calisto on 26/10/22.
//

import UIKit

class SearchField: UIView {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "git-removed")
        return imageView
    }()
    let insertUser: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Username"
        textfield.textAlignment = .center
        textfield.font = UIFont.preferredFont(forTextStyle: .title1)
        return textfield
    }()
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Search", for: [])
        button.configuration = .filled()
        button.addTarget(self, action: #selector(searchFunc), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    weak var delegate: SearchFieldDelegate?
    
    override func didMoveToSuperview() {
        setContraints()
    }
    
    private func setContraints() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(insertUser)
        stackView.addArrangedSubview(searchButton)
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    @objc func searchFunc() {
        if insertUser.text == "" {
            delegate?.changeErrorLabel(with: "The username cannot be blank.", isHidden: false)
        } else {
            delegate?.getFromAPI(with: insertUser.text)
        }
    }
}

protocol SearchFieldDelegate: AnyObject {
    func changeErrorLabel(with text: String?, isHidden: Bool)
    func getFromAPI(with text: String?)
}
