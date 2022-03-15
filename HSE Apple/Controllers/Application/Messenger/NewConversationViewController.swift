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
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       // table.isHidden = true
        return table
    }()
    
    private let noUsersFoundLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет результатов"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.isHidden = true;
        return label
    }()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        
        searchBar.tintColor = .white
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white

        navigationController?.navigationBar.topItem?.titleView = searchBar
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(dismissSelf))
        cancelButton.tintColor = .white
        navigationItem.rightBarButtonItem = cancelButton
        view.addSubview(foundUsersTableView)
        fetchUsers()
        //setupTableView()
        
    }
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    private func fetchUsers() {
        foundUsersTableView.isHidden = false;
    }
    private func setupTableView() {
        //conversationsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        foundUsersTableView.register(ConversationViewCell.self, forCellReuseIdentifier: "cell")
        foundUsersTableView.delegate = self
        foundUsersTableView.dataSource = self
        foundUsersTableView.frame = view.bounds
        foundUsersTableView.backgroundColor = .init(red: 21.0/255.0, green: 22.0/255.0, blue: 43.0/255.0, alpha: 1.0)
    }
    

}
extension NewConversationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
extension NewConversationViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConversationViewCell

        cell.textLabel?.text = "Ksenia"
        cell.backgroundColor = .clear
        cell.textLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        cell.textLabel?.textColor = .white
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChatViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
