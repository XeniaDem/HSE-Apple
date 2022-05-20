//
//  ConversationsViewController.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 09.02.2022.
//

import UIKit
//import MessageKit

class ConversationsViewController: UIViewController {

   
    var conversationsTableView: UITableView!
    var cellSpacingHeight: CGFloat = 5


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Чаты"
        navigationItem.largeTitleDisplayMode = .always
        
        setupConversationsTableView()
        configureNewConversationButton()
        
    }
   
    private func setupConversationsTableView() {
        conversationsTableView = UITableView()
        conversationsTableView.frame = view.bounds
        conversationsTableView.register(ConversationViewCell.self, forCellReuseIdentifier: "cell")
        
        conversationsTableView.dataSource = self
        conversationsTableView.delegate = self
        
        conversationsTableView.rowHeight = 80
        conversationsTableView.showsVerticalScrollIndicator = true
        conversationsTableView.translatesAutoresizingMaskIntoConstraints = false
        conversationsTableView.layer.cornerRadius = 20
        conversationsTableView.layer.masksToBounds = true
        conversationsTableView.backgroundColor = .secondarySystemBackground
        
        
        self.view.addSubview(conversationsTableView)
        
        
    }
    
    @objc private func newConversationButtonClick(_ sender: Any) {
        let newConversationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NewConversationViewController")
        let navigationVC = UINavigationController(rootViewController: newConversationViewController)
        //navigationVC.modalPresentationStyle = .fullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    private func configureNewConversationButton() {
        let newConversationButton = UIBarButtonItem(image: .init(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(newConversationButtonClick))
        newConversationButton.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = newConversationButton
    }


 

}
extension ConversationsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConversationViewCell
        cell.setupCell()
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = ChatViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return cellSpacingHeight
    }
}
