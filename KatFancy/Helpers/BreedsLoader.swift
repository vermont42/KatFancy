//
//  BreedsLoader.swift
//  KatFancy
//
//  Created by Josh Adams on 1/6/23.
//

import Foundation

class BreedsLoader {
  func loadBreeds() async throws -> [Breed] {
    let (data, _) = try await Current.settings.sessionType.session.data(from: Current.settings.breedsURL.url)
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let breeds = try decoder.decode(Breeds.self, from: data)
    return breeds.breeds
  }
}
