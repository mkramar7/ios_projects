//
//  OptionsUtil.swift
//  Quizilla
//
//  Created by Marko Kramar on 15/05/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import Foundation
// Boolean options

class OptionsUtil {
    static let booleanOptions: [BooleanOption] = [
        BooleanOption(id: "dark_mode", title: "Use dark mode", isEnabled: false),
        BooleanOption(id: "continue_if_wrong", title: "Allow wrong answer", isEnabled: false)
    ]
}

// Protocols required for different option types
protocol BooleanOptionCellDelegate {
    func didChangeBooleanOptionSwitchValue(isEnabled: Bool, indexPath: IndexPath)
}
