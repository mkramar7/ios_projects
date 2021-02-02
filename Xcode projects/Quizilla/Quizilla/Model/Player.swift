//
//  Player.swift
//  Quizilla
//
//  Created by Marko Kramar on 15/05/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//
import Foundation

class Player: Codable {
    let id: String
    var name: String
    var highScore: Int?
    
    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
    }
    
    convenience init(name: String, highScore: Int) {
        self.init(name: name)
        self.highScore = highScore
    }
}
