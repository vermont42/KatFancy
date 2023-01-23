//
//  TestSoundPlayer.swift
//  KatFancy
//
//  Created by Josh Adams on 5/28/21.
//

class TestSoundPlayer: SoundPlayer {
  private let alwaysFail: Bool

  init(alwaysFail: Bool = false) {
    self.alwaysFail = alwaysFail
  }

  func play(_ sound: Sound, didSucceed: @escaping (Bool) -> ()) {
    print("SOUND: \(sound.rawValue)")
    didSucceed(!alwaysFail)
  }
}
