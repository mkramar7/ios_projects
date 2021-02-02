//
//  ViewController.swift
//  TableViews
//
//  Created by Marko Kramar on 28/04/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var text: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        textView.text = text
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textView.text = text
    }
    
    


}

