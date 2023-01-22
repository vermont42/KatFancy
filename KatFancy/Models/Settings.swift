//
//  Settings.swift
//  KatFancy
//
//  Created by Josh Adams on 9/25/22.
//

import Foundation

class Settings {
  let getterSetter: GetterSetter

  var breedsURL: BreedsURL {
    didSet {
      if breedsURL != oldValue {
        getterSetter.set(key: Settings.breedsURLKey, value: breedsURL.rawValue)
      }
    }
  }
  static let breedsURLKey = "breedsURL"
  static let breedsURLDefault: BreedsURL = .withMore

  var sortOrder: SortOrder {
    didSet {
      if sortOrder != oldValue {
        getterSetter.set(key: Settings.sortOrderKey, value: sortOrder.rawValue)
      }
    }
  }
  static let sortOrderKey = "sortOrder"
  static let sortOrderDefault: SortOrder = .name

  var sessionType: SessionType {
    didSet {
      if sessionType != oldValue {
        getterSetter.set(key: Settings.sessionTypeKey, value: sessionType.rawValue)
        Task {
          await Current.imageLoader.setSession(sessionType.session)
        }
      }
    }
  }
  static let sessionTypeKey = "sessionType"
  static let sessionTypeDefault: SessionType = .shared

  var persistentCacheMethod: PersistentCacheMethod {
    didSet {
      if persistentCacheMethod != oldValue {
        getterSetter.set(key: Settings.persistentCacheMethodKey, value: persistentCacheMethod.rawValue)
        Task {
          await Current.imageLoader.setPersistentCacheMethod(persistentCacheMethod)
        }
      }
    }
  }
  static let persistentCacheMethodKey = "persistentCacheMethod"
  static let persistentCacheMethodDefault: PersistentCacheMethod = .none

  init(getterSetter: GetterSetter) {
    self.getterSetter = getterSetter

    if let breedsURLString = getterSetter.get(key: Settings.breedsURLKey) {
      breedsURL = BreedsURL(rawValue: breedsURLString) ?? Settings.breedsURLDefault
    } else {
      breedsURL = Settings.breedsURLDefault
      getterSetter.set(key: Settings.breedsURLKey, value: breedsURL.rawValue)
    }

    if let sortOrderString = getterSetter.get(key: Settings.sortOrderKey) {
      sortOrder = SortOrder(rawValue: sortOrderString) ?? Settings.sortOrderDefault
    } else {
      sortOrder = Settings.sortOrderDefault
      getterSetter.set(key: Settings.sortOrderKey, value: sortOrder.rawValue)
    }

    if let sessionTypeString = getterSetter.get(key: Settings.sessionTypeKey) {
      sessionType = SessionType(rawValue: sessionTypeString) ?? Settings.sessionTypeDefault
    } else {
      sessionType = Settings.sessionTypeDefault
      getterSetter.set(key: Settings.sessionTypeKey, value: sessionType.rawValue)
    }

    if let persistentCacheMethodString = getterSetter.get(key: Settings.persistentCacheMethodKey) {
      persistentCacheMethod = PersistentCacheMethod(rawValue: persistentCacheMethodString) ?? Settings.persistentCacheMethodDefault
    } else {
      persistentCacheMethod = Settings.persistentCacheMethodDefault
      getterSetter.set(key: Settings.persistentCacheMethodKey, value: persistentCacheMethod.rawValue)
    }
  }
}
