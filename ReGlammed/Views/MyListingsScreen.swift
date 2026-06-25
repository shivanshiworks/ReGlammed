//
//  MyListingsScreen.swift
//  ReGlammed
//
//  Created by Rashmi Priyadarshi on 25/06/26.
//

import SwiftUI

struct MyListingsScreen: View {

    @StateObject private var firestoreManager = FirestoreManager()

    var myListings: [Listing] {

        firestoreManager.listings.filter {

            $0.sellerName == "Shivanshi"
        }
    }

    var body: some View {

        ZStack {

            Color.regCream
                .ignoresSafeArea()

            if myListings.isEmpty {

                VStack(spacing: 20) {

                    Image(systemName: "hanger")

                        .font(.system(size: 55))
                        .foregroundColor(.regBrown)

                    Text("No Listings Yet")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.regBrown)
                }

            } else {

                ScrollView {

                    LazyVStack(spacing: 20) {

                        ForEach(myListings) { listing in

                            VStack(alignment: .leading) {

                                if let image =
                                    listing.imageURLs.first,

                                   let url =
                                    URL(string: image) {

                                    AsyncImage(url: url) { image in

                                        image
                                            .resizable()
                                            .scaledToFill()

                                    } placeholder: {

                                        Rectangle()
                                            .fill(Color.regBlue)
                                    }
                                    .frame(height: 220)
                                    .clipped()
                                    .cornerRadius(16)
                                }

                                Text(listing.title)
                                    .font(.headline)
                                    .foregroundColor(.regBrown)

                                Text(listing.brand)
                                    .foregroundColor(.gray)

                                HStack {

                                    Button {

                                        // Edit comes next

                                    } label: {

                                        Text("Edit")
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.regBlue)
                                            .foregroundColor(.regBrown)
                                            .cornerRadius(12)
                                    }

                                    Button {

                                        firestoreManager.deleteListing(
                                            id: listing.id
                                        )

                                    } label: {

                                        Text("Delete")
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.red.opacity(0.15))
                                            .foregroundColor(.red)
                                            .cornerRadius(12)
                                    }
                                }
                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(22)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("My Listings")
        .onAppear {

            firestoreManager.fetchListings()
        }
    }
}

#Preview {

    MyListingsScreen()
}
