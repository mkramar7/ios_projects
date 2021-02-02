//
//  HighScoreViewController.swift
//  Quizilla
//
//  Created by Marko Kramar on 15/05/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import UIKit

class HighScoreViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MockedData.allPlayersWithHighScore().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath)
        
        let highScoreItem = MockedData.allPlayersWithHighScore()[indexPath.row]
        cell.textLabel?.text = highScoreItem.name
        cell.detailTextLabel?.text = String(highScoreItem.highScore!)
        
        return cell
    }

}
