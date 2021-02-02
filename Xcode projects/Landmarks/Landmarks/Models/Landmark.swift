//
//  Landmark.swift
//  Landmarks
//
//  Created by Marko Kramar on 08/07/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable {
    var id: Int
    var name: String
    fileprivate var imageName: String
    fileprivate var coordinate: Coordinates
    
    
}

extension Landmark {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}

stu
