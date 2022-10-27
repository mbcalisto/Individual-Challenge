//
//  TableViewCell.swift
//  Individual Challenge
//
//  Created by Mateus Calisto on 14/10/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let cellId = "TableViewCell"
    let square = UIView()
    let underlineView = UIView()
    
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Padrao"
        name.numberOfLines = 0
        return name
    }()
    private let languageLabel: UILabel = {
        let language = UILabel()
        language.translatesAutoresizingMaskIntoConstraints = false
        language.text = ""
        return language
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(square)
        contentView.addSubview(nameLabel)
        contentView.addSubview(languageLabel)
        cellStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(nameLabel: String, languageLabel: String){
        self.nameLabel.text = nameLabel
        self.languageLabel.text = languageLabel
    }
    
    func configureSearched(nameLabel: String){
        self.nameLabel.text = nameLabel
    }
    
}

extension TableViewCell {
    func cellStyle() {
        square.backgroundColor = .systemFill
        square.translatesAutoresizingMaskIntoConstraints = false
        square.layer.cornerRadius = 8
        square.layer.masksToBounds = true
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        underlineView.backgroundColor = .systemBlue
        contentView.addSubview(underlineView)
        NSLayoutConstraint.activate([
            square.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 5
            ),
            square.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 5
            ),
            square.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -5
            ),
            square.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -5
            ),
            square.heightAnchor.constraint(
                greaterThanOrEqualToConstant: 100
            ),
            
            nameLabel.topAnchor.constraint(
                equalTo: square.topAnchor,
                constant: 10
            ),
            nameLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),
            nameLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: contentView.trailingAnchor
            ),
            
            languageLabel.trailingAnchor.constraint(
                equalTo: square.trailingAnchor,
                constant: -20
            ),
            languageLabel.bottomAnchor.constraint(
                equalTo: square.bottomAnchor,
                constant: -20
            ),
            
            underlineView.topAnchor.constraint(
                equalToSystemSpacingBelow: nameLabel.bottomAnchor,
                multiplier: 1
            ),
            underlineView.leadingAnchor.constraint(
                equalToSystemSpacingAfter: leadingAnchor,
                multiplier: 2
            ),
            underlineView.widthAnchor.constraint(
                equalTo: nameLabel.widthAnchor,
                constant: 15
            ),
            underlineView.heightAnchor.constraint(
                equalToConstant: 4
            )
        ])
    }
}
