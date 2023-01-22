//
//  SettingsView.swift
//  KatFancy
//
//  Created by Josh Adams on 1/10/23.
//

import SwiftUI

struct SettingsView: View {
  @ObservedObject var store = SelectionStore(current: Current)
  @State var isTempDirectoryEmpty = FileManager.isTempDirectoryEmpty()

  var body: some View {
    ScrollView(.vertical) {
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
        Text("URLSession Type")
          .font(.title)

        Picker("", selection: $store.sessionType) {
          ForEach(SessionType.allCases, id: \.self) { sessionType in
            Text(sessionType.displayName).tag(sessionType)
          }
        }
        .segmentedPicker()

        Text("This setting controls which URLSession to use for JSON retrieval and image fetching: shared or stubSession.")
          .padding()
      }

      Group {
        Text("Persistent Cache Method")
          .font(.title)

        Picker("", selection: $store.persistentCacheMethod) {
          ForEach(PersistentCacheMethod.allCases, id: \.self) { persistentCacheMethod in
            Text(persistentCacheMethod.displayName).tag(persistentCacheMethod)
          }
        }
        .segmentedPicker()

        Text("This setting controls whether to use the filesystem to cache images between launches of the app. When activated, this cache makes image loading ridiculously fast.")
          .padding()
      }

      Group {
        if !isTempDirectoryEmpty {
          Text("Cache Directory")
            .font(.title)

          Spacer()

          Button("Clear") {
            FileManager.clearTempDirectory()
            isTempDirectoryEmpty = true
          }
          .destructiveButton()

          Text("Tap this button to clear the contents of the temporary directory, which acts as a persistent image cache.")
            .padding()
        }
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
      isTempDirectoryEmpty = FileManager.isTempDirectoryEmpty()
      store.current = Current
      store.breedsURL = Current.settings.breedsURL
      store.sessionType = Current.settings.sessionType
      store.persistentCacheMethod = Current.settings.persistentCacheMethod
      store.sortOrder = Current.settings.sortOrder
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
      .environmentObject(Current)
  }
}
