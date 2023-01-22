//
//  BreedsLoaderTests.swift
//  KatFancyTests
//
//  Created by Josh Adams on 1/20/23.
//

@testable import KatFancy
import XCTest

class BreedsRequesterTests: XCTestCase {
  func testLoadBreeds() async throws {
    let loader = BreedsLoader()
    let breeds = try await loader.loadBreeds()
    let expectedCount = 19
    XCTAssertEqual(expectedCount, breeds.count)
  }
}
