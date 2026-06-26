import SwiftUI

struct ListingDetailScreen: View {

    let listing: Listing

    var body: some View {

        ScrollView(showsIndicators: false) {

            VStack(spacing: 22) {

                ListingImageCarousel(
                    imageURLs: listing.imageURLs
                )

                VStack(alignment: .leading, spacing: 14) {

                    Text(listing.title)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.regBrown)

                    Text(listing.brand)
                        .foregroundColor(.gray)

                    if listing.type == "sell" {

                        Text("₹\(listing.price ?? 0)")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.regBrown)

                    } else {

                        VStack(alignment: .leading, spacing: 6) {

                            Text("₹\(listing.rentalPrice ?? 0) / day")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.regBrown)

                            Text("\(listing.rentalDuration ?? 0) Days")
                                .foregroundColor(.gray)
                        }
                    }

                    Text(listing.description)
                        .foregroundColor(.regBrown)
                        .padding(.top, 6)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.white)
                .clipShape(
                    RoundedRectangle(cornerRadius: 24)
                )

                SellerCard(
                    sellerName: listing.sellerName,
                    sellerWhatsApp: listing.sellerWhatsApp
                )

                ListingActionButtons(
                    listing: listing
                )

                VStack(alignment: .leading, spacing: 12) {

                    Text("More Like This")
                        .font(.headline)
                        .foregroundColor(.regBrown)

                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.regBlue.opacity(0.35))
                        .frame(height: 140)
                        .overlay {

                            Text("Coming Soon")
                                .foregroundColor(.regBrown)
                        }
                }
            }
            .padding()
        }
        .background(Color.regCream)
        .navigationTitle("Listing")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {

    NavigationStack {

        ListingDetailScreen(

            listing: Listing(

                id: "1",

                title: "Zara Satin Dress",

                brand: "Zara",

                category: "Dress",

                size: "M",

                condition: "Like New",

                description: "Beautiful evening dress in excellent condition.",

                type: "sell",
                sellerID: "",

                price: 1800,

                rentalPrice: nil,

                rentalDuration: nil,

                imageURLs: [],

                sellerName: "Shivanshi",

                sellerWhatsApp: "+917483849515",

                createdAt: Date()
            )
        )
    }
}
