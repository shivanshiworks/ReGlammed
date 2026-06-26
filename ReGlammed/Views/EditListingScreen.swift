//
//  EditListingScreen.swift
//  ReGlammed
//
//  Created by Rashmi Priyadarshi on 25/06/26.
//

import SwiftUI

struct EditListingScreen: View {

    @Environment(\.dismiss) private var dismiss

    @StateObject private var firestoreManager = FirestoreManager()

    let listing: Listing

    @State private var title = ""
    @State private var brand = ""
    @State private var description = ""

    @State private var price = ""
    @State private var rentalPrice = ""
    @State private var rentalDuration = ""

    var body: some View {

        ScrollView {

            VStack(spacing: 22) {

                InputCard(title: "Basic Information") {

                    TextField(
                        "Title",
                        text: $title
                    )

                    Divider()

                    TextField(
                        "Brand",
                        text: $brand
                    )

                    Divider()

                    TextField(
                        "Description",
                        text: $description,
                        axis: .vertical
                    )
                    .lineLimit(4)
                }

                if listing.type == "sell" {

                    InputCard(title: "Price") {

                        TextField(
                            "Price",
                            text: $price
                        )
                        .keyboardType(.numberPad)
                    }

                } else {

                    InputCard(title: "Rental Details") {

                        TextField(
                            "Rental Price",
                            text: $rentalPrice
                        )
                        .keyboardType(.numberPad)

                        Divider()

                        TextField(
                            "Rental Duration",
                            text: $rentalDuration
                        )
                        .keyboardType(.numberPad)
                    }
                }

                PrimaryButton(
                    title: "Save Changes",
                    color: .regYellow
                ) {

                    saveChanges()
                }
            }
            .padding()
        }
        .background(Color.regCream)
        .navigationTitle("Edit Listing")

        .onAppear {

            title = listing.title
            brand = listing.brand
            description = listing.description

            price = "\(listing.price ?? 0)"
            rentalPrice = "\(listing.rentalPrice ?? 0)"
            rentalDuration = "\(listing.rentalDuration ?? 0)"
        }
    }

    func saveChanges() {

        let updatedListing = Listing(

            id: listing.id,

            title: title,

            brand: brand,

            category: listing.category,

            size: listing.size,

            condition: listing.condition,

            description: description,

            type: listing.type,
            sellerID: listing.sellerID,
            price: Int(price),

            rentalPrice: Int(rentalPrice),

            rentalDuration: Int(rentalDuration),

            imageURLs: listing.imageURLs,
            

            sellerName: listing.sellerName,

            sellerWhatsApp: listing.sellerWhatsApp,

            createdAt: listing.createdAt
        )

        firestoreManager.updateListing(
            listing: updatedListing
        )

        dismiss()
    }
}

#Preview {

    NavigationStack {

        EditListingScreen(

            listing: Listing(

                id: "1",

                title: "Zara Dress",

                brand: "Zara",

                category: "Dresses",

                size: "M",

                condition: "Like New",

                description: "Beautiful dress",

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
    }
}
