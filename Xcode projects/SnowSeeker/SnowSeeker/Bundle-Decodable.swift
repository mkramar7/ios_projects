//
//  Bundle-Decodable.swift
//  SnowSeeker
//
//  Created by Marko Kramar on 11.12.2020..
//

import SwiftUI

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        return loaded
    }
}
