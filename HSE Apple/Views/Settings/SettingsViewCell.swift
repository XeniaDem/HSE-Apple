//
//  SettingsTableViewCell.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 11.03.2022.
//

import UIKit
class SettingsViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
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
        title.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        title.textAlignment = .center
        //title.textColor = .black
        title.lineBreakMode = .byClipping
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
 
    func setupCell() {
        backgroundColor = .tertiarySystemBackground
        addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 35).isActive = true
        titleLabel.textAlignment = .left
    }
}
