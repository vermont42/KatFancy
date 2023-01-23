//
//  SettingsViewModelTests.swift
//  KatFancyTests
//
//  Created by Josh Adams on 1/23/23.
//

@testable import KatFancy
import XCTest

final class SettingsViewModelTests: XCTestCase {
  func testConfigureAndClear() async {
    let vm = await SettingsViewModel()
    FileManagerExtensionsTests.writeFileToFilesystem()
    var isTempDirectoryEmpty = await vm.getIsTempDirectoryEmpty()
    XCTAssert(isTempDirectoryEmpty)
    await vm.configure()
    isTempDirectoryEmpty = await vm.getIsTempDirectoryEmpty()
    XCTAssertFalse(isTempDirectoryEmpty)
    await vm.clearTempDirectory()
    isTempDirectoryEmpty = await vm.getIsTempDirectoryEmpty()
    XCTAssert(isTempDirectoryEmpty)
  }
}
