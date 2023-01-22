//
//  URLExtensionTests.swift
//  KatFancyTests
//
//  Created by Josh Adams on 1/20/23.
//

@testable import KatFancy
import XCTest

extension URL {
  static func couldNotInit(urlString: String) -> String {
    "Could not initialize URL from \(urlString)."
  }
}
