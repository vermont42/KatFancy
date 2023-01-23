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
  @Published var getterSetter: GetterSetter
  @Published var imageLoader: ImageLoader

  init(settings: Settings, soundPlayer: SoundPlayer, getterSetter: GetterSetter, imageLoader: ImageLoader) {
    self.settings = settings
    self.soundPlayer = soundPlayer
    self.getterSetter = getterSetter
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
    let getterSetter = UserDefaultsGetterSetter()
    return World(
      settings: Settings(getterSetter: getterSetter),
      soundPlayer: RealSoundPlayer(),
      getterSetter: getterSetter,
      imageLoader: ImageLoader()
    )
  }()

  static let simulator: World = {
    let getterSetter = UserDefaultsGetterSetter()
    return World(
      settings: Settings(getterSetter: getterSetter),
      soundPlayer: RealSoundPlayer(),
      getterSetter: getterSetter,
      imageLoader: ImageLoader()
    )
  }()

  static let unitTest: World = {
    let getterSetter = DictionaryGetterSetter()
    return World(
      settings: Settings(getterSetter: getterSetter),
      soundPlayer: TestSoundPlayer(),
      getterSetter: getterSetter,
      imageLoader: ImageLoader()
    )
  }()
}
