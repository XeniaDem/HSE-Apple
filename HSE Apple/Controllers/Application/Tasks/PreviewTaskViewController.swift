//
//  PreviewTaskViewController.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 14.03.2022.
//

import UIKit
import UniformTypeIdentifiers

class PreviewTaskViewController: UIViewController, UITextViewDelegate {

    var taskId: Int!
    var isBeingEdited: Bool!
    var attachments: [URL]?
    
    let taskTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .tertiarySystemBackground
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .tertiarySystemBackground
        textView.font = .systemFont(ofSize: 15, weight: .regular)
        return textView
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.isUserInteractionEnabled = false
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 21, weight: .semibold)
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
        let addPhotoButton = UIBarButtonItem(image: .init(systemName: "photo"), style: .plain, target: PreviewTaskViewController.self, action: #selector(addPhotoButtonClick))
        let addFileButton = UIBarButtonItem(image: .init(systemName: "paperclip"), style: .plain, target: PreviewTaskViewController.self, action: #selector(addFileButtonClick))
        toolBar.items = [addPhotoButton, addFileButton]
        toolBar.sizeToFit()
        return toolBar
    }()
    let deadlineDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        datePicker.isUserInteractionEnabled = false
        return datePicker
    }()
    
    let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.text = "Дедлайн:"
        return label
    }()
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        taskTextView.inputAccessoryView = textFieldToolBar
        configureNavigationBar()
        configureTasksTextView()
        configureTitleTextField()
        configureGroupsButton()
        configureDeadlineLabel()
        configureDeadlineDatePicker()
        configureAttachmentsTableView()
        view.backgroundColor = .secondarySystemBackground
        navigationItem.largeTitleDisplayMode = .never
        taskTextView.delegate = self
        
        let press = UITapGestureRecognizer(target: self,
                                           action: #selector(keyboardPressedOutside))
        if (isBeingEdited) {
            view.addGestureRecognizer(press)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.isHidden = false

    }
    
    @objc func keyboardPressedOutside() {
        self.taskTextView.endEditing(true)
    }
    private func configureFilterButton() {
        let filterButton = UIBarButtonItem(image: .init(systemName: "ellipsis"), style: .plain, target: self, action: nil)

        let submitResult = UIAction(title: "Загрузить ответ") { (action) in
            let submitAnswerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SubmitAnswerViewController") as! SubmitAnswerViewController
            let navigationVC = UINavigationController(rootViewController: submitAnswerViewController)
            navigationVC.modalPresentationStyle = .popover
            self.present(navigationVC, animated: true, completion: nil)
        }
        let viewResults = UIAction(title: "Просмотреть ответы") { (action) in
            let vc = AnswersViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.title = "Ответы на задание"
            
            
        }
        let menu = UIMenu(title: "Действия", options: .displayInline, children: [submitResult, viewResults])
        filterButton.menu = menu
        navigationItem.rightBarButtonItem = filterButton
    }
    
    private func configureNavigationBar() {
        if isBeingEdited {
            let editButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(editButtonClick))
            taskTextView.becomeFirstResponder()
            navigationItem.rightBarButtonItem = editButton
            navigationItem.title = "Редактирование"
  
        } else {
            navigationItem.title = "Просмотр"
            textFieldToolBar.isHidden = true
            configureFilterButton()
        }
        
    }
    private func configureDeadlineDatePicker() {
        deadlineDatePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
        deadlineDatePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33).isActive = true
    }
    
    private func configureDeadlineLabel() {
        view.addSubview(deadlineLabel)
        view.addSubview(deadlineDatePicker)
        deadlineLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 145).isActive = true
        deadlineLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    private func configureTasksTextView() {
        view.addSubview(taskTextView)
        taskTextView.layer.cornerRadius = 15
        taskTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 190).isActive = true
        taskTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        taskTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        taskTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -398).isActive = true
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
        attachmentsTableView.topAnchor.constraint(equalTo: taskTextView.bottomAnchor, constant: 34).isActive = true
        attachmentsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        attachmentsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        attachmentsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        
    }
    @objc private func editButtonClick(_ sender: Any) {
        editTask(taskId)
        navigationController?.popViewController(animated: true)
    }
    func configurePreviewTaskView(task: TaskModel) {
        taskTextView.text = task.text
        titleTextField.text = task.title
        groupsButton.setTitle(task.groups, for: .normal)
        attachments = task.attachments
        deadlineDatePicker.date = task.dateOfDeadline ?? Date()
        if (!(attachments?.isEmpty ?? false)) {
            attachmentsTableView.isHidden = false
        }
        attachmentsTableView.reloadData()
        
        
        
    }
    private func editTask(_ id: Int) {
        let previousDate = tasks[id].dateOfPublication
        let task = TaskModel(title: titleTextField.text, text: taskTextView.text, dateOfPublication: previousDate, dateOfDeadline: deadlineDatePicker.date, groups: groupsButton.currentTitle, isRead: true, attachments: attachments)
        replaceTask(at: id, newTask: task)
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
extension PreviewTaskViewController : UITableViewDelegate, UITableViewDataSource {
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
extension PreviewTaskViewController : UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        attachments?.append(urls[0])
        attachmentsTableView.isHidden = false
        attachmentsTableView.reloadData()
        
    }
}


class FileDownloader {
    static func loadFileSync(url: URL, completion: @escaping (String?, Error?) -> Void) {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
        if FileManager().fileExists(atPath: destinationUrl.path) {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        } else if let dataFromURL = NSData(contentsOf: url) {
            if dataFromURL.write(to: destinationUrl, atomically: true) {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil)
            } else {
                print("error saving file")
                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                completion(destinationUrl.path, error)
            }
        } else {
            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
            completion(destinationUrl.path, error)
        }
    }

    static func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void) {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
        if FileManager().fileExists(atPath: destinationUrl.path) {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        } else {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler: {
                data, response, error in
                if error == nil {
                    if let response = response as? HTTPURLResponse {
                        if response.statusCode == 200 {
                            if let data = data {
                                if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic) {
                                    completion(destinationUrl.path, error)
                                }
                                else {
                                    completion(destinationUrl.path, error)
                                }
                            }
                            else {
                                completion(destinationUrl.path, error)
                            }
                        }
                    }
                }
                else {
                    completion(destinationUrl.path, error)
                }
            })
            task.resume()
        }
    }
}
