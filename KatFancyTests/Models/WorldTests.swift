// Created by Josh Adams, who holds the copyright and reserves all rights, on 1/6/23.

@testable import KatFancy
import XCTest

class WorldTests: XCTestCase {
  func testDeviceWorld() {
    let world = World.device
    XCTAssert(world.settings.getterSetter is UserDefaultsGetterSetter)
    XCTAssert(world.soundPlayer is RealSoundPlayer)
  }

  func testSimulatorWorld() {
    let world = World.simulator
    XCTAssert(world.settings.getterSetter is UserDefaultsGetterSetter)
    XCTAssert(world.soundPlayer is RealSoundPlayer)
  }

  func testUnitTestWorld() {
    let world = World.unitTest
    XCTAssert(world.settings.getterSetter is DictionaryGetterSetter)
    XCTAssert(world.soundPlayer is TestSoundPlayer)
  }
}
