//
//  BreedsURLTests.swift
//  CatFancyTests
//
//  Created by Josh Adams on 6/1/21.
//

@testable import KatFancy
import XCTest

class BreedsURLTests: XCTestCase {
  func testURL() {
    guard
      let expectedStandardURL = URL(string: "https://raceconditionsoftware.s3.us-west-1.amazonaws.com/CatFancy/breeds.json"),
      let expectedEmptyURL = URL(string: "https://raceconditionsoftware.s3.us-west-1.amazonaws.com/CatFancy/breeds_empty.json"),
      let expectedMalformedURL = URL(string: "https://raceconditionsoftware.s3.us-west-1.amazonaws.com/CatFancy/breeds_malformed.json"),
      let expectedWithMoreURL = URL(string: "https://raceconditionsoftware.s3.us-west-1.amazonaws.com/CatFancy/breeds_with_more.json")
    else {
      XCTFail("Failed to initialize expected URL.")
      return
    }

    XCTAssertEqual(expectedStandardURL, BreedsURL.standard.url)
    XCTAssertEqual(expectedEmptyURL, BreedsURL.empty.url)
    XCTAssertEqual(expectedMalformedURL, BreedsURL.malformed.url)
    XCTAssertEqual(expectedWithMoreURL, BreedsURL.withMore.url)
  }

  func testDisplayName() {
    let expectedStandardDisplayName = "Production"
    let expectedEmptyDisplayName = "Empty"
    let expectedMalformedDisplayName = "Malformed"
    let expectedWithMoreDisplayName = "With More"

    XCTAssertEqual(expectedStandardDisplayName, BreedsURL.standard.displayName)
    XCTAssertEqual(expectedEmptyDisplayName, BreedsURL.empty.displayName)
    XCTAssertEqual(expectedMalformedDisplayName, BreedsURL.malformed.displayName)
    XCTAssertEqual(expectedWithMoreDisplayName, BreedsURL.withMore.displayName)
  }
}
