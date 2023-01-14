//
//  World.swift
//  KatFancy
//
//  Created by Josh Adams on 1/11/23 based on concepts described here:
//  https://www.pointfree.co/blog/posts/21-how-to-control-the-world

import SwiftUI

var Current = World.chooseWorld()

class World: ObservableObject {
  @Published var settings: Settings
  @Published var session: URLSession
  @Published var soundPlayer: SoundPlayer
  @Published var getterSetter: GetterSetter

  init(settings: Settings, session: URLSession, soundPlayer: SoundPlayer, getterSetter: GetterSetter) {
    self.settings = settings
    self.session = session
    self.soundPlayer = soundPlayer
    self.getterSetter = getterSetter
  }

  static func chooseWorld() -> World {
#if targetEnvironment(simulator)
    let isRunningUnitTests = NSClassFromString("XCTest") != nil
    if isRunningUnitTests {
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
      settings: Settings(getterSetter: UserDefaultsGetterSetter()),
      session: URLSession.shared,
      soundPlayer: RealSoundPlayer(),
      getterSetter: getterSetter
    )
  }()

  static let simulator: World = {
    let getterSetter = UserDefaultsGetterSetter()
    return World(
      settings: Settings(getterSetter: getterSetter),
      session: URLSession.shared,
      soundPlayer: RealSoundPlayer(),
      getterSetter: getterSetter
    )
  }()

  static let unitTest: World = {
    let getterSetter = DictionaryGetterSetter()
    return World(
      settings: Settings(getterSetter: getterSetter),
      session: URLSession.stubSession,
      soundPlayer: TestSoundPlayer(),
      getterSetter: getterSetter
    )
  }()
}
