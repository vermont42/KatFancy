//
//  KatFancyTestApp.swift
//  KatFancy
//
//  Created by Josh Adams on 1/18/23.
//

import SwiftUI

struct KatFancyTestApp: App {
  var body: some Scene {
    WindowGroup {
      VStack {
        Text("Running Unit Tests")
          .font(.largeTitle)
        ProgressView()
      }
    }
  }
}
