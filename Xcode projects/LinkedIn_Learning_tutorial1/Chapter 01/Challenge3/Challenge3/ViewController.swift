//
//  ViewController.swift
//  Challenge3
//
//  Created by Marko Kramar on 28/04/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let label = UILabel()
        label.text = "Name: "
        view.addSubview(label)
        
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 0).isActive = true
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        label.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
        textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
}
