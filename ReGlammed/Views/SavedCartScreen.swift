//
//  SavedCartScreen.swift
//  ReGlammed
//
//  Created by Rashmi Priyadarshi on 23/06/26.
//

import SwiftUI

struct SavedCartScreen: View {

    @StateObject private var firestoreManager =
        FirestoreManager()

    @StateObject private var savedCartManager =
        SavedCartManager()

    var savedListings: [Listing] {

        firestoreManager.listings.filter {

            savedCartManager.savedListingIDs
                .contains($0.id)
        }
    }

    var body: some View {

        NavigationStack {

            ZStack {

                Color.regCream
                    .ignoresSafeArea()

                if savedListings.isEmpty {

                    VStack(spacing: 16) {

                        Image(
                            systemName: "bag"
                        )
                        .font(.system(size: 50))

                        Text(
                            "No Saved Listings"
                        )
                        .font(.title3)
                        .bold()
                    }

                } else {

                    ScrollView {

                        LazyVStack(
                            spacing: 20
                        ) {

                            ForEach(
                                savedListings
                            ) { listing in

                                NavigationLink {

                                    ListingDetailScreen(
                                        listing: listing
                                    )

                                } label: {

                                    ProductCard(
                                        title:
                                            listing.title,
                                        brand:
                                            listing.brand,
                                        price:
                                            listing.price ??
                                            listing.rentalPrice ??
                                            0,
                                        badge:
                                            listing.type.uppercased(),
                                        imageURL:
                                            listing.imageURLs.first
                                    )
                                }
                                .buttonStyle(
                                    .plain
                                )
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle(
                "Saved Cart"
            )
            .onAppear {

                firestoreManager
                    .fetchListings()
            }
        }
    }
}

#Preview {

    SavedCartScreen()
}
