//
//  AnnouncementsViewController.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 11.02.2022.
//

import UIKit
class AnnouncementsViewController: UIViewController {

    var tableView: UITableView!
    var cellSpacingHeight: CGFloat = 10

    @IBOutlet weak var noAnnouncementsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Объявления"
        
        setupAnnouncementsTableView()
        configureNewAnnouncementButton()
       
        
    }
    private func configureNewAnnouncementButton() {
        let newAnnouncementButton = UIBarButtonItem(image: .init(systemName: "plus"), style: .plain, target: self, action: #selector(newAnnouncementButtonClick))
        navigationItem.rightBarButtonItem = newAnnouncementButton
    }
    private func configureFilterButton() {
        let filterButton = UIBarButtonItem(image: .init(systemName: "ellipsis"), style: .plain, target: self, action: nil)

        let readAll = UIAction(title: "Прочитать все") { (action) in
            for i in 0 ..< (announcements.count) {
                announcements[i].isRead = true
            }
            self.tableView.reloadData()
        }
        let menu = UIMenu(title: "Действия", options: .displayInline, children: [readAll])
        filterButton.menu = menu
        navigationItem.leftBarButtonItem = filterButton
        if (announcements.isEmpty) {
            filterButton.isEnabled = false
        }
        //filterButton.showsMenuAsPrimaryAction = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (announcements.isEmpty) {
            tableView.isHidden = true
            noAnnouncementsLabel.isHidden = false
        } else {
            tableView.isHidden = false
            noAnnouncementsLabel.isHidden = true
        }
        view.backgroundColor = .secondarySystemBackground
        navigationItem.largeTitleDisplayMode = .always
        tableView.reloadData()
        configureFilterButton()
        
    }
    
    @objc private func newAnnouncementButtonClick() {
        let newAnnouncementViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NewAnnouncementViewController") as! NewAnnouncementViewController
        let navigationVC = UINavigationController(rootViewController: newAnnouncementViewController)
        navigationVC.modalPresentationStyle = .fullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    private func setupAnnouncementsTableView() {
        tableView = UITableView()
        tableView.frame = view.bounds
        tableView.backgroundColor = .secondarySystemBackground
        
        tableView.register(AnnouncementViewCell.self, forCellReuseIdentifier: "AnnouncementViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = 100
        tableView.showsVerticalScrollIndicator = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 20
        tableView.layer.masksToBounds = true
        self.view.addSubview(tableView)
        if (announcements.isEmpty) {
            tableView.isHidden = true
            noAnnouncementsLabel.isHidden = false
        } else {
            tableView.isHidden = false
            noAnnouncementsLabel.isHidden = true
        }
    }
    
    private func handleStartEditing(_ id: Int) {
        let vc = PreviewAnnouncementViewController()
        vc.isBeingEdited = true
        vc.configurePreviewAnnouncementView(announcement: announcements[id])
        vc.titleTextField.isUserInteractionEnabled = true
        //vc.announcementTextView.isUserInteractionEnabled = true
        vc.announcementTextView.isEditable = true
        vc.groupsButton.isUserInteractionEnabled = true
        vc.announcementId = id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleStartDeleting(_ id: Int) {
        removeAnnouncement(at: id)
        tableView.reloadData()
        configureFilterButton()
        if (announcements.isEmpty) {
            tableView.isHidden = true
            noAnnouncementsLabel.isHidden = false
        } else {
            tableView.isHidden = false
            noAnnouncementsLabel.isHidden = true
        }
    }
    private func handleMarkAsUnread(_ id: Int) {
        announcements[id].isRead = false
        tableView.reloadData()
    }
}
extension AnnouncementsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "AnnouncementViewCell", for: indexPath) as! AnnouncementViewCell
        cell.announcementModel = announcements[indexPath.row]
        cell.setupCell()
        if cell.announcementModel.isRead == true {
            cell.makeRead()
        }
        
        cell.layer.masksToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcements.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! AnnouncementViewCell
        cell.makeRead()
        announcements[indexPath.row].isRead = true
        let vc = PreviewAnnouncementViewController()
        vc.isBeingEdited = false
        vc.configurePreviewAnnouncementView(announcement: announcements[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal,
                                        title: "Редактировать") { [weak self] (action, view, completionHandler) in
            self?.handleStartEditing(indexPath.row)
                                            completionHandler(true)
        }
        editAction.backgroundColor = .systemBlue
        let deleteAction = UIContextualAction(style: .destructive,
                                       title: "Удалить") { [weak self] (action, view, completionHandler) in
            self?.handleStartDeleting(indexPath.row)
                                        completionHandler(true)
        }
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [editAction, deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    func tableView(_ tableView: UITableView,
                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let unreadAction = UIContextualAction(style: .normal,
                                       title: "Пометить как непрочитанное") { [weak self] (action, view, completionHandler) in
            self?.handleMarkAsUnread(indexPath.row)
                                        completionHandler(true)
        }
        unreadAction.backgroundColor = .systemOrange
        let configuration = UISwipeActionsConfiguration(actions: [unreadAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return cellSpacingHeight
    }
}
