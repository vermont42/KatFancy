//
//  SettingsViewModel.swift
//  KatFancy
//
//  Created by Josh Adams on 1/22/23.
//

import Foundation

@MainActor
class SettingsViewModel: ObservableObject {
  @Published var store = SelectionStore(current: Current)
  @Published var isTempDirectoryEmpty = true

  func configure() {
    isTempDirectoryEmpty = FileManager.isTempDirectoryEmpty()
    store.current = Current
    store.breedsURL = Current.settings.breedsURL
    store.sessionType = Current.settings.sessionType
    store.persistentCacheMethod = Current.settings.persistentCacheMethod
    store.sortOrder = Current.settings.sortOrder
  }

  func clearTempDirectory() {
    FileManager.clearTempDirectory()
    isTempDirectoryEmpty = true
  }

  func getIsTempDirectoryEmpty() async -> Bool {
    isTempDirectoryEmpty
  }
}
