//
//  OptionsViewController.swift
//  Quizilla
//
//  Created by Marko Kramar on 15/05/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import UIKit

class OptionsViewController: UITableViewController, BooleanOptionCellDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OptionsUtil.booleanOptions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BooleanOptionCell", for: indexPath) as! BooleanOptionCell
        
        let booleanOption = OptionsUtil.booleanOptions[indexPath.row]
        cell.label?.text = booleanOption.title
        cell.optionSwitch.setOn(booleanOption.isEnabled, animated: true)
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    func didChangeBooleanOptionSwitchValue(isEnabled: Bool, indexPath: IndexPath) {
        let option = OptionsUtil.booleanOptions[indexPath.row]
        print("Value for option \(option.title) is change to \(isEnabled)")
    }
    
    
}
