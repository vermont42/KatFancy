//
//  BreedTests.swift
//  KatFancyTests
//
//  Created by Josh Adams on 1/20/23.
//

@testable import KatFancy
import XCTest

final class BreedTests: XCTestCase {
  func testModels() async throws {
    let mockLeopard = Breed.mock
    let loader = BreedsLoader()
    let networkLeopard = try await loader.loadBreeds()[0]
    XCTAssertEqual(mockLeopard, networkLeopard)
  }
}
