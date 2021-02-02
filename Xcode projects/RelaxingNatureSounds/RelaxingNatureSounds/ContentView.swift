//
//  ContentView.swift
//  RelaxingNatureSounds
//
//  Created by Marko Kramar on 19/08/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countdownStarted = false
    @State private var countdownSeconds = 0 {
        didSet {
            if countdownSeconds == 0 {
                if let currentlyPlayingSound = AudioStore.currentlyPlayingSound() {
                    AudioPlayer.shared.stopPlayingSound(currentlyPlayingSound)
                }
            }
        }
    }
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    if countdownStarted && countdownSeconds != 0 {
                        Text("Sounds will stop playing after \(self.getHoursAndMinutesAndSeconds())")
                            .onReceive(timer) { _ in
                                if self.countdownSeconds > 0 {
                                    self.countdownSeconds -= 1
                                }
                            }
                    }
                    
                    ForEach(AudioStore.allSounds) { sound in
                        Button(action: {
                            self.playOrStopPlaying(sound)
                        }) {
                            SoundImageView(sound: sound)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.bottom, 92)
                
                GoogleAdBannerView()
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarItems(leading: NavigationLink(destination: AlarmView(secondsUntilStop: $countdownSeconds, countdownStarted: $countdownStarted),
                                                        label: { Image(systemName: "clock").resizable().scaleEffect(1.4) }
            ))
            .navigationBarTitle("Sounds of Nature")
        }
        .environment(\.colorScheme, .dark)
    }
    
    func playOrStopPlaying(_ sound: AudioStore.Sound) {
        if (sound.currentlyPlaying) {
            AudioPlayer.shared.stopPlayingSound(sound)
            return;
        }
        
        AudioPlayer.shared.playSound(sound)
    }
    
    func getHoursAndMinutesAndSeconds() -> String {
        let hours = self.countdownSeconds / 3600
        let minutes = self.countdownSeconds / 60
        let seconds = self.countdownSeconds % 60
        
        if hours == 0 && minutes == 0 {
            return "\(seconds) second\(seconds == 1 ? "" : "s")"
        }
        
        var exactTimeString = ""
        if hours > 0 {
            exactTimeString = "\(hours) hour\(hours == 1 ? "" : "s") "
        }
        
        exactTimeString += "\(minutes) minute\(minutes == 1 ? "" : "s") "
        exactTimeString += "\(seconds) second\(seconds == 1 ? "" : "s")"
        return exactTimeString
    }
}
