//
//  TaskViewCell.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 14.03.2022.
//

import UIKit

class TaskViewCell: UITableViewCell {
    
    public var taskModel = TaskModel()

    let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        title.textAlignment = .center
        //title.textColor = .black
        title.lineBreakMode = .byClipping
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    let unreadMarkImage: UIImageView = {
        let image = UIImageView()
        image.image = .init(systemName: "circle.fill")
        //image.tintColor = .red
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let descriptionLabel: UILabel = {
        let description = UILabel()
        description.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        description.textAlignment = .left
        //description.textColor = .black
        description.numberOfLines = 3
        description.lineBreakMode = .byTruncatingTail
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    let dataLabel: UILabel = {
        let data = UILabel()
        data.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        data.textAlignment = .right
        //data.textColor = .black
        data.lineBreakMode = .byTruncatingTail
        data.translatesAutoresizingMaskIntoConstraints = false
        return data
        
    }()
    let deadlineDateLabel: UILabel = {
        let data = UILabel()
        data.font = UIFont.systemFont(ofSize: 12, weight: .black)
        data.textAlignment = .right
        data.textColor = .red
        data.lineBreakMode = .byTruncatingTail
        data.translatesAutoresizingMaskIntoConstraints = false
        return data
        
    }()
    
    let deadlineLabel: UILabel = {
        let deadline = UILabel()
        deadline.text = "Дедлайн:"
        deadline.font = UIFont.systemFont(ofSize: 12, weight: .black)
        deadline.textAlignment = .right
        deadline.textColor = .red
        deadline.lineBreakMode = .byTruncatingTail
        deadline.translatesAutoresizingMaskIntoConstraints = false
        return deadline
        
    }()
    
    let groupsLabel: UILabel = {
        let groups = UILabel()
        groups.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        //groups.textColor = .black
        groups.translatesAutoresizingMaskIntoConstraints = false
        return groups
        
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }

    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    func makeRead() {
        unreadMarkImage.removeFromSuperview()
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func setupCell() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        titleLabel.text = taskModel.title
        descriptionLabel.text = taskModel.text
        dataLabel.text = taskModel.dateOfPublication?.formatted(.dateTime).description
        deadlineDateLabel.text = taskModel.dateOfDeadline?.formatted(.dateTime).description
        groupsLabel.text = taskModel.groups
        
        //backgroundView = image
        addSubview(titleLabel)
        addSubview(unreadMarkImage)
        addSubview(descriptionLabel)
        addSubview(dataLabel)
        addSubview(groupsLabel)
        addSubview(deadlineDateLabel)
        addSubview(deadlineLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 35).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        titleLabel.textAlignment = .left
        
        unreadMarkImage.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        unreadMarkImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: -50).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        
        dataLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        dataLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        
        deadlineDateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        deadlineDateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        
        deadlineLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        deadlineLabel.rightAnchor.constraint(equalTo: deadlineDateLabel.leftAnchor, constant: -10).isActive = true
        
        groupsLabel.rightAnchor.constraint(equalTo: dataLabel.leftAnchor, constant: -10).isActive = true
        groupsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    }
}
