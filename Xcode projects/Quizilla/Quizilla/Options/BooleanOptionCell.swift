//
//  BooleanOptionCell.swift
//  Quizilla
//
//  Created by Marko Kramar on 15/05/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import UIKit

class BooleanOptionCell: UITableViewCell {
    var delegate: BooleanOptionCellDelegate?
    var value: Bool = false
    var indexPath: IndexPath?
    
    @IBOutlet var label: UILabel!
    @IBOutlet var optionSwitch: UISwitch!
    
    @IBAction func changeBooleanValue(_ sender: UISwitch) {
        self.value = sender.isOn
        self.delegate?.didChangeBooleanOptionSwitchValue(isEnabled: self.value, indexPath: self.indexPath!)
    }
    
}
