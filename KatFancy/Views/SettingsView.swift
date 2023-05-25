// Created by Josh Adams, who holds the copyright and reserves all rights, on 1/6/23.

import SwiftUI

struct SettingsView: View {
  @StateObject var viewModel = SettingsViewModel()

  var body: some View {
    ScrollView(.vertical) {
      Text("Settings")
        .font(.largeTitle)

      Spacer()
        .frame(height: Layout.tripleDefaultSpacing)

      Group {
        Text("Breeds URL")
          .font(.title)

        Picker("", selection: $viewModel.store.breedsURL) {
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

        Picker("", selection: $viewModel.store.sessionType) {
          ForEach(SessionType.allCases, id: \.self) { sessionType in
            Text(sessionType.displayName).tag(sessionType)
          }
        }
        .segmentedPicker()

        Text("This setting controls which URLSession to use for JSON retrieval and image fetching: shared or stubSession.")
          .padding()
      }

      Group {
        Text("Sort Order")
          .font(.title)

        Picker("", selection: $viewModel.store.sortOrder) {
          ForEach(SortOrder.allCases, id: \.self) { sortOrder in
            Text(sortOrder.displayName).tag(sortOrder)
          }
        }
        .segmentedPicker()

        Text("This setting controls the sort order of breeds on FancyKat's breed-browsing screen.")
          .padding()
      }

      Group {
        Text("Persistent Cache Method")
          .font(.title)

        Picker("", selection: $viewModel.store.persistentCacheMethod) {
          ForEach(PersistentCacheMethod.allCases, id: \.self) { persistentCacheMethod in
            Text(persistentCacheMethod.displayName).tag(persistentCacheMethod)
          }
        }
        .segmentedPicker()

        Text("This setting controls whether to use the filesystem to cache images between launches of the app. When activated, this cache makes image loading ridiculously fast.")
          .padding()
      }

      Group {
        if !viewModel.isTempDirectoryEmpty {
          Text("Cache Directory")
            .font(.title)

          Spacer()

          Button("Clear") {
            viewModel.clearTempDirectory()
          }
          .destructiveButton()

          Text("Tap this button to clear the contents of the temporary directory, which acts as a persistent image cache.")
            .padding()
        }
      }

      Spacer()
    }
    .onAppear {
      viewModel.configure()
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
      .environmentObject(Current)
  }
}
