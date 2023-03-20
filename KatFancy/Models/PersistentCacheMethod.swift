// Created by Josh Adams, who holds the copyright and reserves all rights, on 1/6/23.

enum PersistentCacheMethod: String, CaseIterable {
  case filesystem
  case none

  var displayName: String {
    switch self {
    case .filesystem:
      return "Filesystem"
    case .none:
      return "None"
    }
  }
}
