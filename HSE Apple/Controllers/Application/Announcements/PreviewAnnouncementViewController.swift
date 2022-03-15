//
//  PreviewAnnouncementViewController.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 12.02.2022.
//

import UIKit
import UniformTypeIdentifiers

class PreviewAnnouncementViewController: UIViewController, UITextViewDelegate {

    var announcementId: Int!
    var isBeingEdited: Bool!
    var attachments: [URL]?
    
    
    
    
    let announcementTextView: UITextView = {
        let textView = UITextView()
        
        textView.backgroundColor = .tertiarySystemBackground
        //textView.isUserInteractionEnabled = false
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .tertiarySystemBackground
        //textView.textColor = .black
        textView.font = .systemFont(ofSize: 15, weight: .regular)
        return textView
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.isUserInteractionEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 21, weight: .semibold)
        //textField.textColor = .black
        //textField.backgroundColor = .white
        return textField
    }()
    let groupsButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "person.fill"), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        return button
    
    }()
    
    let attachmentsTableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let textFieldToolBar: UIToolbar = {
        let toolBar = UIToolbar()
        let addPhotoButton = UIBarButtonItem(image: .init(systemName: "photo"), style: .plain, target: self, action: #selector(addPhotoButtonClick))
        let addFileButton = UIBarButtonItem(image: .init(systemName: "paperclip"), style: .plain, target: self, action: #selector(addFileButtonClick))
        toolBar.items = [addPhotoButton, addFileButton]
        toolBar.sizeToFit()
        return toolBar
    }()
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        announcementTextView.inputAccessoryView = textFieldToolBar
        
        configureNavigationBar()
        configureAnnouncementsTextView()
        configureTitleTextField()
        configureGroupsButton()
        configureAttachmentsTableView()
        view.backgroundColor = .secondarySystemBackground
        navigationItem.largeTitleDisplayMode = .never
        announcementTextView.delegate = self
        
//        view.addGestureRecognizer(press)
        let press = UITapGestureRecognizer(target: self,
                                           action: #selector(keyboardPressedOutside))
        if (isBeingEdited) {
            view.addGestureRecognizer(press)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.isHidden = false
        //navigationController?.navigationBar.

    }
    
    @objc func keyboardPressedOutside() {
    
        self.announcementTextView.endEditing(true)
        //view.removeGestureRecognizer(press)
    }
    
    private func configureNavigationBar() {
        if isBeingEdited {
            let editButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(editButtonClick))
            announcementTextView.becomeFirstResponder()
            navigationItem.rightBarButtonItem = editButton
            navigationItem.title = "Редактирование"
  
        } else {
            navigationItem.title = "Просмотр"
            textFieldToolBar.isHidden = true
        }
       // navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        //navigationController?.navigationBar.barTintColor = .white
        
    }
    private func configureAnnouncementsTextView() {
        view.addSubview(announcementTextView)
        
        announcementTextView.layer.cornerRadius = 15
        announcementTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        announcementTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        announcementTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        announcementTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -453).isActive = true
    }
    private func configureTitleTextField() {
        view.addSubview(titleTextField)
        titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        titleTextField.placeholder = "Название"
        titleTextField.borderStyle = .roundedRect
        titleTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    private func configureGroupsButton() {
        view.addSubview(groupsButton)
        groupsButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        groupsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 102).isActive = true
        let group1 = UIAction(title: "Группа 1") { (action) in
            self.groupsButton.setTitle("Группа 1", for: .normal)
        }
        let group2 = UIAction(title: "Группа 2") { (action) in
            self.groupsButton.setTitle("Группа 2", for: .normal)
        }
        let allGroups = UIAction(title: "Все группы") { (action) in
             self.groupsButton.setTitle("Все группы", for: .normal)
        }
        let menu = UIMenu(title: "Выбор групп", options: .displayInline, children: [group1 , group2 , allGroups])
        groupsButton.menu = menu
        groupsButton.showsMenuAsPrimaryAction = true
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        let press = UITapGestureRecognizer(target: self,
                                           action: #selector(keyboardPressedOutside))
        view.addGestureRecognizer(press)
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        view.gestureRecognizers?.removeAll()
    
    }
    
    
    private func configureAttachmentsTableView() {
        view.addSubview(attachmentsTableView)
        attachmentsTableView.backgroundColor = .tertiarySystemBackground
        attachmentsTableView.register(AttachmentViewCell.self, forCellReuseIdentifier: "AttachmentViewCell")
        attachmentsTableView.dataSource = self
        attachmentsTableView.delegate = self
        attachmentsTableView.rowHeight = 70
        attachmentsTableView.layer.cornerRadius = 15
        attachmentsTableView.topAnchor.constraint(equalTo: announcementTextView.bottomAnchor, constant: 28).isActive = true
        attachmentsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        attachmentsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        attachmentsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        
    }
    @objc private func editButtonClick(_ sender: Any) {
        editAnnouncement(announcementId)
        navigationController?.popViewController(animated: true)
    }
    func configurePreviewAnnouncementView(announcement: AnnouncementModel) {
        announcementTextView.text = announcement.text
        titleTextField.text = announcement.title
        groupsButton.setTitle(announcement.groups, for: .normal)
        attachments = announcement.attachments
        if (!(attachments?.isEmpty ?? false)) {
            attachmentsTableView.isHidden = false
        }
        attachmentsTableView.reloadData()
        
        
        
    }
    private func editAnnouncement(_ id: Int) {
        let previousDate = announcements[id].date
        let announcement = AnnouncementModel(title: titleTextField.text, text: announcementTextView.text, date: previousDate, groups: groupsButton.currentTitle, isRead: true, attachments: attachments)
        replaceAnnouncement(at: id, newAnnouncement: announcement)
    }
    @objc private func addPhotoButtonClick() {
        let supportedTypes = [UTType.jpeg, UTType.png, UTType.heic]
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        documentPicker.shouldShowFileExtensions = true
        present(documentPicker, animated: true, completion: nil)
    }
        
    @objc private func addFileButtonClick() {
        let supportedTypes = [UTType.pdf, UTType.jpeg, UTType.png, UTType.rtf, UTType.text, UTType.zip]
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        documentPicker.shouldShowFileExtensions = true
        present(documentPicker, animated: true, completion: nil)
    }
    private func handleStartDeleting(_ id: Int) {
        attachments?.remove(at: id)
        attachmentsTableView.reloadData()
    }
   

}
extension PreviewAnnouncementViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.attachmentsTableView.dequeueReusableCell(withIdentifier: "AttachmentViewCell", for: indexPath) as! AttachmentViewCell
        cell.attachment = attachments?[indexPath.row]
        cell.backgroundColor = .tertiarySystemBackground
        cell.setupCell()
        cell.layer.masksToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attachments?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alertController: UIAlertController = UIAlertController(title: nil, message: "Выбор действия:", preferredStyle: .actionSheet)
        let previewAction = UIAlertAction(title: "Просмотреть", style: .default) {
            UIAlertAction in
                let vc = PreviewAttachmentViewController()
                vc.attachment = self.attachments?[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
                    
        }
        let downloadAction = UIAlertAction(title: "Загрузить", style: .default){ [self]
            UIAlertAction in
                    let url = self.attachments![indexPath.row]
                    FileDownloader.loadFileAsync(url: url) { (path, error) in
                        print("File downloaded to : \(path!)")
                    }
                    
           
            }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        if attachments?[indexPath.row].pathExtension == "pdf" || attachments?[indexPath.row].pathExtension == "jpeg" ||  attachments?[indexPath.row].pathExtension == "png" {
        
            alertController.addAction(previewAction)
            
        }
        
        alertController.addAction(downloadAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive,
                                       title: "Удалить") { [weak self] (action, view, completionHandler) in
            self?.handleStartDeleting(indexPath.row)
                                        completionHandler(true)
        }
        deleteAction.backgroundColor = .systemRed
        if (isBeingEdited) {
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
        }
        return nil
    }
    
    
}
extension PreviewAnnouncementViewController : UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        attachments?.append(urls[0])
        attachmentsTableView.isHidden = false
        attachmentsTableView.reloadData()
        //print(urls[0])
        //print([urls[0].lastPathComponent])
        
        
    }
}


