//
//  FileManagerExtensions.swift
//  KatFancy
//
//  Created by Josh Adams on 1/17/23.
//

import Foundation

extension FileManager {
  static func clearTempDirectory(fileManager: FileManager = .default) {
    do {
      let tmpDirURL = fileManager.temporaryDirectory
      let tmpDirectory = try fileManager.contentsOfDirectory(atPath: tmpDirURL.path)
      try tmpDirectory.forEach { file in
        let fileUrl = tmpDirURL.appendingPathComponent(file)
        try fileManager.removeItem(atPath: fileUrl.path)
      }
    } catch {}
  }

  static func isTempDirectoryEmpty(fileManager: FileManager = .default) -> Bool {
    do {
      let tmpDirURL = fileManager.temporaryDirectory
      let tmpDirectory = try fileManager.contentsOfDirectory(atPath: tmpDirURL.path)
      return tmpDirectory.isEmpty
    } catch {
      return true
    }
  }
}
