//
//  PersistentCacheMethod.swift
//  KatFancy
//
//  Created by Josh Adams on 1/14/23.
//

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
