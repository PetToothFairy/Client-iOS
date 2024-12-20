//
//  AudioPlayer.swift
//  PetToothFairy
//
//  Created by 임주민 on 12/16/24.
//

import Foundation
import AVKit

class AudioPlayer: ObservableObject {
  private var player: AVPlayer?
  
  func playAudio(named audioName: String) {
    stopAudio()
    
    if let url = Bundle.main.url(forResource: audioName, withExtension: "mp3") {
      player = AVPlayer(url: url)
      player?.play()
    } else {
      print("Error: Audio file \(audioName).mp3 not found in the bundle.")
    }
  }
  
  func playStartAudio() {
    playAudio(named: "audio_start")
  }
  
  func playMiddleAudio() {
    playAudio(named: "audio_middle")
  }
  
  func playEndAudio() {
    playAudio(named: "audio_end")
  }
  
  func pauseAudio() {
    player?.pause()
  }
  
  func stopAudio() {
    player?.pause()
    player = nil
  }
}
