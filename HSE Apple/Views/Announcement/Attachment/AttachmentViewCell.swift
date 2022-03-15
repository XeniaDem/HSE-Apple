//
//  AttachmentViewCell.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 12.03.2022.
//

import UIKit
class AttachmentViewCell: UITableViewCell {
    
    var attachment: URL?

    let image: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    let logo: UIImageView = {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()

    let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        title.textAlignment = .center
//        title.textColor = UIColor.white
        title.lineBreakMode = .byClipping
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()



    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.accessoryType = .disclosureIndicator
    }

    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    private func loadImage() -> UIImage? {
        guard let data = try? Data(contentsOf: (attachment)!) else {
            return nil
        }
        return UIImage(data: data)
    }
    
    func setupCell(){
        //backgroundColor = UIColor.clear
        DispatchQueue.main.async {
            self.image.image = self.loadImage()
        }
        
        if attachment?.pathExtension == "pdf" || attachment?.pathExtension == "txt" || attachment?.pathExtension == "rtf" {
            logo.image = .init(systemName: "doc.fill")
            addSubview(titleLabel)
            addSubview(logo)
            setupTitleLabel()
            setupLogo()
            
        }
        if attachment?.pathExtension == "zip" {
            logo.image = .init(systemName: "doc.zipper")
            addSubview(titleLabel)
            addSubview(logo)
            setupTitleLabel()
            setupLogo()
        }

        if attachment?.pathExtension == "jpeg" ||  attachment?.pathExtension == "png" {
            logo.image = .init(systemName: "photo")
            addSubview(logo)
        
            setupLogo()
            
        }
        if attachment?.pathExtension == "pdf" || attachment?.pathExtension == "jpeg" ||  attachment?.pathExtension == "png"  {
            self.accessoryType = .disclosureIndicator
        }
        backgroundView = image
        //addSubview(titleLabel)
//        addSubview(logo)

       

       
        
        
        
    }
    
    private func setupTitleLabel() {
        titleLabel.text = attachment?.lastPathComponent
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 35).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        titleLabel.lineBreakMode = .byTruncatingTail
    }
    
    private func setupLogo() {
        logo.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        logo.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
    }
}

