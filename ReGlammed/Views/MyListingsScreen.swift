import SwiftUI
import FirebaseAuth
struct MyListingsScreen: View {

    @StateObject private var firestoreManager = FirestoreManager()

    @State private var showingDeleteAlert = false
    @State private var listingToDelete: Listing?

    var myListings: [Listing] {

        firestoreManager.listings

            .filter {

                $0.sellerID == Auth.auth().currentUser?.uid
            }

            .sorted {

                $0.createdAt > $1.createdAt
            }
    }

    var body: some View {

        ZStack {

            Color.regCream
                .ignoresSafeArea()

            if myListings.isEmpty {

                VStack(spacing: 18) {

                    Image(systemName: "hanger")

                        .font(.system(size: 55))

                        .foregroundColor(.regBrown)

                    Text("No Listings Yet")

                        .font(.title2)

                        .fontWeight(.bold)

                        .foregroundColor(.regBrown)

                    Text("Your uploaded listings will appear here.")

                        .foregroundColor(.gray)
                }

            } else {

                ScrollView(showsIndicators: false) {

                    LazyVStack(spacing: 22) {

                        ForEach(myListings) { listing in

                            VStack(alignment: .leading, spacing: 14) {

                                ProductCard(

                                    title: listing.title,

                                    brand: listing.brand,

                                    price: listing.price ??
                                        listing.rentalPrice ??
                                        0,

                                    badge: listing.type.uppercased(),

                                    imageURL: listing.imageURLs.first
                                )

                                HStack(spacing: 14) {

                                    NavigationLink {

                                        EditListingScreen(
                                            listing: listing
                                        )


                                    } label: {

                                        HStack {

                                            Image(systemName: "pencil")

                                            Text("Edit")
                                        }
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.regBlue)
                                        .foregroundColor(.regBrown)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 18)
                                        )
                                    }

                                    Button {

                                        listingToDelete = listing
                                        showingDeleteAlert = true

                                    } label: {

                                        HStack {

                                            Image(systemName: "trash")

                                            Text("Delete")
                                        }
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(
                                            Color.red.opacity(0.12)
                                        )
                                        .foregroundColor(.red)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 18)
                                        )
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("My Listings")

        .alert(
            "Delete Listing?",
            isPresented: $showingDeleteAlert
        ) {

            Button(
                "Delete",
                role: .destructive
            ) {

                if let listing = listingToDelete {

                    firestoreManager.deleteListing(
                        id: listing.id
                    )
                }
            }

            Button(
                "Cancel",
                role: .cancel
            ) { }

        } message: {

            Text(
                "This action cannot be undone."
            )
        }

        .onAppear {

            firestoreManager.fetchListings()
        }
    }
}

#Preview {

    NavigationStack {

        MyListingsScreen()
    }
}
