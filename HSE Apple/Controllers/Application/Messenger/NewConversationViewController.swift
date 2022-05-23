//
//  NewConversationViewController.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 10.02.2022.
//

import UIKit

class NewConversationViewController: UIViewController {

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar();
        searchBar.placeholder = "Поиск пользователей"
        return searchBar
    }()
    
    private let foundUsersTableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "UserViewCell")
       // table.isHidden = true
        return table
    }()
    
    private let noUsersFoundLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет результатов"
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.isHidden = true;
        return label
    }()
    
    private let newGroupChatButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Групповой чат", style: .plain, target: NewConversationViewController.self, action: #selector(dismissSelf))
        
        button.tintColor = .systemBlue

        return button
    }()
   
     
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()

        navigationController?.navigationBar.topItem?.titleView = searchBar
//        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(dismissSelf))
//        //navigationItem.rightBarButtonItem = cancelButton
//
        fetchUsers()
        setupTableView()
        setupNewGroupChatButton()
        
        
    }
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    private func fetchUsers() {
        foundUsersTableView.isHidden = false;
    }
    private func setupTableView() {
        foundUsersTableView.register(UserViewCell.self, forCellReuseIdentifier: "UserViewCell")
        foundUsersTableView.delegate = self
        foundUsersTableView.dataSource = self
        foundUsersTableView.frame = view.bounds
        foundUsersTableView.rowHeight = 60
        foundUsersTableView.backgroundColor = .secondarySystemBackground
        view.addSubview(foundUsersTableView)
    }
    
    private func setupNewGroupChatButton() {
        navigationItem.rightBarButtonItem = newGroupChatButton
    }
    
    @objc private func newGroupChatButtonClick() {
        dismissSelf()
        
    }
    

}
extension NewConversationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
extension NewConversationViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserViewCell", for: indexPath) as! UserViewCell

        cell.setupCell()
    
        cell.textLabel?.textColor = .black
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChatViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}
