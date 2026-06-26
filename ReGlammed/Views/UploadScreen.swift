import SwiftUI
import FirebaseAuth
struct UploadScreen: View {

    @StateObject private var firestoreManager = FirestoreManager()
    @StateObject private var userManager = UserManager()
    @State private var listingType = "Sell"

    @State private var title = ""
    @State private var brand = ""
    @State private var description = ""

    @State private var selectedCategory = "Tops"
    @State private var selectedSize = "M"
    @State private var selectedCondition = "Like New"

    @State private var price = ""
    @State private var rentalPrice = ""
    @State private var rentalDuration = ""

    @State private var whatsapp = "+91"

    @State private var selectedImages: [UIImage] = []

    @State private var isUploading = false

    @State private var showSuccessAlert = false
    @State private var showValidationAlert = false

    @State private var validationMessage = ""

    let listingTypes = [
        "Sell",
        "Rent"
    ]

    let categories = [
        "Tops",
        "Bottoms",
        "Dresses",
        "Outerwear",
        "Ethnic Wear",
        "Accessories"
    ]

    let sizes = [
        "XS",
        "S",
        "M",
        "L",
        "XL",
        "XXL",
        "One Size"
    ]

    let conditions = [
        "New With Tags",
        "Like New",
        "Excellent",
        "Good",
        "Fair"
    ]

    var body: some View {

        NavigationStack {

            ZStack {

                Color.regCream
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {

                    VStack(spacing: 22) {
                        
                        InputCard(title: "Photos") {
                            
                            ImagePicker(
                                selectedImages: $selectedImages
                            )
                            
                            ScrollView(
                                .horizontal,
                                showsIndicators: false
                            ) {
                                
                                HStack(spacing: 12) {
                                    
                                    ForEach(
                                        selectedImages.indices,
                                        id: \.self
                                    ) { index in
                                        
                                        Image(
                                            uiImage: selectedImages[index]
                                        )
                                        .resizable()
                                        .scaledToFill()
                                        .frame(
                                            width: 100,
                                            height: 100
                                        )
                                        .clipShape(
                                            RoundedRectangle(
                                                cornerRadius: 16
                                            )
                                        )
                                    }
                                }
                            }
                        }
                        
                        InputCard(title: "Listing Type") {
                            
                            Picker(
                                "",
                                selection: $listingType
                            ) {
                                
                                ForEach(
                                    listingTypes,
                                    id: \.self
                                ) {
                                    
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        
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
                            
                            Picker(
                                "Category",
                                selection: $selectedCategory
                            ) {
                                
                                ForEach(
                                    categories,
                                    id: \.self
                                ) {
                                    
                                    Text($0)
                                }
                            }
                            
                            Divider()
                            
                            Picker(
                                "Size",
                                selection: $selectedSize
                            ) {
                                
                                ForEach(
                                    sizes,
                                    id: \.self
                                ) {
                                    
                                    Text($0)
                                }
                            }
                            
                            Divider()
                            
                            Picker(
                                "Condition",
                                selection: $selectedCondition
                            ) {
                                
                                ForEach(
                                    conditions,
                                    id: \.self
                                ) {
                                    
                                    Text($0)
                                }
                            }
                            
                            Divider()
                            
                            TextField(
                                "Description",
                                text: $description,
                                axis: .vertical
                            )
                            .lineLimit(4)
                        }
                        if listingType == "Sell" {

                            InputCard(title: "Price") {

                                TextField(
                                    "Price",
                                    text: $price
                                )
                                .keyboardType(.numberPad)
                            }
                        }

                        if listingType == "Rent" {

                            InputCard(title: "Rental Details") {

                                TextField(
                                    "Rental Price Per Day",
                                    text: $rentalPrice
                                )
                                .keyboardType(.numberPad)

                                Divider()

                                TextField(
                                    "Rental Duration (Days)",
                                    text: $rentalDuration
                                )
                                .keyboardType(.numberPad)
                            }
                        }

                        InputCard(title: "Seller") {

                            TextField(
                                "WhatsApp Number (+Country Code)",
                                text: $whatsapp
                            )
                            .keyboardType(.phonePad)
                        }

                        PrimaryButton(
                            title: "Publish Listing",
                            color: .regYellow
                        ) {

                            uploadListing()
                        }
                    }
                    .padding()
                }

                if isUploading {

                    LoadingOverlay(
                        message: "Uploading Listing..."
                    )
                }
            }
            .navigationTitle("Upload")

            .alert(
                "Listing Published",
                isPresented: $showSuccessAlert
            ) {

                Button("OK") {

                    clearForm()
                }

            } message: {

                Text("Your listing has been published successfully.")
            }

            .alert(
                "Missing Information",
                isPresented: $showValidationAlert
            ) {

                Button("OK") { }

            } message: {

                Text(validationMessage)
            }
            .onAppear {

                userManager.fetchUser()
            }
        }
    }

    func uploadListing() {

        guard !title.isEmpty else {

            validationMessage = "Please enter a title."
            showValidationAlert = true
            return
        }

        guard !brand.isEmpty else {

            validationMessage = "Please enter a brand."
            showValidationAlert = true
            return
        }

        guard !description.isEmpty else {

            validationMessage = "Please enter a description."
            showValidationAlert = true
            return
        }

        guard !whatsapp.isEmpty else {

            validationMessage = "Please enter your WhatsApp number with country code."
            showValidationAlert = true
            return
        }

        isUploading = true

        var uploadedURLs: [String] = []

        let group = DispatchGroup()

        for image in selectedImages {

            group.enter()

            StorageManager.shared.uploadImage(
                image: image
            ) { url in

                if let url {

                    uploadedURLs.append(url)
                }

                group.leave()
            }
        }

        group.notify(queue: .main) {
            firestoreManager.addListing(

                title: title,

                brand: brand,

                category: selectedCategory,

                size: selectedSize,

                condition: selectedCondition,

                description: description,

                type: listingType.lowercased(),

                price: Int(price),

                rentalPrice: Int(rentalPrice),

                rentalDuration: Int(rentalDuration),

                imageURLs: uploadedURLs,

                sellerID: Auth.auth().currentUser?.uid ?? "",

                sellerName: userManager.userProfile?.name ?? "",

                sellerWhatsApp: userManager.userProfile?.whatsapp ?? ""
            )

            isUploading = false

            showSuccessAlert = true
        }
    }

    func clearForm() {

        listingType = "Sell"

        title = ""
        brand = ""
        description = ""

        selectedCategory = "Tops"
        selectedSize = "M"
        selectedCondition = "Like New"

        price = ""
        rentalPrice = ""
        rentalDuration = ""

        whatsapp = "+91"

        selectedImages = []
    }
}

#Preview {

    UploadScreen()
}
