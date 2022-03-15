//
//  TasksViewController.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 14.03.2022.
//

import UIKit
class TasksViewController: UIViewController {

    var tableView: UITableView!
    var cellSpacingHeight: CGFloat = 10

    @IBOutlet weak var noTasksLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Задания"
        
        configureNewTaskButton()
        setupTasksTableView()
     
        
        
    }
    private func configureNewTaskButton() {
        let newTaskButton = UIBarButtonItem(image: .init(systemName: "plus"), style: .plain, target: self, action: #selector(newTaskButtonClick))
        navigationItem.rightBarButtonItem = newTaskButton
    }
    private func configureFilterButton() {
        let filterButton = UIBarButtonItem(image: .init(systemName: "ellipsis"), style: .plain, target: self, action: nil)

        let readAll = UIAction(title: "Прочитать все") { (action) in
            for i in 0 ..< (tasks.count) {
                tasks[i].isRead = true
            }
            self.tableView.reloadData()
        }
        let menu = UIMenu(title: "Выбор групп", options: .displayInline, children: [readAll])
        filterButton.menu = menu
        navigationItem.leftBarButtonItem = filterButton
        if (tasks.isEmpty) {
            filterButton.isEnabled = false
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (tasks.isEmpty) {
            tableView.isHidden = true
            noTasksLabel.isHidden = false
        } else {
            tableView.isHidden = false
            noTasksLabel.isHidden = true
        }
        view.backgroundColor = .secondarySystemBackground
        navigationItem.largeTitleDisplayMode = .always
        tableView.reloadData()
        configureFilterButton()
        
    }
  
    @objc private func newTaskButtonClick() {
        let newTaskViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NewTaskViewController") as! NewTaskViewController
        
        let navigationVC = UINavigationController(rootViewController: newTaskViewController)
        navigationVC.modalPresentationStyle = .fullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    private func setupTasksTableView() {
        tableView = UITableView()
        tableView.frame = view.bounds
        tableView.backgroundColor = .secondarySystemBackground
        tableView.register(TaskViewCell.self, forCellReuseIdentifier: "TaskViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.showsVerticalScrollIndicator = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 20
        tableView.layer.masksToBounds = true
        self.view.addSubview(tableView)
        if (tasks.isEmpty) {
            tableView.isHidden = true
            noTasksLabel.isHidden = false
        } else {
            tableView.isHidden = false
            noTasksLabel.isHidden = true
        }
    }
   
    private func handleStartEditing(_ id: Int) {
        let vc = PreviewTaskViewController()
        vc.isBeingEdited = true
        vc.configurePreviewTaskView(task: tasks[id])
        vc.titleTextField.isUserInteractionEnabled = true
        vc.taskTextView.isEditable = true
        vc.groupsButton.isUserInteractionEnabled = true
        vc.deadlineDatePicker.isUserInteractionEnabled = true
        vc.taskId = id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleStartDeleting(_ id: Int) {
        removeTask(at: id)
        tableView.reloadData()
        configureFilterButton()
        if (tasks.isEmpty) {
            tableView.isHidden = true
            noTasksLabel.isHidden = false
        } else {
            tableView.isHidden = false
            noTasksLabel.isHidden = true
        }
    }
    private func handleMarkAsUnread(_ id: Int) {
        tasks[id].isRead = false
        tableView.reloadData()
    }
}
extension TasksViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TaskViewCell", for: indexPath) as! TaskViewCell
        cell.taskModel = tasks[indexPath.row]
        cell.setupCell()
        if cell.taskModel.isRead == true {
            cell.makeRead()
        }
        
        cell.layer.masksToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! TaskViewCell
        cell.makeRead()
        tasks[indexPath.row].isRead = true
        let vc = PreviewTaskViewController()
        vc.isBeingEdited = false
        vc.configurePreviewTaskView(task: tasks[indexPath.row])
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
