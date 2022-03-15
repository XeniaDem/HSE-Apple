//
//  SlideCollectionViewCell.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 07.02.2022.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var slideImage: UIImageView!
    @IBOutlet weak var authorizationButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    static let reuseId = "SlideCollectionViewCell"
    var delegate: LoginViewControllerDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(slide: Slides) {
        slideImage.image = slide.image
        descriptionText.text = slide.description
        if slide.id == 3 {
            registrationButton.isHidden = false
            authorizationButton.isHidden = false
            descriptionText.textColor = .black
            titleLabel.textColor = .black
        }
        if slide.id == 2 {
            descriptionText.textColor = .black
            titleLabel.textColor = .black
        }
    }

    @IBAction func registrationButtonClick(_ sender: Any) {
        delegate.openRegistrationVC()
    }
  
    @IBAction func authorizationButtonClick(_ sender: Any) {
        delegate.openAuthorizationVC()
    }
}
