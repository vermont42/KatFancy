//
//  SettingsView.swift
//  KatFancy
//
//  Created by Josh Adams on 1/10/23.
//

import SwiftUI

struct SettingsView: View {
  @ObservedObject var store = SelectionStore(current: Current)

  var body: some View {
    VStack {
      Text("Settings")
        .font(.largeTitle)

      Spacer()
        .frame(height: Layout.tripleDefaultSpacing)

      Group {
        Text("Breeds URL")
          .font(.title)

        Picker("", selection: $store.breedsURL) {
          ForEach(BreedsURL.allCases, id: \.self) { breedsURL in
            Text(breedsURL.displayName).tag(breedsURL)
          }
        }
        .segmentedPicker()

        Text("This setting controls the URL of the JSON file that the breeds-browsing screen retrieves. Revisit that screen after changing this setting to initiate another API call.")
          .padding()
      }

      Group {
        Text("Sort Order")
          .font(.title)

        Picker("", selection: $store.sortOrder) {
          ForEach(SortOrder.allCases, id: \.self) { sortOrder in
            Text(sortOrder.displayName).tag(sortOrder)
          }
        }
        .segmentedPicker()

        Text("This setting controls the sort order of breeds on FancyKat's breed-browsing screen.")
          .padding()
      }

      Spacer()
    }
    .onAppear {
      store.current = Current
      store.breedsURL = Current.settings.breedsURL
      store.sortOrder = Current.settings.sortOrder
    }
  }
}

final class SelectionStore: ObservableObject {
  var current: World

  init(current: World) {
    self.current = current
    breedsURL = current.settings.breedsURL
    sortOrder = current.settings.sortOrder
  }

  @Published var breedsURL: BreedsURL {
    didSet {
      current.settings.breedsURL = breedsURL
    }
  }

  @Published var sortOrder: SortOrder {
    didSet {
      current.settings.sortOrder = sortOrder
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
      .environmentObject(Current)
  }
}
