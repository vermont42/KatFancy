//
//  ImageLoaderTests.swift
//  KatFancyTests
//
//  Created by Josh Adams on 1/20/23.
//

@testable import KatFancy
import XCTest

final class ImageLoaderTests: XCTestCase {
  func testFetch() async throws {
    guard let goodUrl = URL(string: MockData.photoUrlPrefix + MockData.catNames[0] + MockData.mockPhotoExtension) else {
      XCTFail("Unable to initialize good photo URL.")
      return
    }

    let imageLoader = ImageLoader()
    await imageLoader.setPersistentCacheMethod(.none)
    var goodImage = await imageLoader.fetch(goodUrl)
    XCTAssertNotNil(goodImage)
    goodImage = await imageLoader.fetch(goodUrl)
    XCTAssertNotNil(goodImage)

    guard let expectedErrorImage = UIImage(named: "error") else {
      XCTFail("Unable to initialize error UIImage.")
      return
    }

    guard let badUrl = URL(string: "https://racecondition.software") else {
      XCTFail("Unable to initialize bad photo URL.")
      return
    }

    let errorImage = await imageLoader.fetch(badUrl)
    XCTAssertNotNil(errorImage)

    XCTAssertEqual(errorImage.pngData(), expectedErrorImage.pngData())
  }

  func testConfigure() async {
    let imageLoader = ImageLoader()

    await imageLoader.configure(session: .shared, persistentCacheMethod: .filesystem)
    var session = await imageLoader.getSession()
    var persistentCacheMethod = await imageLoader.getPersistentCacheMethod()
    XCTAssertEqual(session, .shared)
    XCTAssertEqual(persistentCacheMethod, .filesystem)

    let stubSession = URLSession.stubSession
    await imageLoader.configure(session: stubSession, persistentCacheMethod: .none)
    session = await imageLoader.getSession()
    persistentCacheMethod = await imageLoader.getPersistentCacheMethod()
    XCTAssertEqual(session, stubSession)
    XCTAssertEqual(persistentCacheMethod, .none)
  }

  func testSetSession() async {
    Current.settings.sessionType = .shared
    XCTAssertEqual(Current.settings.sessionType, .shared)
    Current.settings.sessionType = .stub
    XCTAssertEqual(Current.settings.sessionType, .stub)
  }

  func testSetPersistentCacheMethod() async {
    Current.settings.persistentCacheMethod = .none
    XCTAssertEqual(Current.settings.persistentCacheMethod, .none)
    Current.settings.persistentCacheMethod = .filesystem
    XCTAssertEqual(Current.settings.persistentCacheMethod, .filesystem)
  }

  func testPersistAndGetImage() async {
    FileManager.clearTempDirectory()
    XCTAssert(FileManager.isTempDirectoryEmpty())
    guard let imageToSave = UIImage(named: "Tonkinese") else {
      XCTFail("Failed to initialize Tonkinese image.")
      return
    }
    let imageLoader = ImageLoader()
    let fullPathUrl = FileManager.default.temporaryDirectory.appendingPathComponent("Tonkinese.jpg")
    await imageLoader.persistImage(imageToSave, for: fullPathUrl)
    XCTAssertFalse(FileManager.isTempDirectoryEmpty())
    guard let retrievedImage = await imageLoader.imageFromPersistentCache(for: fullPathUrl) else {
      XCTFail("Failed to retrieve image from filesystem.")
      return
    }
    XCTAssertNotNil(retrievedImage)
    FileManager.clearTempDirectory()
  }
}
