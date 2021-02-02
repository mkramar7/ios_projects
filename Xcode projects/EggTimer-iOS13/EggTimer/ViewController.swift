//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        player = try! AVAudioPlayer(contentsOf: url!)
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
    
        secondsPassed = 0
        progressView.progress = 0.0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed <= totalTime {
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressView.progress = percentageProgress
            secondsPassed += 1
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            player.play()
        }
    }
    
}
