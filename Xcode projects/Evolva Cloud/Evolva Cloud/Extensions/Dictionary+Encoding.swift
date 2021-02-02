//
//  Dictionary+Encoding.swift
//  Evolva Cloud
//
//  Created by Marko Kramar on 25.01.2021..
//

import Foundation

extension Dictionary {
    func ampersandEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}
