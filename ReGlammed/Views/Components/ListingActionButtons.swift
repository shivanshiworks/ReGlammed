//
//  ListingActionButtons.swift
//  ReGlammed
//
//  Created by Rashmi Priyadarshi on 25/06/26.
//

import SwiftUI

struct ListingActionButtons: View {

    let listing: Listing

    @StateObject private var savedCartManager = SavedCartManager()

    var body: some View {

        VStack(spacing: 14) {

            Button {

                savedCartManager.toggleSaved(
                    listingID: listing.id
                )

            } label: {

                HStack {

                    Image(
                        systemName:
                            savedCartManager.isSaved(
                                listingID: listing.id
                            )
                            ? "heart.fill"
                            : "heart"
                    )

                    Text(
                        savedCartManager.isSaved(
                            listingID: listing.id
                        )
                        ? "Saved"
                        : "Save To Cart"
                    )

                    Spacer()
                }
                .padding()
                .background(Color.regYellow)
                .foregroundColor(.regBrown)
                .clipShape(
                    RoundedRectangle(cornerRadius: 18)
                )
            }

            Button {

                let text =
"""
\(listing.title)

\(listing.brand)

₹\(listing.price ?? listing.rentalPrice ?? 0)
"""

                let activityVC =
                    UIActivityViewController(
                        activityItems: [text],
                        applicationActivities: nil
                    )

                UIApplication.shared
                    .connectedScenes
                    .compactMap {
                        $0 as? UIWindowScene
                    }
                    .first?
                    .windows
                    .first?
                    .rootViewController?
                    .present(
                        activityVC,
                        animated: true
                    )

            } label: {

                HStack {

                    Image(systemName: "square.and.arrow.up")

                    Text("Share Listing")

                    Spacer()
                }
                .padding()
                .background(Color.regBlue)
                .foregroundColor(.regBrown)
                .clipShape(
                    RoundedRectangle(cornerRadius: 18)
                )
            }

            Button {

                let phone =
                    listing.sellerWhatsApp
                        .replacingOccurrences(
                            of: "+",
                            with: ""
                        )

                if let url = URL(
                    string: "https://wa.me/\(phone)"
                ) {

                    UIApplication.shared.open(url)
                }

            } label: {

                HStack {

                    Image(systemName: "message.fill")

                    Text("Contact on WhatsApp")

                    Spacer()
                }
                .padding()
                .background(Color.green.opacity(0.15))
                .foregroundColor(.green)
                .clipShape(
                    RoundedRectangle(cornerRadius: 18)
                )
            }
        }
    }
}

#Preview {

    ListingActionButtons(

        listing: Listing(

            id: "1",

            title: "Zara Dress",

            brand: "Zara",

            category: "Dress",

            size: "M",

            condition: "Like New",

            description: "Sample",

            type: "sell",
            sellerID: "",
            price: 1200,

            rentalPrice: nil,

            rentalDuration: nil,

            imageURLs: [],

            sellerName: "Shivanshi",

            sellerWhatsApp: "+917483849515",

            createdAt: Date()
        )
    )
    .padding()
}
