//
//  RequestsViewController.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 13.03.2022.
//

import UIKit
class RequestsViewController: UIViewController {

    var tableView: UITableView!
    var cellSpacingHeight: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Запросы"
        navigationItem.largeTitleDisplayMode = .never
        setupRequestsTableView()
        //configureNewAnnouncementButton()
        //configureFilterButton()
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .secondarySystemBackground
        
        navigationController?.hidesBarsOnSwipe = true
        tableView.reloadData()
    }
    
    
    private func setupRequestsTableView() {
        tableView = UITableView()
        tableView.frame = view.bounds
        tableView.backgroundColor = .secondarySystemBackground
        
        tableView.register(RequestViewCell.self, forCellReuseIdentifier: "RequestViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = 70
        tableView.showsVerticalScrollIndicator = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 20
        tableView.layer.masksToBounds = true
        //tableView.backgroundColor = .darkGray
        self.view.addSubview(tableView)
    }
    
//    private func handleStartEditing(_ id: Int) {
//        let vc = PreviewAnnouncementViewController()
//        vc.isBeingEdited = true
//        vc.configurePreviewAnnouncementView(announcement: announcements[id])
//        vc.titleTextField.isUserInteractionEnabled = true
//        //vc.announcementTextView.isUserInteractionEnabled = true
//        vc.announcementTextView.isEditable = true
//        vc.groupsButton.isUserInteractionEnabled = true
//        vc.announcementId = id
//        navigationController?.pushViewController(vc, animated: true)
//    }
//
//    private func handleStartDeleting(_ id: Int) {
//        removeAnnouncement(at: id)
//        tableView.reloadData()
//    }
//    private func handleMarkAsUnread(_ id: Int) {
//        announcements[id].isRead = false
//        tableView.reloadData()
//    }
}
extension RequestsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "RequestViewCell", for: indexPath) as! RequestViewCell
        cell.setupCell()
//        if cell.announcementModel.isRead == true {
//            cell.makeRead()
//        }
//
        cell.layer.masksToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let cell = tableView.cellForRow(at: indexPath) as! AnnouncementViewCell
//        cell.makeRead()
//        announcements[indexPath.row].isRead = true
//        let vc = PreviewAnnouncementViewController()
//        vc.isBeingEdited = false
//        vc.configurePreviewAnnouncementView(announcement: announcements[indexPath.row])
//        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                       title: "Удалить") { [weak self] (action, view, completionHandler) in
           // self?.handleStartDeleting(indexPath.row)
                                        completionHandler(true)
        }
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    func tableView(_ tableView: UITableView,
                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let unreadAction = UIContextualAction(style: .normal,
                                       title: "Пометить как непрочитанное") { [weak self] (action, view, completionHandler) in
            //self?.handleMarkAsUnread(indexPath.row)
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
