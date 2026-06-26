//
//  ListingImageCarousel.swift
//  ReGlammed
//
//  Created by Rashmi Priyadarshi on 25/06/26.
//

import SwiftUI

struct ListingImageCarousel: View {

    let imageURLs: [String]

    @State private var selectedIndex = 0

    var body: some View {

        TabView(selection: $selectedIndex) {

            if imageURLs.isEmpty {

                Rectangle()
                    .fill(Color.regBlue)
                    .overlay {

                        Image(systemName: "photo")
                            .font(.system(size: 40))
                            .foregroundColor(.regBrown.opacity(0.5))
                    }
                    .tag(0)

            } else {

                ForEach(imageURLs.indices, id: \.self) { index in

                    if let url = URL(string: imageURLs[index]) {

                        AsyncImage(url: url) { image in

                            image
                                .resizable()
                                .scaledToFill()

                        } placeholder: {

                            Rectangle()
                                .fill(Color.regBlue)
                        }
                        .tag(index)
                    }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .automatic))
        .frame(height: 360)
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )
    }
}

#Preview {

    ZStack {

        Color.regCream
            .ignoresSafeArea()

        ListingImageCarousel(
            imageURLs: []
        )
        .padding()
    }
}
