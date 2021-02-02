//
//  ViewController.swift
//  Core Skills
//
//  Created by Marko Kramar on 26/04/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myLastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myLabel.text = "Changes with Code!"
        myTextField.becomeFirstResponder()
        myTextField.delegate = self
        myLastNameTextField.delegate = self
    }

    @IBAction func buttonWasPressed(_ sender: Any) {
        myLabel.text = "Hello \(myTextField.text!) \(myLastNameTextField.text!)!"
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
}

