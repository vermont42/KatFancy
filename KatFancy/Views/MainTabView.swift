//
//  MainTabView.swift
//  KatFancy
//
//  Created by Josh Adams on 1/10/23.
//

import SwiftUI

struct MainTabView: View {
  var body: some View {
    TabView {
      BrowseBreedsView()
        .tabItem {
          Image(systemName: "pawprint.fill")
          Text("Browse")
        }

      SettingsView()
        .tabItem {
          Image(systemName: "gearshape.2.fill")
          Text("Settings")
        }
    }
  }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
