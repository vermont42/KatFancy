// Created by Josh Adams, who holds the copyright and reserves all rights, on 1/6/23.

import Foundation

final class SelectionStore: ObservableObject {
  var current: World

  init(current: World) {
    self.current = current
    breedsURL = current.settings.breedsURL
    sessionType = current.settings.sessionType
    persistentCacheMethod = current.settings.persistentCacheMethod
    sortOrder = current.settings.sortOrder
  }

  @Published var breedsURL: BreedsURL {
    didSet {
      current.settings.breedsURL = breedsURL
    }
  }

  @Published var sessionType: SessionType {
    didSet {
      current.settings.sessionType = sessionType
      Task {
        await current.imageLoader.configure(session: sessionType.session, persistentCacheMethod: current.settings.persistentCacheMethod)
      }
    }
  }

  @Published var persistentCacheMethod: PersistentCacheMethod {
    didSet {
      current.settings.persistentCacheMethod = persistentCacheMethod
      Task {
        await current.imageLoader.configure(session: current.settings.sessionType.session, persistentCacheMethod: persistentCacheMethod)
      }
    }
  }

  @Published var sortOrder: SortOrder {
    didSet {
      current.settings.sortOrder = sortOrder
    }
  }
}
