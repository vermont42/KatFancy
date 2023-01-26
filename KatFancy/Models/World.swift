//
//  World.swift
//  KatFancy
//
//  Created by Josh Adams on 1/11/23 based on concepts described here:
//  https://www.pointfree.co/blog/posts/21-how-to-control-the-world

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
