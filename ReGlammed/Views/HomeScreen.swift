import SwiftUI

struct HomeScreen: View {

    @StateObject private var firestoreManager = FirestoreManager()

    @State private var searchText = ""

    @State private var recentSearches: [String] =
        UserDefaults.standard.stringArray(
            forKey: "recentSearches"
        ) ?? []

    var filteredListings: [Listing] {

        if searchText.isEmpty {

            return firestoreManager.listings
                .sorted {
                    $0.createdAt > $1.createdAt
                }
        }

        return firestoreManager.listings
            .filter {

                $0.title.localizedCaseInsensitiveContains(
                    searchText
                )
                ||
                $0.brand.localizedCaseInsensitiveContains(
                    searchText
                )
            }
            .sorted {
                $0.createdAt > $1.createdAt
            }
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

                        if !recentSearches.isEmpty {

                            VStack(
                                alignment: .leading,
                                spacing: 8
                            ) {

                                Text("Recent Searches")

                                ScrollView(
                                    .horizontal,
                                    showsIndicators: false
                                ) {

                                    HStack {

                                        ForEach(
                                            recentSearches,
                                            id: \.self
                                        ) { search in

                                            Button {

                                                searchText =
                                                    search

                                            } label: {

                                                Text(search)
                                                    .padding(.horizontal, 12)
                                                    .padding(.vertical, 8)
                                                    .background(Color.regYellow)
                                                    .cornerRadius(12)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        VStack(spacing: 16) {

                            NavigationLink {

                                BuyScreen()

                            } label: {

                                RoundedRectangle(
                                    cornerRadius: 20
                                )
                                .fill(Color.regBlue)
                                .frame(height: 120)
                                .overlay {

                                    Text("Browse to Buy")
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.regBrown)
                                }
                            }

                            NavigationLink {

                                RentScreen()

                            } label: {

                                RoundedRectangle(
                                    cornerRadius: 20
                                )
                                .fill(Color.regYellow)
                                .frame(height: 120)
                                .overlay {

                                    Text("Browse to Rent")
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.regBrown)
                                }
                            }
                        }

                        Text("Featured Listings")
                            .font(.headline)
                            .foregroundColor(.regBrown)

                        ScrollView(
                            .horizontal,
                            showsIndicators: false
                        ) {

                            HStack(spacing: 16) {

                                ForEach(
                                    Array(
                                        firestoreManager.listings.prefix(5)
                                    )
                                ) { listing in

                                    NavigationLink {

                                        ListingDetailScreen(
                                            listing: listing
                                        )

                                    } label: {

                                        ProductCard(
                                            title: listing.title,
                                            brand: listing.brand,
                                            price: listing.price ?? listing.rentalPrice ?? 0,
                                            badge: listing.type.uppercased(),
                                            imageURL: listing.imageURLs.first
                                        )
                                        .frame(width: 260)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Home")

            .toolbar {

                ToolbarItem(
                    placement: .topBarTrailing
                ) {

                    NavigationLink {

                        SavedCartScreen()

                    } label: {

                        Image(
                            systemName: "bag"
                        )
                    }
                }
            }

            .onChange(
                of: searchText
            ) { _, newValue in

                guard
                    !newValue.isEmpty,
                    !recentSearches.contains(
                        newValue
                    )
                else {
                    return
                }

                recentSearches.insert(
                    newValue,
                    at: 0
                )

                recentSearches =
                    Array(
                        recentSearches.prefix(10)
                    )

                UserDefaults.standard.set(
                    recentSearches,
                    forKey: "recentSearches"
                )
            }

            .onAppear {

                firestoreManager.fetchListings()
            }
        }
    }
}

#Preview {
    HomeScreen()
}
