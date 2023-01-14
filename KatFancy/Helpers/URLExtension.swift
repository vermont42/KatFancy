//
//  URLExtension.swift
//  KatFancy
//
//  Created by Josh Adams on 1/6/23.
//

import Foundation

extension URL {
  static func couldNotInit(urlString: String) -> String {
    "Could not initialize URL from \(urlString)."
  }
}
