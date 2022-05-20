//
//  RequestViewCell.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 13.03.2022.
//

import UIKit
class RequestViewCell: UITableViewCell {

    let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        title.textAlignment = .center
        title.lineBreakMode = .byClipping
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    let unreadMarkImage: UIImageView = {
        let image = UIImageView()
        image.image = .init(systemName: "circle.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let descriptionLabel: UILabel = {
        let description = UILabel()
        description.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        description.textAlignment = .left
        description.numberOfLines = 3
        description.lineBreakMode = .byTruncatingTail
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    let dataLabel: UILabel = {
        let data = UILabel()
        data.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        data.textAlignment = .right
        data.lineBreakMode = .byTruncatingTail
        data.translatesAutoresizingMaskIntoConstraints = false
        return data
        
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
        titleLabel.text = "kvdemidenko@edu.hse.ru"
        descriptionLabel.text = "Запрос на регистрацию"
        dataLabel.text = Date().formatted(.dateTime).description
        
        addSubview(titleLabel)
        addSubview(unreadMarkImage)
        addSubview(descriptionLabel)
        addSubview(dataLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 35).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 270).isActive = true
        titleLabel.textAlignment = .left
        unreadMarkImage.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        unreadMarkImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 35).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        dataLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        dataLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
    }
}
