//
//  IntroViewController.swift
//  TravelPlanningApp
//
//  Created by Karen Oliveira on 26/01/24.
//

import UIKit

final class IntroViewController: UIViewController {

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Planning Travel"
        configureTableView()

    }

    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 40
        tableView.pin(to: view)
        tableView.backgroundColor = .green
    }

    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension IntroViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
