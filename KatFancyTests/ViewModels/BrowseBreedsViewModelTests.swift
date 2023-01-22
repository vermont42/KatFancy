//
//  BrowseBreedsViewModelTests.swift
//  KatFancyTests
//
//  Created by Josh Adams on 1/20/23.
//

@testable import KatFancy
import XCTest

final class BrowseBreedsViewModelTests: XCTestCase {
  func testLoadBreeds() async {
    let vm = await BrowseBreedsViewModel()

    let loadingState = await vm.getState()
    XCTAssertEqual(loadingState, .loading)

//    await vm.loadBreeds(mockedState: .loaded(breeds: [Breed].mock))
//    let mockedLoadedState = await vm.getState()
//    switch mockedLoadedState {
//    case .loading, .error:
//      XCTFail("Unexpected state: \(mockedLoadedState)")
//      return
//    case .loaded(let breeds):
//      XCTAssertEqual(breeds.count, 5)
//    }

    await vm.loadBreeds()
    let actualLoadedState = await vm.getState()
    switch actualLoadedState {
    case .loading, .error:
      XCTFail("Unexpected state: \(actualLoadedState)")
      return
    case .loaded(let breeds):
      XCTAssertEqual(breeds.count, 19)
    }

    Current.settings.breedsURL = .malformed
    await vm.loadBreeds()
    let errorState = await vm.getState()
    switch errorState {
    case .loading, .loaded:
      XCTFail("Unexpected state: \(errorState)")
      return
    case .error:
      break
    }

    Current.settings.breedsURL = .empty
    await vm.loadBreeds()
    let emptyLoadedState = await vm.getState()
    switch emptyLoadedState {
    case .loading, .error:
      XCTFail("Unexpected state: \(emptyLoadedState)")
      return
    case .loaded(let breeds):
      XCTAssertEqual(breeds.count, 0)
    }

    Current.settings.breedsURL = .withMore
  }
}
