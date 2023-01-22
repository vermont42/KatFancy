//
//  FileManagerExtensionsTests.swift
//  KatFancyTests
//
//  Created by Josh Adams on 1/20/23.
//

@testable import KatFancy
import XCTest

final class FileManagerExtensionsTests: XCTestCase {
  override func setUpWithError() throws {
    FileManager.clearTempDirectory()
  }

  override func tearDownWithError() throws {
    FileManager.clearTempDirectory()
  }

  func testClearTemporaryDirectory() {
    XCTAssert(FileManager.isTempDirectoryEmpty())
    writeFileToFilesystem()
    XCTAssertFalse(FileManager.isTempDirectoryEmpty())
    FileManager.clearTempDirectory()
    XCTAssert(FileManager.isTempDirectoryEmpty())
  }

  func testIsTemporaryDirectoryEmpty() {
    XCTAssert(FileManager.isTempDirectoryEmpty())
    writeFileToFilesystem()
    XCTAssertFalse(FileManager.isTempDirectoryEmpty())
  }

  private func writeFileToFilesystem() {
    let contents = "🥥"
    let filename = "\(contents).txt"
    let fullPath = FileManager.default.temporaryDirectory.appendingPathComponent(filename)

    do {
      try contents.write(to: fullPath, atomically: true, encoding: String.Encoding.utf8)
    } catch {
      XCTFail("Failed to write \(fullPath) to filesystem.")
    }
  }
}
