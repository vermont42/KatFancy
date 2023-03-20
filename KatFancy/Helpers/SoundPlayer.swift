// Created by Josh Adams, who holds the copyright and reserves all rights, on 1/6/23.

protocol SoundPlayer {
  func play(_ sound: Sound, didSucceed: @escaping (Bool) -> ())
}

extension SoundPlayer {
  func play(_ sound: Sound) {
    play(sound, didSucceed: { _ in })
  }
}
