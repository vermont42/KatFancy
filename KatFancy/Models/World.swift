// Created by Josh Adams, who holds the copyright and reserves all rights, on 1/6/23.
// https://www.pointfree.co/blog/posts/21-how-to-control-the-world

import Foundation

var Current = World.chooseWorld()

class World: ObservableObject {
  @Published var settings: Settings
  @Published var soundPlayer: SoundPlayer
  @Published var imageLoader: ImageLoader

  init(settings: Settings, soundPlayer: SoundPlayer, imageLoader: ImageLoader) {
    self.settings = settings
    self.soundPlayer = soundPlayer
    self.imageLoader = imageLoader
  }

  static func chooseWorld() -> World {
#if targetEnvironment(simulator)
    if NSClassFromString("XCTest") != nil {
      return World.unitTest
    } else {
      return World.simulator
    }
#else
    return World.device
#endif
  }

  static let device: World = {
    return World(
      settings: Settings(getterSetter: UserDefaultsGetterSetter()),
      soundPlayer: RealSoundPlayer(),
      imageLoader: ImageLoader()
    )
  }()

  static let simulator: World = {
    return World(
      settings: Settings(getterSetter: UserDefaultsGetterSetter()),
      soundPlayer: RealSoundPlayer(),
      imageLoader: ImageLoader()
    )
  }()

  static let unitTest: World = {
    return World(
      settings: Settings(getterSetter: DictionaryGetterSetter()),
      soundPlayer: TestSoundPlayer(),
      imageLoader: ImageLoader()
    )
  }()
}
