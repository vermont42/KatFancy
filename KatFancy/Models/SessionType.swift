//
//  SessionType.swift
//  KatFancy
//
//  Created by Josh Adams on 1/14/23.
//

import Foundation

enum SessionType: String, CaseIterable {
  case shared
  case stub

  var session: URLSession {
    switch self {
    case .shared:
      return URLSession.shared
    case .stub:
      return URLSession.stubSession
    }
  }

  var displayName: String {
    switch self {
    case .shared:
      return "Shared"
    case .stub:
      return "Stub"
    }
  }
}
