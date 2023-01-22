//
//  KatFancyApp.swift
//  KatFancy
//
//  Created by Josh Adams on 1/6/23.
//

import SwiftUI

struct KatFancyApp: App {
  init() {
    Task {
      await Current.imageLoader.configure(session: Current.settings.sessionType.session, persistentCacheMethod: Current.settings.persistentCacheMethod)
    }
  }

  var body: some Scene {
    WindowGroup {
      MainTabView()
        .environmentObject(Current)
    }
  }
}
