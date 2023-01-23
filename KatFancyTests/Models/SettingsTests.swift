//
//  SettingsTests.swift
//  CatFancyTests
//
//  Created by Josh Adams on 6/1/21.
//

@testable import KatFancy
import XCTest

class SettingsTests: XCTestCase {
  func testBreedsURLSetting() {
    let settings = Settings(getterSetter: DictionaryGetterSetter())
    XCTAssertEqual(Settings.breedsURLDefault, settings.breedsURL)
    XCTAssertEqual(BreedsURL.withMore, settings.breedsURL)
    settings.breedsURL = .withMore
    XCTAssertEqual(Settings.breedsURLDefault, settings.breedsURL)
    XCTAssertEqual(BreedsURL.withMore, settings.breedsURL)
    Current.settings.breedsURL = Settings.breedsURLDefault
  }

  func testSortOrderSetting() {
    let settings = Settings(getterSetter: DictionaryGetterSetter())
    XCTAssertEqual(Settings.sortOrderDefault, settings.sortOrder)
    XCTAssertEqual(SortOrder.name, settings.sortOrder)
    settings.sortOrder = .popularity
    XCTAssertNotEqual(Settings.sortOrderDefault, settings.sortOrder)
    XCTAssertEqual(SortOrder.popularity, settings.sortOrder)
    Current.settings.sortOrder = Settings.sortOrderDefault
  }

  func testSessionTypeSetting() {
    let settings = Settings(getterSetter: DictionaryGetterSetter())
    XCTAssertEqual(Settings.sessionTypeDefault, settings.sessionType)
    XCTAssertEqual(SessionType.shared, settings.sessionType)
    settings.sessionType = .stub
    XCTAssertNotEqual(Settings.sessionTypeDefault, settings.sessionType)
    XCTAssertEqual(SessionType.stub, settings.sessionType)
    Current.settings.sessionType = Settings.sessionTypeDefault
  }

  func testPersistentCacheMethodSetting() {
    let settings = Settings(getterSetter: DictionaryGetterSetter())
    XCTAssertEqual(Settings.persistentCacheMethodDefault, settings.persistentCacheMethod)
    XCTAssertEqual(PersistentCacheMethod.none, settings.persistentCacheMethod)
    settings.persistentCacheMethod = .filesystem
    XCTAssertNotEqual(Settings.persistentCacheMethodDefault, settings.persistentCacheMethod)
    XCTAssertEqual(PersistentCacheMethod.filesystem, settings.persistentCacheMethod)
    Current.settings.persistentCacheMethod = Settings.persistentCacheMethodDefault
  }
}
