//
//  BreedTests.swift
//  KatFancyTests
//
//  Created by Josh Adams on 1/20/23.
//

@testable import KatFancy
import XCTest

final class BreedTests: XCTestCase {
  func testInitsEqualityAndHasher() async throws {
    let mockLeopard = Breed.mock
    let networkLeopard = try await BreedsLoader.loadBreeds()[0]

    XCTAssertEqual(mockLeopard, networkLeopard)

    var set = Set<Breed>()
    set.insert(mockLeopard)
    XCTAssert(set.contains(networkLeopard))
  }
}
