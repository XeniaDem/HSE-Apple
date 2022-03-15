//
//  NewTaskViewConrtoller.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 14.03.2022.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers
class NewTaskViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textFieldToolBar: UIToolbar!
    @IBOutlet weak var attachmentsTableView: UITableView!
    @IBOutlet weak var addPhotoBarButton: UIBarButtonItem!

    @IBOutlet weak var addFileBarButton: UIBarButtonItem!

    @IBOutlet weak var newTaskTextView: UITextView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var chooseGroupsButton: UIButton!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!

    
    var attachments: [URL] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        newTaskTextView.inputAccessoryView = textFieldToolBar
        newTaskTextView.becomeFirstResponder()
        configureNavigationBar()
        configureChooseGroupsButton()
        newTaskTextView.delegate = self
        let press = UITapGestureRecognizer(target: self,
                                           action: #selector(keyboardPressedOutside))
        view.addGestureRecognizer(press)
        setupAttachmentsTableView()
  
        
        
    }
    @IBAction func addPhotoBarButtonClick(_ sender: UIBarButtonItem) {
        let supportedTypes = [UTType.jpeg, UTType.png, UTType.heic]
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        documentPicker.shouldShowFileExtensions = true
        present(documentPicker, animated: true, completion: nil)
        
    }
    @IBAction func addFileBarButtonClick(_ sender: UIBarButtonItem) {
        let supportedTypes = [UTType.pdf, UTType.jpeg, UTType.png, UTType.rtf, UTType.text, UTType.zip]
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        documentPicker.shouldShowFileExtensions = true
        present(documentPicker, animated: true, completion: nil)
    }
    
    private func configureNavigationBar() {
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButtonClick))
        navigationItem.leftBarButtonItem = cancelButton
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(doneButtonClick))
        navigationItem.rightBarButtonItem = doneButton
        
        navigationItem.title = "Новое задание"
        
    }
    private func configureChooseGroupsButton() {
        chooseGroupsButton.setTitle("Все группы", for: .normal)
        let group1 = UIAction(title: "Группа 1") { (action) in
            self.chooseGroupsButton.setTitle("Группа 1", for: .normal)
        }
        let group2 = UIAction(title: "Группа 2") { (action) in
            self.chooseGroupsButton.setTitle("Группа 2", for: .normal)
        }
        let allGroups = UIAction(title: "Все группы") { (action) in
             self.chooseGroupsButton.setTitle("Все группы", for: .normal)
        }
        let menu = UIMenu(title: "Выбор групп", options: .displayInline, children: [group1 , group2 , allGroups])
        chooseGroupsButton.menu = menu
        chooseGroupsButton.showsMenuAsPrimaryAction = true
        
    }
    

    
    
    @objc private func cancelButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   
    @objc private func doneButtonClick(_ sender: Any) {
        let task = TaskModel(title: name.text, text: newTaskTextView.text, dateOfPublication: Date(), dateOfDeadline: deadlineDatePicker.date, groups: chooseGroupsButton.currentTitle, isRead: false, attachments: attachments)
        addTask(task: task)
        dismiss(animated: true, completion: nil)
        
        
    }
    
    @objc func keyboardPressedOutside() {
        self.view.endEditing(true)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        let press = UITapGestureRecognizer(target: self,
                                           action: #selector(keyboardPressedOutside))
        view.addGestureRecognizer(press)
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        view.gestureRecognizers?.removeAll()
    
    }
    
    private func setupAttachmentsTableView() {
        
        attachmentsTableView.register(AttachmentViewCell.self, forCellReuseIdentifier: "AttachmentViewCell")
        attachmentsTableView.dataSource = self
        attachmentsTableView.delegate = self
        //tableView.backgroundColor = UIColor.clear
        attachmentsTableView.rowHeight = 70
        attachmentsTableView.showsVerticalScrollIndicator = true
      
        attachmentsTableView.layer.cornerRadius = 20
        attachmentsTableView.layer.masksToBounds = true
        //tableView.backgroundColor = .darkGray
        
    }
    private func handleStartDeleting(_ id: Int) {
        attachments.remove(at: id)
        attachmentsTableView.reloadData()
    }
   
}
extension NewTaskViewController : UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        attachments.append(urls[0])
        attachmentsTableView.isHidden = false
        attachmentsTableView.reloadData()
        //print(urls[0])
       // print([urls[0].lastPathComponent])
        
        
    }
}
extension NewTaskViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.attachmentsTableView.dequeueReusableCell(withIdentifier: "AttachmentViewCell", for: indexPath) as! AttachmentViewCell
        cell.attachment = attachments[indexPath.row]
        cell.backgroundColor = .tertiarySystemBackground
        cell.setupCell()
        cell.layer.masksToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attachments.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if attachments[indexPath.row].pathExtension == "pdf" || attachments[indexPath.row].pathExtension == "jpeg" ||  attachments[indexPath.row].pathExtension == "png" {
        
            let vc = PreviewAttachmentViewController()
            vc.attachment = attachments[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
    }
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive,
                                       title: "Удалить") { [weak self] (action, view, completionHandler) in
            self?.handleStartDeleting(indexPath.row)
                                        completionHandler(true)
        }
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    
}

