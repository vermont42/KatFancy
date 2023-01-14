//
//  URLSessionExtension.swift
//  KatFancy
//
//  Created by Josh Adams on 9/16/22.
//

import Foundation

extension URLSession {
  static var didProcessURLs = false

  static var stubSession: URLSession {
    if !didProcessURLs {
      BreedsURL.allCases.forEach {
        if let path = Bundle.main.path(forResource: $0.url.lastPathComponent, ofType: nil) {
          do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            URLProtocolStub.urlDataDict[$0.url] = data
          } catch {
            fatalError("Unable to load mock JSON data for URL \($0.url).")
          }
        }
      }

      didProcessURLs = true
    }

    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [URLProtocolStub.self]
    return URLSession(configuration: config)
  }
}
