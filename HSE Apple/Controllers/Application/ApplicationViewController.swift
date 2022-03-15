//
//  ApplicationViewController.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 08.02.2022.
//

import UIKit

class ApplicationViewController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        //tableView.frame = view.bounds
//    }
//
//    private func setupTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//    private func fetchConversations() {
//        //to be done
//        tableView.isHidden = false;
//    }
//
//}
//extension ApplicationViewController : UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "HEllO"
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        let vc = ChatViewController()
//        vc.title = "heejj"
//        vc.navigationItem.largeTitleDisplayMode = .never
//        navigationController?.pushViewController(vc, animated: true)
//    }
//
//
//
//}
}
