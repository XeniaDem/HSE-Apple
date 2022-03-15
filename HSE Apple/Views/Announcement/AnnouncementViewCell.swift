//
//  AnnouncementViewCell.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 11.02.2022.
//

import UIKit
class AnnouncementViewCell: UITableViewCell {
    
    public var announcementModel = AnnouncementModel()

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

//    private func loadImage() -> UIImage? {
//        guard let data = try? Data(contentsOf: (articleModel.img?.url)!) else {
//            return nil
//        }
//        return UIImage(data: data)
//    }
    func makeRead() {
        unreadMarkImage.removeFromSuperview()
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func setupCell() {
        //backgroundColor = UIColor.clear
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        //layer.borderWidth = 5
        //layoutSubviews()
        //self.layer.borderColor = .init(red: 255.0/255.0, green: 71.0/255.0, blue: 87.0/255.0, alpha: 1.0)
        //self.layer.borderColor = .init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        titleLabel.text = announcementModel.title
        descriptionLabel.text = announcementModel.text 
        dataLabel.text = announcementModel.date?.formatted(.dateTime).description
        groupsLabel.text = announcementModel.groups
        
        //backgroundView = image
        addSubview(titleLabel)
        addSubview(unreadMarkImage)
        addSubview(descriptionLabel)
        addSubview(dataLabel)
        addSubview(groupsLabel)
        
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
        groupsLabel.rightAnchor.constraint(equalTo: dataLabel.leftAnchor, constant: -10).isActive = true
        groupsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    }
}
