//
//  CachedAsyncImage.swift
//  KatFancy
//
//  Created by Josh Adams on 1/10/23.
//

import SwiftUI

// credit: https://www.youtube.com/watch?v=KhGyiOk3Yzk

struct CachedAsyncImage<Content>: View where Content: View {
  private let url: URL
  private let content: (AsyncImagePhase) -> Content

  init(url: URL, @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
    self.url = url
    self.content = content
  }

  var body: some View {
    if let cachedImage = ImageCache[url] {
      content(.success(cachedImage))
    } else {
      AsyncImage(url: url) { phase in
        cacheAndRender(phase: phase)
      }
    }
  }

  func cacheAndRender(phase: AsyncImagePhase) -> some View {
    if case .success (let image) = phase {
      ImageCache[url] = image
    }
    return content(phase)
  }
}

private class ImageCache {
  static private var cache: [URL: Image] = [:]

  static subscript(url: URL) -> Image? {
    get {
      ImageCache.cache[url]
    }

    set {
      ImageCache.cache[url] = newValue
    }
  }
}

struct CachedImageView_Previews: PreviewProvider {
  private static let goodUrl = URL(string: "https://raceconditionsoftware.s3.us-west-1.amazonaws.com/CatFancy/img/Abyssinian.jpg")!
  private static let badUrl = URL(string: "https://racecondition.software")!

  static var previews: some View {
    Group {
      CachedAsyncImage(url: goodUrl) { phase in
        if let image = phase.image {
          VStack {
            Text("This load should succeed.")
              .font(.headline)

            image
              .resizable()
              .aspectRatio(contentMode: .fit)
              .padding()
          }
        }
      }
      .previewDisplayName("Happy Path")

      CachedAsyncImage(url: badUrl) { phase in
        if let error = phase.error {
          VStack {
            Text("This load should fail because of the bad URL.")
              .font(.headline)
            Text(error.localizedDescription)
              .padding()
          }
        }
      }
      .previewDisplayName("Error")
    }
  }
}
