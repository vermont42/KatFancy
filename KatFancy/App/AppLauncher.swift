//
//  AppLauncher.swift
//  KatFancy
//
//  Created by Josh Adams on 1/18/23.
//  https://mokacoding.com/blog/prevent-swiftui-app-loading-in-unit-tests/

import SwiftUI

@main
struct AppLauncher {
  static func main() throws {
    if NSClassFromString("XCTestCase") == nil {
      KatFancyApp.main()
    } else {
      KatFancyTestApp.main()
    }
  }
}
