//
//  BrowseBreedsView.swift
//  KatFancy
//
//  Created by Josh Adams on 1/6/23.
//

import SwiftUI

// GitHub: https://github.com/vincent-pradeilles/live-building-your-first-swiftui-app

struct BrowseBreedsView: View {
  @StateObject var viewModel = BrowseBreedsViewModel()
  private let mockedState: BrowseBreedsViewModel.State?

  init(mockedState: BrowseBreedsViewModel.State? = nil) {
    self.mockedState = mockedState
  }

  var body: some View {
    NavigationStack {
      Group {
        switch viewModel.state {
        case .loading:
          ProgressView()
        case .error:
          ErrorRetryView(message: "An error occurred during breed fetching.", viewModel: viewModel)
        case .loaded(let breeds):
          if !breeds.isEmpty {
            list(of: breeds, viewModel: viewModel, mockedState: mockedState)
          } else {
            ErrorRetryView(message: "The endpoint returned an empty array of beeds.", viewModel: viewModel)
          }
        }
      }
      .navigationTitle("Cat Breeds")
      .task {
        await viewModel.loadBreeds(mockedState: mockedState)
      }
    }
  }

  @ViewBuilder
  func list(of breeds: [Breed], viewModel: BrowseBreedsViewModel, mockedState: BrowseBreedsViewModel.State? = nil) -> some View {
    if !breeds.isEmpty {
      List(breeds) { breed in
        NavigationLink {
          BreedDetailsView(breed: breed)
        } label: {
          HStack {
            VStack(alignment: .leading) {
              Text(breed.name)
                .font(.headline)
              Text(breed.knownFor)
              Text("Popularity: \(breed.popularity)")
            }

            Spacer()

            CachedAsyncImage(url: breed.photoUrl) { phase in
              if let image = phase.image {
                image
                  .resizable()
                  .aspectRatio(contentMode: .fit)
              } else if phase.error != nil {
                Image(systemName: "exclamationmark.icloud.fill")
                  .resizable()
              } else {
                ProgressView()
                  .scaleEffect(3)
              }
            }
            .frame(width: 124.0)
          }
          .padding()
        }
      }
    } else {
      EmptyView()
    }
  }
}

struct BrowseBreedsView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      BrowseBreedsView(mockedState: .loaded(breeds: [Breed].mock))
        .previewDisplayName("Mocked Data")

      BrowseBreedsView()
        .previewDisplayName("Actual Data")

      BrowseBreedsView(mockedState: .loaded(breeds: []))
        .previewDisplayName("No Data")

      BrowseBreedsView(mockedState: .loading)
        .previewDisplayName("Loading")

      BrowseBreedsView(mockedState: .error)
        .previewDisplayName("Error")
    }
  }
}
