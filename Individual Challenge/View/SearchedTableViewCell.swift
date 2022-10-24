//
//  TableViewCell.swift
//  Individual Challenge
//
//  Created by Mateus Calisto on 14/10/22.
//

import UIKit

class SearchedTableViewCell: UITableViewCell {
    
    static let cellId = "TableViewCell"
    
    
    let square = UIView()
    let underlineView = UIView()
    
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = ""
        name.numberOfLines = 0
        return name
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(square)
        contentView.addSubview(nameLabel)
        cellStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSearched(nameLabel: String){
        self.nameLabel.text = nameLabel
    }
    
}

extension SearchedTableViewCell {
    func cellStyle() {
        square.translatesAutoresizingMaskIntoConstraints = false
        square.backgroundColor = .systemFill
        square.layer.cornerRadius = 8
        square.layer.masksToBounds = true
        
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        nameLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            
            square.heightAnchor.constraint(
                greaterThanOrEqualToConstant: 100
            ),
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
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),
            nameLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: contentView.trailingAnchor
            )
        ])
    }
    
}
