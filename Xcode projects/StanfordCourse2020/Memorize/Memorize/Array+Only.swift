//
//  Array+Only.swift
//  Memorize
//
//  Created by Marko Kramar on 26/06/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
