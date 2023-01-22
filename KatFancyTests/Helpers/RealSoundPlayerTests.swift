//
//  RealSoundPlayerTests.swift
//  KatFancyTests
//
//  Created by Josh Adams on 1/20/23.
//

@testable import KatFancy
import XCTest

class RealSoundPlayerTests: XCTestCase {
  func testSuccess() {
    let soundPlayer = RealSoundPlayer()
    soundPlayer.play(.sadTrombone) { didSucceed in
      XCTAssert(didSucceed)
    }
  }

  func testFailure() {
    let soundPlayer = RealSoundPlayer()
    soundPlayer.play(.missingSound) { didSucceed in
      XCTAssertFalse(didSucceed)
    }
  }
}
