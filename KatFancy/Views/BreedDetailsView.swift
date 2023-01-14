//
//  BreedDetailsView.swift
//  KatFancy
//
//  Created by Josh Adams on 1/7/23.
//

import SwiftUI

struct BreedDetailsView: View {
  let breed: Breed
  @Environment(\.openURL) var openURL

  var body: some View {
    VStack {
      CachedAsyncImage(url: breed.photoUrl) { phase in
        if let image = phase.image {
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
        }
      }

      ScrollView {
        Text(breed.description)
      }

      Spacer()

      Text("Photo Credit: \(breed.credit)")

      Spacer()

      HStack {
        Button("Show License") {
          showLicense()
        }

        Spacer()

        Button("View in Wikipedia") {
          viewInWikipedia()
        }
      }
    }
    .navigationTitle(breed.name)
    .padding()
  }

  private func showLicense() {
    openURL(breed.license.url)
  }

  private func viewInWikipedia() {
    openURL(breed.infoUrl)
  }
}

struct BreedDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      BreedDetailsView(breed: [Breed].mock[4])
    }
  }
}
