//
//  IntroViewController.swift
//  TravelPlanningApp
//
//  Created by Karen Oliveira on 26/01/24.
//

import UIKit

final class IntroViewController: UIViewController {

    private lazy var helloWorldLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, World!"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta

        addSubviews()
        constraintsLabel()

    }

    func addSubviews() {
        view.addSubview(helloWorldLabel)
    }

    func constraintsLabel() {
        helloWorldLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorldLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}

