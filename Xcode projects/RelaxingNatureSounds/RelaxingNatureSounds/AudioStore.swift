//
//  SoundsStore.swift
//  RelaxingNatureSounds
//
//  Created by Marko Kramar on 20/08/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import Foundation

struct AudioStore {
    static let allSounds = [
        Sound("Birds"),
        Sound("Cave"),
        Sound("Cold winter day"),
        Sound("Desert"),
        Sound("Hot summer day"),
        Sound("Mountains"),
        Sound("Rain"),
        Sound("Rainforest")
    ]
    
    static func findSound(id: UUID) -> Sound {
        allSounds.filter { $0.id == id }.first!
    }
    
    static func currentlyPlayingSound() -> Sound? {
        AudioStore.allSounds.filter({ $0.currentlyPlaying }).first
    }
    
    class Sound: Hashable, Identifiable, ObservableObject {
        var id = UUID()
        var name: String
        var audio: URL
        var image: String
        @Published var currentlyPlaying = false {
            willSet {
                // If sound is set to be currently playing, all other sounds should be marked as not currently playing
                if newValue {
                    AudioStore.allSounds.forEach { $0.currentlyPlaying = false }
                }
            }
        }
        
        init(_ name: String) {
            self.name = name
            self.audio = Bundle.main.url(forResource: name, withExtension: "wav")!
            self.image = name
        }
        
        static func == (lhs: Sound, rhs: Sound) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
}
