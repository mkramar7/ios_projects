//
//  GameViewController.swift
//  Quizilla
//
//  Created by Marko Kramar on 17/05/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet var questionNumberLabel: UILabel!
    @IBOutlet var timeLeftLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var questionText: UITextView!
    @IBOutlet var answerButtons: [UIButton]!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    @IBAction func answerGiven(_ sender: UIButton) {
        
    }
}
