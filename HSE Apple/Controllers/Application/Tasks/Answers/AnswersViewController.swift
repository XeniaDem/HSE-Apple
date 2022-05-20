//
//  AnswersViewController.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 20.05.2022.
//

import UIKit
class AnswersViewController: UIViewController {

    var tableView: UITableView!
    var cellSpacingHeight: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Ответы на задания"
        navigationItem.largeTitleDisplayMode = .never
        setupAnswersTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .secondarySystemBackground
        
        navigationController?.hidesBarsOnSwipe = true
        tableView.reloadData()
    }
    
    private func setupAnswersTableView() {
        tableView = UITableView()
        tableView.frame = view.bounds
        tableView.backgroundColor = .secondarySystemBackground
        
        tableView.register(AnswerViewCell.self, forCellReuseIdentifier: "AnswerViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 70
        tableView.showsVerticalScrollIndicator = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 20
        tableView.layer.masksToBounds = true
        self.view.addSubview(tableView)
    }

}
extension AnswersViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "AnswerViewCell", for: indexPath) as! AnswerViewCell
        cell.setupCell()

        cell.layer.masksToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
        let viewAnswerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewAnswerViewController") as! ViewAnswerViewController
        let navigationVC = UINavigationController(rootViewController: viewAnswerViewController)
        navigationVC.modalPresentationStyle = .popover
        self.present(navigationVC, animated: true, completion: nil)
        
    }

}
