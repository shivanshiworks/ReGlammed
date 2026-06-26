import SwiftUI

struct HomeScreen: View {
    
    @StateObject private var firestoreManager = FirestoreManager()
    
    @State private var searchText = ""
    
    @State private var selectedSection = "Buy"
    
    @State private var selectedCategory = "All"
    
    @State private var heroAnimate = false
    
    @State private var recentSearches =
    UserDefaults.standard.stringArray(
        forKey: "recentSearches"
    ) ?? []
    
    let categories = [
        
        "All",
        
        "Tops",
        
        "Bottoms",
        
        "Dresses",
        
        "Outerwear",
        
        "Ethnic",
        
        "Accessories"
    ]
    
    var featuredListings: [Listing] {
        
        Array(
            firestoreManager.listings
                .prefix(5)
        )
    }
    
    var filteredListings: [Listing] {
        
        firestoreManager.listings.filter {
            
            let searchOK =
            searchText.isEmpty ||
            
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            
            $0.brand.localizedCaseInsensitiveContains(searchText)
            
            let categoryOK =
            selectedCategory == "All" ||
            
            $0.category == selectedCategory
            
            let typeOK =
            selectedSection == "Buy"
            ?
            $0.type == "sell"
            :
            $0.type == "rent"
            
            return searchOK &&
            categoryOK &&
            typeOK
        }
        .sorted {
            
            $0.createdAt >
            $1.createdAt
        }
    }
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                LinearGradient(
                    
                    colors: [
                        
                        Color.regCream,
                        
                        Color.regBlue.opacity(0.08)
                        
                    ],
                    
                    startPoint: .top,
                    
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView(
                    showsIndicators: false
                ) {
                    
                    VStack(
                        alignment: .leading,
                        spacing: 28
                    ) {
                        
                        // MARK: Header
                        
                        VStack(
                            alignment: .leading,
                            spacing: 4
                        ) {
                            
                            Text("Welcome")
                            
                                .font(.subheadline)
                            
                                .foregroundColor(.gray)
                            
                            Text("ReGlammed")
                            
                                .font(.accent(34))
                            
                                .foregroundColor(.regBrown)
                        }
                        
                        // MARK: Search
                        
                        HStack {
                            
                            Image(systemName: "magnifyingglass")
                            
                            TextField(
                                "Search fashion...",
                                text: $searchText
                            )
                            
                            Image(systemName: "slider.horizontal.3")
                        }
                        .foregroundColor(.gray)
                        .padding()
                        .background(.white)
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 20
                            )
                        )
                        .shadow(
                            color: .black.opacity(0.05),
                            radius: 12,
                            x: 0,
                            y: 5
                        )
                        
                        // MARK: Buy Rent Toggle
                        
                        HStack {
                            
                            toggleButton("Buy")
                            
                            toggleButton("Rent")
                        }
                        
                        // MARK: Hero Banner
                        
                        ZStack {
                            
                            RoundedRectangle(
                                cornerRadius: 30
                            )
                            .fill(Color.regBlue)
                            
                            VStack(
                                alignment: .leading,
                                spacing: 12
                            ) {
                                
                                Text("Luxury Fashion")
                                
                                    .font(.luxury(28))
                                
                                Text(
                                    "Buy & Rent curated styles around you."
                                )
                                
                                Spacer()
                                
                                Text("List your Pre loved wears")
                                
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.regBrown)
                            .padding(28)
                        }
                        .frame(height:220)
                        .scaleEffect(
                            heroAnimate
                            ? 1.03
                            : 1
                        )
                        .animation(
                            .easeInOut(duration:7)
                            .repeatForever(
                                autoreverses:true
                            ),
                            value: heroAnimate
                        )
                        // MARK: Categories
                        
                        ScrollView(
                            .horizontal,
                            showsIndicators: false
                        ) {
                            
                            HStack(spacing: 12) {
                                
                                ForEach(
                                    categories,
                                    id: \.self
                                ) { category in
                                    
                                    Button {
                                        
                                        withAnimation(.spring()) {
                                            
                                            selectedCategory =
                                            category
                                        }
                                        
                                    } label: {
                                        
                                        Text(category)
                                        
                                            .fontWeight(.semibold)
                                        
                                            .foregroundColor(
                                                selectedCategory == category
                                                ? .white
                                                : .regBrown
                                            )
                                        
                                            .padding(.horizontal,18)
                                            .padding(.vertical,10)
                                        
                                            .background(
                                                
                                                selectedCategory == category
                                                
                                                ?
                                                
                                                Color.regBrown
                                                
                                                :
                                                    
                                                    Color.white
                                            )
                                        
                                            .clipShape(
                                                Capsule()
                                            )
                                        
                                            .shadow(
                                                color:.black.opacity(0.05),
                                                radius:6,
                                                x:0,
                                                y:3
                                            )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        
                        // MARK: Featured
                        
                        HStack {
                            
                            Text("Featured")
                            
                                .font(.luxury(28))
                            
                                .foregroundColor(.regBrown)
                            
                            Spacer()
                            
                            NavigationLink {
                                
                                if selectedSection == "Buy" {
                                    
                                    BuyScreen()
                                    
                                } else {
                                    
                                    RentScreen()
                                }
                                
                            } label: {
                                
                                Text("See All")
                                
                                    .fontWeight(.bold)
                                
                                    .foregroundColor(.regBrown)
                            }
                        }
                        
                        ScrollView(
                            .horizontal,
                            showsIndicators: false
                        ) {
                            
                            HStack(spacing:22) {
                                
                                ForEach(
                                    featuredListings
                                ) { listing in
                                    
                                    NavigationLink {
                                        
                                        ListingDetailScreen(
                                            listing: listing
                                        )
                                        
                                    } label: {
                                        
                                        ProductCard(
                                            
                                            title: listing.title,
                                            
                                            brand: listing.brand,
                                            
                                            price:
                                                listing.price ??
                                            listing.rentalPrice ??
                                            0,
                                            
                                            badge:
                                                listing.type.uppercased(),
                                            
                                            imageURL:
                                                listing.imageURLs.first
                                        )
                                        .frame(width:280)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        
                        // MARK: Just Listed
                        
                        Text("Just Listed")
                        
                            .font(.luxury(28))
                        
                            .foregroundColor(.regBrown)
                        
                        LazyVGrid(
                            
                            columns: [
                                
                                GridItem(.flexible()),
                                
                                GridItem(.flexible())
                            ],
                            
                            spacing:18
                        ) {
                            
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
                                            listing.price ??
                                        listing.rentalPrice ??
                                        0,
                                        
                                        badge:
                                            listing.type.uppercased(),
                                        
                                        imageURL:
                                            listing.imageURLs.first
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
            }
            .navigationBarHidden(true)
            
            .onChange(of: searchText) { _, newValue in
                
                guard
                    !newValue.isEmpty,
                    !recentSearches.contains(newValue)
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
                
                heroAnimate = true
                
                firestoreManager.fetchListings()
            }
        }
        .fadeSlide()
    }
    
    // MARK: Toggle Button
    
    @ViewBuilder
    
    func toggleButton(
        _ title: String
    ) -> some View {
        
        Button {
            
            withAnimation(
                .spring(
                    response: 0.35,
                    dampingFraction: 0.8
                )
            ) {
                
                selectedSection = title
            }
            
        } label: {
            
            Text(title)
            
                .fontWeight(.bold)
            
                .foregroundColor(
                    
                    selectedSection == title
                    
                    ?
                    
                        .white
                    
                    :
                        
                            .regBrown
                )
            
                .frame(maxWidth: .infinity)
            
                .padding(.vertical, 14)
            
                .background(
                    
                    selectedSection == title
                    
                    ?
                    
                    Color.regBrown
                    
                    :
                        
                        Color.white
                )
            
                .clipShape(
                    
                    RoundedRectangle(
                        cornerRadius: 18
                    )
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {

    NavigationStack {

        HomeScreen()
    }
}
