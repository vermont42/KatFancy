//
//  WorldTests.swift
//  CatFancyTests
//
//  Created by Josh Adams on 6/1/21.
//

@testable import KatFancy
import XCTest

class WorldTests: XCTestCase {
  func testDeviceWorld() {
    let world = World.device
    XCTAssert(world.settings.getterSetter is UserDefaultsGetterSetter)
    XCTAssertEqual(world.settings.sessionType.session, URLSession.shared)
    XCTAssert(world.soundPlayer is RealSoundPlayer)
  }

  func testSimulatorWorld() {
    let world = World.simulator
    XCTAssert(world.settings.getterSetter is UserDefaultsGetterSetter)
    XCTAssertEqual(world.settings.sessionType.session, URLSession.shared)
    XCTAssert(world.soundPlayer is RealSoundPlayer)
  }

  func testUnitTestWorld() {
    let world = World.unitTest
    XCTAssert(world.settings.getterSetter is DictionaryGetterSetter)
    XCTAssertNotEqual(URLSession.shared, world.settings.sessionType.session)
    let expectedProtocolClassesCount = 1
    XCTAssertEqual(expectedProtocolClassesCount, world.settings.sessionType.session.configuration.protocolClasses?.count)
    XCTAssert(world.soundPlayer is TestSoundPlayer)
  }
}
