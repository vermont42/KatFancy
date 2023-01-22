//
//  ImageLoader.swift
//  KatFancy
//
//  Created by Josh Adams on 1/14/23.
//

import UIKit

actor ImageLoader {
  var session = URLSession.shared
  var persistentCacheMethod = PersistentCacheMethod.filesystem
  private var loaderStatuses: [URL: LoaderStatus] = [:]

  private enum LoaderStatus {
    case inProgress(Task<UIImage, Error>)
    case fetched(UIImage)
  }

  func fetch(_ url: URL) async -> UIImage {
    let errorImage = UIImage(named: "error")!

    if let status = loaderStatuses[url] {
      switch status {
      case .fetched(let image):
        return image
      case .inProgress(let task):
        return (try? await task.value) ?? errorImage
      }
    }

    if let image = imageFromPersistentCache(for: url) {
      loaderStatuses[url] = .fetched(image)
      return image
    }

    let task: Task<UIImage, Error> = Task {
      let image: UIImage

      do {
        let (imageData, _) = try await session.data(from: url)
        let imageFromNetwork = UIImage(data: imageData)
        imageFromNetwork.map { persistImage($0, for: url) }
        image = imageFromNetwork ?? errorImage
      } catch {
        image = errorImage
      }

      return image
    }

    loaderStatuses[url] = .inProgress(task)

    do {
      let image = try await task.value
      loaderStatuses[url] = .fetched(image)
      return image
    } catch {
      loaderStatuses[url] = .fetched(errorImage)
      return errorImage
    }
  }

  func configure(session: URLSession, persistentCacheMethod: PersistentCacheMethod) async {
    self.session = session
    self.persistentCacheMethod = persistentCacheMethod
  }

  func setSession(_ session: URLSession) async {
    self.session = session
  }

  func setPersistentCacheMethod(_ persistentCacheMethod: PersistentCacheMethod) async {
    self.persistentCacheMethod = persistentCacheMethod
  }

  func persistImage(_ image: UIImage, for url: URL) {
    switch persistentCacheMethod {
    case .filesystem:
      guard
        let data = image.jpegData(compressionQuality: 0.8),
        let persistentCacheKey = persistentCacheKey(for: url)
      else {
        return
      }
      try? data.write(to: persistentCacheKey)
    case .none:
      return
    }
  }

  func imageFromPersistentCache(for url: URL) -> UIImage? {
    guard let persistentCacheKey = persistentCacheKey(for: url) else {
      return nil
    }

    switch persistentCacheMethod {
    case .filesystem:
      let data = try? Data(contentsOf: persistentCacheKey)
      if let data {
        return UIImage(data: data)
      } else {
        return nil
      }
    case .none:
      return nil
    }
  }

  func getSession() -> URLSession {
    session
  }

  func getPersistentCacheMethod() -> PersistentCacheMethod {
    persistentCacheMethod
  }

  private func persistentCacheKey(for url: URL) -> URL? {
    switch persistentCacheMethod {
    case .filesystem:
      guard let fileName = url.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)?.replacingOccurrences(of: "/", with: "*") else {
        return nil
      }
      return FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
    case .none:
      return nil
    }
  }
}
