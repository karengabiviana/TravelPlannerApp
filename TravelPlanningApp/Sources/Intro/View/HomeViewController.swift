//
//  HomeViewController.swift
//  TravelPlanningApp
//
//  Created by Karen Oliveira on 26/01/24.
//

import UIKit

final class HomeViewController: UIViewController {

    var items = [String]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "item")
        return tableView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()

    }

    func configureNavigationBar() {
        self.navigationItem.title = "Travel Planner"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearItem))
    }

    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 40
        tableView.pin(to: view)
    }

    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    @objc func addItem() {
        let alertController = UIAlertController(title: "Enter a travel name: ", message: nil, preferredStyle: .alert)
        alertController.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, alertController] _ in
            let item = alertController.textFields![0].text
            self.submit(item!)
        }
        alertController.addAction(submitAction)
        present(alertController, animated: true)

    }

    @objc func clearItem() {

    }

    func submit (_ item: String) {
        items.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }

}
