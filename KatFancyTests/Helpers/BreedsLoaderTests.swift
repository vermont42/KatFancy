// Created by Josh Adams, who holds the copyright and reserves all rights, on 1/6/23.

@testable import KatFancy
import XCTest

class BreedsLoaderTests: XCTestCase {
  func testLoadBreeds() async throws {
    let breeds = try await BreedsLoader.loadBreeds()
    let expectedCount = 19
    XCTAssertEqual(expectedCount, breeds.count)
  }
}
