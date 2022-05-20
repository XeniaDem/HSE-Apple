//
//  UserViewCell.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 20.05.2022.
//

import Foundation
import UIKit
class UserViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.accessoryType = .disclosureIndicator
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.textAlignment = .center
        title.lineBreakMode = .byClipping
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let descriptionLabel: UILabel = {
        let description = UILabel()
        description.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        description.textAlignment = .left
        description.numberOfLines = 3
        description.lineBreakMode = .byTruncatingTail
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    func setupCell() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        
        titleLabel.text = "Ksenia Demidenko"
        
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 35).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        titleLabel.textAlignment = .left
        
        descriptionLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: -50).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
    }
}
