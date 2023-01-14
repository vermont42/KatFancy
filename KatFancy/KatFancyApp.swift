//
//  KatFancyApp.swift
//  KatFancy
//
//  Created by Josh Adams on 1/6/23.
//

import SwiftUI

@main
struct KatFancyApp: App {
    var body: some Scene {
        WindowGroup {
          MainTabView()
            .environmentObject(Current)
        }
    }
}
