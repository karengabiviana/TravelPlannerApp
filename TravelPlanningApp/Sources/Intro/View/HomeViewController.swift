//
//  HomeViewController.swift
//  TravelPlanningApp
//
//  Created by Karen Oliveira on 26/01/24.
//

import UIKit

final class HomeViewController: UIViewController {

    var items = [String]()
    
    let datePicker = UIDatePicker()
    var activeTextField: UITextField? // Variable to keep track of the active text field
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "item")
        return tableView
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
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
        let alertController = UIAlertController(title: "Enter travel details: ", message: nil, preferredStyle: .alert)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneToolBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneToolBarButtonPressed))
        toolbar.setItems([doneToolBarButton], animated: true)
        
        alertController.addTextField { textField in
            textField.placeholder = "Destination"
        }

        alertController.addTextField { textField in
            textField.placeholder = "Start Date"
            self.datePicker.datePickerMode = .date
            self.datePicker.preferredDatePickerStyle = .inline
            textField.inputAccessoryView = toolbar
            textField.inputView = self.datePicker
            textField.delegate = self // Set the delegate
        }

        alertController.addTextField { textField in
            textField.placeholder = "End Date"
            self.datePicker.datePickerMode = .date
            self.datePicker.preferredDatePickerStyle = .inline
            textField.inputAccessoryView = toolbar
            textField.inputView = self.datePicker
            textField.delegate = self // Set the delegate
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, alertController] _ in
            let destinationTextField = alertController.textFields?[0].text
            let startDateTextField = alertController.textFields?[1].text
            let endDateTextField = alertController.textFields?[2].text
            let startDate = dateFormatter.date(from: startDateTextField ?? "01/01/2001")
            let endDate = dateFormatter.date(from: endDateTextField ?? "01/01/2001")

            self.submit(destination: destinationTextField ?? "???", startDate: startDate ?? Date(), endDate: endDate ?? Date())
        }

        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }

    @objc func clearItem() {
        // Implementation for clearing items if needed
    }

    func submit(destination: String, startDate: Date, endDate: Date) {
        items.insert(destination, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func doneToolBarButtonPressed() {
        if let activeTextField = activeTextField {
            activeTextField.text = dateFormatter.string(from: datePicker.date)
        }
        self.view.endEditing(true)
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

extension HomeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
}
