//
//  URLProtocolStub.swift
//  KatFancy
//
//  Created by Josh Adams on 9/16/22.
//

import Foundation

class URLProtocolStub: URLProtocol {
  static var urlDataDict: [URL: Data] = [:]

  override class func canInit(with request: URLRequest) -> Bool {
    true
  }

  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    request
  }

  override func startLoading() {
    if
      let url = request.url,
      let data = URLProtocolStub.urlDataDict[url]
    {
      client?.urlProtocol(self, didReceive: URLResponse(), cacheStoragePolicy: .notAllowed)
      client?.urlProtocol(self, didLoad: data)
    } else {
      client?.urlProtocol(self, didFailWithError: LoadingError.loadFailed)
    }
    client?.urlProtocolDidFinishLoading(self)
  }

  override func stopLoading() {}

  enum LoadingError: Error {
    case loadFailed
  }
}
