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
        language.text = "Padrao"
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
    
}

extension TableViewCell {
    func cellStyle() {
        
        square.backgroundColor = .systemFill
        square.translatesAutoresizingMaskIntoConstraints = false
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        underlineView.backgroundColor = .systemBlue
        contentView.addSubview(underlineView)
        
        
        NSLayoutConstraint.activate([
            square.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            square.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 5
            ),
            square.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            square.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -5
            ),
            square.heightAnchor.constraint(
                greaterThanOrEqualToConstant: 140
            ),

            nameLabel.topAnchor.constraint(
                equalTo: languageLabel.topAnchor
            ),
            nameLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),
            nameLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: contentView.trailingAnchor,
                constant: -100
            ),

            languageLabel.trailingAnchor.constraint(
                equalTo: square.trailingAnchor,
                constant: -20
            ),
            languageLabel.centerYAnchor.constraint(
                equalTo: square.topAnchor,
                constant: 20
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
                equalTo: nameLabel.widthAnchor
            ),
            underlineView.heightAnchor.constraint(
                equalToConstant: 4
            )
        ])
    }
    
}
