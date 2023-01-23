//
//  SoundPlayer.swift
//  KatFancy
//
//  Created by Josh Adams on 5/28/21.
//

protocol SoundPlayer {
  func play(_ sound: Sound, didSucceed: @escaping (Bool) -> ())
}

extension SoundPlayer {
  func play(_ sound: Sound) {
    play(sound, didSucceed: { _ in })
  }
}
