//
//  ProfileViewController.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 10.02.2022.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagePicker = UIImagePickerController()
    var choosenImage : UIImage?

    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Профиль"
        //navigationItem.titleView?.tintColor = .white
        navigationItem.largeTitleDisplayMode = .always
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        setupSettingsTebleView()
    }
    
    @IBAction func chooseNewImageButtonClick(_ sender: Any) {
        let alertController: UIAlertController = UIAlertController(title: nil, message: "Источник изображения:", preferredStyle: .actionSheet)
                let cameraAction = UIAlertAction(title: "Камера", style: .default){
                    UIAlertAction in
                    self.imagePicker.sourceType = .camera
                    self.present(self.imagePicker, animated: true, completion: nil)
                    
                }
                let galleryAction = UIAlertAction(title: "Галерея", style: .default){
                    UIAlertAction in
                    self.imagePicker.sourceType = .photoLibrary
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
                let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
                alertController.addAction(cameraAction)
                alertController.addAction(galleryAction)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let setImage = info[.editedImage] as? UIImage else {
            return
        }
        profileImage.image = setImage
        dismiss(animated: true, completion: nil)
    }
    private func setupSettingsTebleView() {
        settingsTableView.register(SettingsViewCell.self, forCellReuseIdentifier: "cell")
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
    }
   

}
extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsViewCell
        
        cell.setupCell()
        if indexPath.row == 0 {
            cell.titleLabel.text = "Запросы"
            cell.accessoryType = .disclosureIndicator
        }
        if indexPath.row == 1 {
            cell.titleLabel.text = "Настройка уведомлений"
            cell.accessoryType = .disclosureIndicator
        }
        if indexPath.row == 2 {
            cell.titleLabel.text = "Выйти"
            cell.titleLabel.textColor = .systemRed
        }
        
        cell.layer.masksToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (indexPath.row == 0) {
            let vc = RequestsViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        if (indexPath.row == 2) {
            dismiss(animated: true, completion: nil)
        }
//        let cell = tableView.cellForRow(at: indexPath) as! AnnouncementViewCell
//        cell.makeRead()
//        announcements[indexPath.row].isRead = true
//        let vc = PreviewAnnouncementViewController()
//        vc.isBeingEdited = false
//        vc.configurePreviewAnnouncementView(announcement: announcements[indexPath.row])
//        navigationController?.pushViewController(vc, animated: true)
    }
    
}
