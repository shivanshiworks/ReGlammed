import SwiftUI

struct RentScreen: View {

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

    let categories = [

        "All",

        "Tops",

        "Bottoms",

        "Dresses",

        "Outerwear",

        "Ethnic Wear",

        "Accessories"
    ]

    var brands: [String] {

        Array(
            Set(
                firestoreManager.listings
                    .filter { $0.type == "rent" }
                    .map { $0.brand }
            )
        )
        .sorted()
    }

    var filteredListings: [Listing] {

        var listings =
            firestoreManager.listings.filter {

                $0.type == "rent"
            }

        if !searchText.isEmpty {

            listings = listings.filter {

                $0.title.localizedCaseInsensitiveContains(searchText)

                ||

                $0.brand.localizedCaseInsensitiveContains(searchText)
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

                ($0.rentalPrice ?? 0)

                <

                ($1.rentalPrice ?? 0)
            }

        case "Price High To Low":

            listings.sort {

                ($0.rentalPrice ?? 0)

                >

                ($1.rentalPrice ?? 0)
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
                
                LinearGradient(
                    
                    colors: [
                        
                        Color.regCream,
                        
                        Color.regBlue.opacity(0.18)
                        
                    ],
                    
                    startPoint: .top,
                    
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        Text("Rent")
                        
                            .font(
                                .system(
                                    size: 40,
                                    weight: .black
                                )
                            )
                        
                            .foregroundColor(.regBrown)
                        
                        HStack {
                            
                            Image(systemName: "magnifyingglass")
                            
                            TextField(
                                "Search rentals...",
                                text: $searchText
                            )
                            
                            Button {
                                
                                showFilters = true
                                
                            } label: {
                                
                                Image(systemName: "slider.horizontal.3")
                            }
                        }
                        .padding()
                        .background(.white)
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 18
                            )
                        )
                        
                        RoundedRectangle(
                            cornerRadius: 26
                        )
                        .fill(Color.regBlue.opacity(0.35))
                        .frame(height: 150)
                        
                        .overlay {
                            
                            VStack(
                                alignment: .leading,
                                spacing: 12
                            ) {
                                
                                Text("Rent Luxury")
                                
                                    .font(
                                        .system(
                                            size: 30,
                                            weight: .black
                                        )
                                    )
                                
                                Text("Wear it once. Love it forever.")
                                
                                    .font(.headline)
                                
                                Spacer()
                                
                                HStack {
                                    
                                    Image(systemName: "clock")
                                    
                                    Text("Affordable daily rentals")
                                }
                            }
                            .foregroundColor(.regBrown)
                            .padding()
                        }
                        
                        HStack {
                            
                            ScrollView(
                                .horizontal,
                                showsIndicators: false
                            ) {
                                
                                HStack(spacing: 10) {
                                    
                                    ForEach(
                                        categories,
                                        id: \.self
                                    ) { category in
                                        
                                        categoryChip(category)
                                    }
                                }
                            }
                            
                            Spacer()
                            
                            Menu {
                                
                                ForEach(
                                    sortOptions,
                                    id: \.self
                                ) { option in
                                    
                                    Button(option) {
                                        
                                        sortOption = option
                                    }
                                }
                                
                            } label: {
                                
                                Image(
                                    systemName:
                                        "arrow.up.arrow.down"
                                )
                                
                                .foregroundColor(.regBrown)
                                
                                .padding(10)
                                
                                .background(.white)
                                
                                .clipShape(Circle())
                            }
                        }
                        
                        LazyVStack(
                            spacing: 26
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
                                        
                                        title: listing.title,
                                        
                                        brand: listing.brand,
                                        
                                        price: listing.rentalPrice ?? 0,
                                        
                                        badge: "RENT",
                                        
                                        imageURL: listing.imageURLs.first
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)

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
                .presentationDetents([.medium,.large])
                .presentationCornerRadius(30)
            }

            .onAppear {

                firestoreManager.fetchListings()
            }
        }
        .fadeSlide()
    }

    // MARK: Category Chip

    @ViewBuilder

    func categoryChip(
        _ title: String
    ) -> some View {

        Button {

            withAnimation(.spring()) {

                selectedCategory =

                title == "All"

                ?

                ""

                :

                title
            }

        } label: {

            Text(title)

                .font(.subheadline)

                .fontWeight(.semibold)

                .foregroundColor(

                    selectedCategory == title ||

                    (

                        title == "All"

                        &&

                        selectedCategory.isEmpty

                    )

                    ?

                    .white

                    :

                    .regBrown
                )

                .padding(.horizontal,16)

                .padding(.vertical,10)

                .background(

                    selectedCategory == title ||

                    (

                        title == "All"

                        &&

                        selectedCategory.isEmpty

                    )

                    ?

                    Color.regBlue

                    :

                    .white
                )

                .clipShape(Capsule())

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

#Preview {

    RentScreen()
}
