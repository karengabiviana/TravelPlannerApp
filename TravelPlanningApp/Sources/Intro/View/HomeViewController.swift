/
//  HomeViewController.swift
//  TravelPlanningApp
//
//  Created by Karen Oliveira on 26/01/24.
//

import UIKit

final class HomeViewController: UIViewController {

    var items = [String]()
    
    let alertController = UIAlertController(title: "Enter travel details: ", message: nil, preferredStyle: .alert)
    
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
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let buttonToolBar = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneToolBarButton))
        
        alertController.addTextField { textField in
            textField.placeholder = "Destination"
        }

        alertController.addTextField { textField in
            textField.placeholder = "Start Date"
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .inline
            self.alertController.textFields?[1].inputAccessoryView = toolbar
            textField.inputView = datePicker
        }

        alertController.addTextField { textField in
            textField.placeholder = "End Date"
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .inline
            self.alertController.textFields?[2].inputAccessoryView = toolbar
            textField.inputView = datePicker
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, alertController] _ in
            let destinationTextField = alertController.textFields?[0].text
            let startDateTextField = alertController.textFields?[1].text
            let endDateTextField = alertController.textFields?[2].text
//            guard let destinationTextField = alertController.textFields![0],
//                  let startDateTextField = alertController.textFields?[1],
//                  let endDateTextField = alertController.textFields?[2],
//                  let destination = destinationTextField.text,
//                  let startDateText = startDateTextField.text,
//                  let endDateText = endDateTextField.text,
//                  let startDate = dateFormatter.date(from: startDateText),
//                  let endDate = dateFormatter.date(from: endDateText)
//            else { return }

            self.submit(destination: destinationTextField ?? "???", startDate: startDateTextField ?? "???", endDate: endDateTextField ?? "???")
        }

        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }

    // DateFormatter to convert text to Date
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()

    @objc func clearItem() {

    }

    func submit (destination: String, startDate: String, endDate: String) {
        items.insert(destination, at: 0)
//        items.insert(startDate, at: 0)
//        items.insert(endDate, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func doneToolBarButton() {
        
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
