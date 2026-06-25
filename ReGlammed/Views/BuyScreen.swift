import SwiftUI

struct BuyScreen: View {

    @StateObject private var firestoreManager = FirestoreManager()

    @State private var searchText = ""

    @State private var showFilters = false

    @State private var selectedCategory = ""
    @State private var selectedSize = ""
    @State private var selectedBrand = ""

    @State private var sortOption = "Newest First"

    let sortOptions = [
        "Newest First",
        "Oldest First",
        "Price Low To High",
        "Price High To Low"
    ]

    var brands: [String] {

        Array(
            Set(
                firestoreManager.listings
                    .filter { $0.type == "sell" }
                    .map { $0.brand }
            )
        )
        .sorted()
    }

    var filteredListings: [Listing] {

        var listings =
            firestoreManager.listings.filter {
                $0.type == "sell"
            }

        if !searchText.isEmpty {

            listings = listings.filter {

                $0.title.localizedCaseInsensitiveContains(
                    searchText
                )
                ||
                $0.brand.localizedCaseInsensitiveContains(
                    searchText
                )
            }
        }

        if !selectedCategory.isEmpty {

            listings = listings.filter {
                $0.category == selectedCategory
            }
        }

        if !selectedSize.isEmpty {

            listings = listings.filter {
                $0.size == selectedSize
            }
        }

        if !selectedBrand.isEmpty {

            listings = listings.filter {
                $0.brand == selectedBrand
            }
        }

        switch sortOption {

        case "Oldest First":

            listings.sort {
                $0.createdAt < $1.createdAt
            }

        case "Price Low To High":

            listings.sort {
                ($0.price ?? 0)
                <
                ($1.price ?? 0)
            }

        case "Price High To Low":

            listings.sort {
                ($0.price ?? 0)
                >
                ($1.price ?? 0)
            }

        default:

            listings.sort {
                $0.createdAt > $1.createdAt
            }
        }

        return listings
    }

    var body: some View {

        NavigationStack {

            ZStack {

                Color.regCream
                    .ignoresSafeArea()

                ScrollView {

                    VStack(
                        alignment: .leading,
                        spacing: 20
                    ) {

                        TextField(
                            "Search",
                            text: $searchText
                        )
                        .padding()
                        .background(.white)
                        .cornerRadius(16)

                        HStack {

                            Button("Filters") {

                                showFilters = true
                            }

                            Spacer()

                            Menu {

                                ForEach(
                                    sortOptions,
                                    id: \.self
                                ) { option in

                                    Button(option) {

                                        sortOption =
                                            option
                                    }
                                }

                            } label: {

                                Label(
                                    "Sort",
                                    systemImage:
                                        "arrow.up.arrow.down"
                                )
                            }
                        }

                        ForEach(
                            filteredListings
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
                                        listing.price ?? 0,
                                    badge:
                                        "SELL",
                                    imageURL:
                                        listing.imageURLs.first
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Buy")
            .sheet(
                isPresented: $showFilters
            ) {

                FilterSheet(
                    selectedCategory:
                        $selectedCategory,
                    selectedSize:
                        $selectedSize,
                    selectedBrand:
                        $selectedBrand,
                    categories: [
                        "Tops",
                        "Bottoms",
                        "Dresses",
                        "Outerwear",
                        "Ethnic Wear",
                        "Accessories"
                    ],
                    sizes: [
                        "XS",
                        "S",
                        "M",
                        "L",
                        "XL",
                        "XXL",
                        "One Size"
                    ],
                    brands: brands
                )
            }
            .onAppear {

                firestoreManager.fetchListings()
            }
        }
    }
}

#Preview {
    BuyScreen()
}
