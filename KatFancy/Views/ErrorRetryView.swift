//
//  ErrorRetryView.swift
//  KatFancy
//
//  Created by Josh Adams on 1/11/23.
//

import SwiftUI

struct ErrorRetryView: View {
  let message: String
  let viewModel: BrowseBreedsViewModel

  var body: some View {
    VStack {
      Text(message)
        .padding()

      Spacer()
        .frame(height: Layout.defaultSpacing)

      Button("Retry") {
        Task {
          await viewModel.loadBreeds()
        }
      }
    }
  }
}

struct ErrorRetryView_Previews: PreviewProvider {
    static var previews: some View {
      ErrorRetryView(message: "This is a test error message.", viewModel: BrowseBreedsViewModel())
    }
}
