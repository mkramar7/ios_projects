//
//  Array+Only.swift
//  Memorize_assignment2
//
//  Created by Marko Kramar on 29/06/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
