//
//  GetterSetter.swift
//  KatFancy
//
//  Created by Josh Adams on 1/13/19.
//

protocol GetterSetter {
  func get(key: String) -> String?
  func set(key: String, value: String)
}
