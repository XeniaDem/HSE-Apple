//
//  File.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 09.02.2022.
//

import UIKit
class ConversationViewCell: UITableViewCell {

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
        title.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        title.textAlignment = .center
        //title.textColor = .black
        title.lineBreakMode = .byClipping
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let descriptionLabel: UILabel = {
        let description = UILabel()
        description.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        //description.textColor = .black
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
        descriptionLabel.text = "Last message"
//        dataLabel.text = announcementModel.date?.formatted(.dateTime).description
//        groupsLabel.text = announcementModel.groups
        
        //backgroundView = image
        addSubview(titleLabel)
        //addSubview(unreadMarkImage)
        addSubview(descriptionLabel)
        //addSubview(dataLabel)
        //addSubview(groupsLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 35).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        titleLabel.textAlignment = .left
        
        descriptionLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: -50).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
//        dataLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
//        dataLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
//        groupsLabel.rightAnchor.constraint(equalTo: dataLabel.leftAnchor, constant: -10).isActive = true
//        groupsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    }
}
