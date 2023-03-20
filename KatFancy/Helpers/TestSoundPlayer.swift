// Created by Josh Adams, who holds the copyright and reserves all rights, on 1/6/23.

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
