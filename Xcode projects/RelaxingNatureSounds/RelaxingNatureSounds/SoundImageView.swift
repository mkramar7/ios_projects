//
//  SoundImageView.swift
//  RelaxingNatureSounds
//
//  Created by Marko Kramar on 05/10/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import SwiftUI

struct SoundImageView: View {
    @ObservedObject var sound: AudioStore.Sound
    
    var body: some View {
        ZStack(alignment: .leading) {
            Image(sound.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(sound.currentlyPlaying ? 1 : 0.8)
                .cornerRadius(8)
            
            Triangle()
                .fill(Color.white)
                .frame(width: 70, height: 35)
                .rotationEffect(.degrees(90.0))
                .opacity(sound.currentlyPlaying ? 0.8 : 0)
                .padding(.leading, -20)
                .offset(x: 3, y: 5)
            
            Text("\(sound.name)")
                .font(Font.custom("Noteworthy", size: 50))
                .foregroundColor(.white)
                .opacity(sound.currentlyPlaying ? 1 : 0)
                .padding(.leading, sound.currentlyPlaying ? 40 : 10)
                .animation(.easeInOut)
        }
        .padding(.leading, 3)
        .padding(.trailing, 3)
    }
}
