//
//  MockedData.swift
//  Quizilla
//
//  Created by Marko Kramar on 15/05/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import UIKit

class MockedData {
    static let mockedPlayers = [
        Player(name: "Pero", highScore: 100),
        Player(name: "Joža", highScore: 130),
        Player(name: "Ivo", highScore: 340),
        Player(name: "Jelena", highScore: 500),
        Player(name: "Marko", highScore: 501),
        Player(name: "Đurđa"),
        Player(name: "Mirko")
    ]
    
    class func allPlayersWithHighScore() -> [Player] {
        return mockedPlayers.filter( { $0.highScore != nil } )
    }
}
