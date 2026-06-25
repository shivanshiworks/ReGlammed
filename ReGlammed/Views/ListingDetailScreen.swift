import SwiftUI

struct ListingDetailScreen: View {

    let listing: Listing

    @StateObject private var savedCartManager =
        SavedCartManager()

    var body: some View {

        ScrollView {

            VStack(
                alignment: .leading,
                spacing: 16
            ) {

                if let firstImageURL =
                    listing.imageURLs.first,

                   let url =
                    URL(
                        string:
                            firstImageURL
                    ) {

                    AsyncImage(
                        url: url
                    ) { image in

                        image
                            .resizable()
                            .scaledToFill()

                    } placeholder: {

                        Rectangle()
                            .fill(
                                Color.regBlue
                            )
                    }
                    .frame(
                        height: 350
                    )
                    .clipped()
                    .cornerRadius(
                        20
                    )

                } else {

                    Rectangle()
                        .fill(
                            Color.regBlue
                        )
                        .frame(
                            height: 350
                        )
                        .cornerRadius(
                            20
                        )
                }

                VStack(
                    alignment: .leading,
                    spacing: 12
                ) {

                    Text(
                        listing.title
                    )
                    .font(
                        .largeTitle
                    )
                    .bold()

                    Text(
                        listing.brand
                    )
                    .foregroundColor(
                        .regBrown
                            .opacity(
                                0.7
                            )
                    )

                    Text(
                        listing.description
                    )

                    Divider()

                    if listing.type ==
                        "sell" {

                        Text(
                            "₹\(listing.price ?? 0)"
                        )
                        .font(
                            .title
                        )
                        .bold()
                        .foregroundColor(
                            .regBrown
                        )

                    } else {

                        Text(
                            "₹\(listing.rentalPrice ?? 0) / day"
                        )
                        .font(
                            .title
                        )
                        .bold()
                        .foregroundColor(
                            .regBrown
                        )

                        Text(
                            "\(listing.rentalDuration ?? 0) days"
                        )
                    }

                    Divider()

                    Text(
                        "Seller"
                    )
                    .font(
                        .headline
                    )

                    Text(
                        listing.sellerName
                    )

                    Text(
                        listing.sellerWhatsApp
                    )

                    Button {

                        savedCartManager
                            .toggleSaved(
                                listingID:
                                    listing.id
                            )

                    } label: {

                        HStack {

                            Image(
                                systemName:
                                    savedCartManager
                                    .isSaved(
                                        listingID:
                                            listing.id
                                    )
                                ?
                                "heart.fill"
                                :
                                "heart"
                            )

                            Text(
                                savedCartManager
                                .isSaved(
                                    listingID:
                                        listing.id
                                )
                                ?
                                "Saved"
                                :
                                "Save To Cart"
                            )
                        }
                        .frame(
                            maxWidth:
                                .infinity
                        )
                        .padding()
                        .background(
                            Color.regYellow
                        )
                        .foregroundColor(
                            .regBrown
                        )
                        .cornerRadius(
                            16
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
                                activityItems:
                                    [text],
                                applicationActivities:
                                    nil
                            )

                        UIApplication
                            .shared
                            .connectedScenes
                            .compactMap {
                                $0
                                    as? UIWindowScene
                            }
                            .first?
                            .windows
                            .first?
                            .rootViewController?
                            .present(
                                activityVC,
                                animated:
                                    true
                            )

                    } label: {

                        Text(
                            "Share Listing"
                        )
                        .frame(
                            maxWidth:
                                .infinity
                        )
                        .padding()
                        .background(
                            Color.regBlue
                        )
                        .foregroundColor(
                            .regBrown
                        )
                        .cornerRadius(
                            16
                        )
                    }
                }
                .padding()
            }
        }
        .background(
            Color.regCream
        )
        .navigationTitle(
            "Listing"
        )
        .navigationBarTitleDisplayMode(
            .inline
        )
    }
}

#Preview {

    ListingDetailScreen(

        listing: Listing(

            id: "1",

            title:
                "Sample Dress",

            brand:
                "Zara",

            category:
                "Dresses",

            size:
                "M",

            condition:
                "Like New",

            description:
                "Beautiful dress",

            type:
                "sell",

            price:
                1000,

            rentalPrice:
                nil,

            rentalDuration:
                nil,

            imageURLs:
                [],

            sellerName:
                "Shivanshi",

            sellerWhatsApp:
                "7483849515",

            createdAt:
                Date()
        )
    )
}
