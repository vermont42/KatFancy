//
//  TestSoundPlayerTests.swift
//  KatFancyTests
//
//  Created by Josh Adams on 1/20/23.
//

@testable import KatFancy
import XCTest

class TestSoundPlayerTests: XCTestCase {
  func testSuccess() {
    var didSucceed = false
    let soundPlayer = TestSoundPlayer()
    soundPlayer.play(.sadTrombone, didSucceed: { result in
      didSucceed = result
      XCTAssert(didSucceed)
    })
  }

  func testFailure() {
    var didSucceed = true
    let soundPlayer = TestSoundPlayer(alwaysFail: true)
    soundPlayer.play(.missingSound, didSucceed: { result in
      didSucceed = result
      XCTAssertFalse(didSucceed)
    })
  }
}
