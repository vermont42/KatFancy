//
//  BreedsLoaderTests.swift
//  KatFancyTests
//
//  Created by Josh Adams on 1/20/23.
//

@testable import KatFancy
import XCTest

class BreedsLoaderTests: XCTestCase {
  func testLoadBreeds() async throws {
    let breeds = try await BreedsLoader.loadBreeds()
    let expectedCount = 19
    XCTAssertEqual(expectedCount, breeds.count)
  }
}
