//
//  AudioPlayer.swift
//  RelaxingNatureSounds
//
//  Created by Marko Kramar on 19/08/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import AVFoundation
import MediaPlayer

class AudioPlayer {
    static let shared = AudioPlayer()
    var audioPlayer: AVAudioPlayer!
    
    init() {
        setupBackgroundAudioPlaying()
        setupCommandCenter()
    }
    
    func playSound(_ sound: AudioStore.Sound) {
        audioPlayer = try! AVAudioPlayer(contentsOf: sound.audio)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        updateNowPlayingInfo(with: sound.name)
        sound.currentlyPlaying = true
    }
    
    func stopPlayingSound(_ sound: AudioStore.Sound) {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
        sound.currentlyPlaying = false
    }
    
    func playPreviousSound() {
        playSound(fetchNextOrPreviousSound(shouldFetchPrevious: true))
    }
    
    func playNextSound() {
        playSound(fetchNextOrPreviousSound(shouldFetchPrevious: false))
    }
    
    private func fetchNextOrPreviousSound(shouldFetchPrevious: Bool) -> AudioStore.Sound {
        // If no sound is currently playing, fetch first one
        guard let currentlyPlayingSound = AudioStore.currentlyPlayingSound() else {
           return AudioStore.allSounds[0]
        }

        // Fetch and play previous (or next) sound; if first (or last), then play last (or first) sound
        let currentSoundIndex = AudioStore.allSounds.firstIndex(of: currentlyPlayingSound)!
        let indexOfSoundToFetch = shouldFetchPrevious ? currentSoundIndex-1 : currentSoundIndex+1
        return AudioStore.allSounds.indices.contains(indexOfSoundToFetch) ? AudioStore.allSounds[indexOfSoundToFetch] : AudioStore.allSounds[shouldFetchPrevious ? AudioStore.allSounds.count-1 : 0]
    }
    
    private func setupBackgroundAudioPlaying() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Could not set up background audio playing...")
        }
    }
    
    private func updateNowPlayingInfo(with soundName: String) {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyTitle: "Nature Sounds - \(soundName)"]
    }
    
    private func setupCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.audioPlayer.play()
            return .success
        }
        
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.audioPlayer.pause()
            return .success
        }
        
        commandCenter.nextTrackCommand.isEnabled = true
        commandCenter.nextTrackCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.playNextSound()
            return .success
        }
        
        commandCenter.previousTrackCommand.isEnabled = true
        commandCenter.previousTrackCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.playPreviousSound()
            return .success
        }
    }
}
