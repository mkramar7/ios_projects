//
//  BooleanOption.swift
//  Quizilla
//
//  Created by Marko Kramar on 15/05/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

class BooleanOption {
    var id: String
    var title: String
    var isEnabled: Bool
    
    init(id: String, title: String, isEnabled: Bool) {
        self.id = id
        self.title = title
        self.isEnabled = isEnabled
    }
}
