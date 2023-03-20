// Created by Josh Adams, who holds the copyright and reserves all rights, on 1/6/23.

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
