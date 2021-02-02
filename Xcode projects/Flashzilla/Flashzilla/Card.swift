//
//  Card.swift
//  Flashzilla
//
//  Created by Marko Kramar on 19.11.2020..
//

import SwiftUI

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
