//
//  URLExtensionTests.swift
//  KatFancyTests
//
//  Created by Josh Adams on 1/20/23.
//

@testable import KatFancy
import XCTest

class URLExtensionTests: XCTestCase {
  func testCouldNotInit() {
    let 🙀 = "🙀"
    XCTAssertEqual("Could not initialize URL from \(🙀).", URL.couldNotInit(urlString: 🙀))
  }
}
