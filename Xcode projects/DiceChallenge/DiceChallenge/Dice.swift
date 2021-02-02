//
//  Dice.swift
//  DiceChallenge
//
//  Created by Marko Kramar on 07.12.2020..
//

import SwiftUI

struct Dice: Hashable {
    var sides: Int
    var result: Int
}

class Dices: ObservableObject {
    @Published var allDices = [Dice]()
}
