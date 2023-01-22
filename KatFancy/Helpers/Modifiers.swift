//
//  Modifiers.swift
//  KatFancy
//
//  Created by Josh Adams on 1/11/23.
//

import SwiftUI

extension View {
  func segmentedPicker() -> some View {
    modifier(SegmentedPicker())
  }

  func destructiveButton() -> some View {
    modifier(DestructiveButton())
  }
}

private struct SegmentedPicker: ViewModifier {
  func body(content: Content) -> some View {
    content
      .pickerStyle(SegmentedPickerStyle())
      .padding(.horizontal, Layout.doubleDefaultSpacing)
  }
}

private struct DestructiveButton: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundColor(.red)
      .buttonStyle(.bordered)
      .tint(.red)
  }
}
