import SwiftUI

struct UploadScreen: View {

    @StateObject private var firestoreManager = FirestoreManager()

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

                ScrollView {

                    VStack(spacing: 24) {

                        VStack(alignment: .leading) {

                            Text("Photos")
                                .font(.headline)
                                .foregroundColor(.regBrown)

                            ImagePicker(
                                selectedImages: $selectedImages
                            )

                            ScrollView(
                                .horizontal,
                                showsIndicators: false
                            ) {

                                HStack {

                                    ForEach(
                                        selectedImages.indices,
                                        id: \.self
                                    ) { index in

                                        Image(
                                            uiImage:
                                                selectedImages[index]
                                        )
                                        .resizable()
                                        .scaledToFill()
                                        .frame(
                                            width: 100,
                                            height: 100
                                        )
                                        .clipped()
                                        .cornerRadius(14)
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(20)

                        VStack(alignment: .leading) {

                            Text("Listing Type")
                                .font(.headline)
                                .foregroundColor(.regBrown)

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
                        .padding()
                        .background(.white)
                        .cornerRadius(20)

                        VStack(spacing: 18) {
                            
                            TextField(
                                "Title",
                                text: $title
                            )
                            
                            TextField(
                                "Brand",
                                text: $brand
                            )
                            
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
                            
                            TextField(
                                "Description",
                                text: $description,
                                axis: .vertical
                            )
                            .lineLimit(4)
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(20)

                        if listingType == "Sell" {

                            VStack(alignment: .leading) {

                                Text("Price")
                                    .font(.headline)
                                    .foregroundColor(.regBrown)

                                TextField(
                                    "Selling Price",
                                    text: $price
                                )
                                .keyboardType(.numberPad)

                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(20)
                        }

                        if listingType == "Rent" {

                            VStack(spacing: 18) {

                                TextField(
                                    "Rental Duration (Days)",
                                    text: $rentalDuration
                                )
                                .keyboardType(.numberPad)

                                TextField(
                                    "Rental Price Per Day",
                                    text: $rentalPrice
                                )
                                .keyboardType(.numberPad)

                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(20)
                        }

                        VStack(alignment: .leading) {

                            Text("Seller Contact")
                                .font(.headline)
                                .foregroundColor(.regBrown)

                            TextField(
                                "WhatsApp (+Country Code)",
                                text: $whatsapp
                            )
                            .keyboardType(.phonePad)

                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(20)

                        Button {

                            validateListing()

                        } label: {

                            Text(
                                isUploading
                                ?
                                "Publishing..."
                                :
                                "Publish Listing"
                            )
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                isUploading
                                ?
                                Color.gray.opacity(0.4)
                                :
                                Color.regBlue
                            )
                            .foregroundColor(.regBrown)
                            .cornerRadius(18)
                        }
                        .disabled(isUploading)
                    }
                    .padding()
                }

                if isUploading {

                    ZStack {

                        Color.black
                            .opacity(0.2)
                            .ignoresSafeArea()

                        VStack(spacing: 18) {

                            ProgressView()
                                .tint(.regBrown)
                                .scaleEffect(1.8)

                            Text("Uploading...")
                                .foregroundColor(.regBrown)
                                .fontWeight(.semibold)

                        }
                        .padding(35)
                        .background(Color.regYellow)
                        .cornerRadius(24)
                    }
                }
            }
            .navigationTitle("Upload Listing")

            .alert(
                "Listing Published",
                isPresented: $showSuccessAlert
            ) {

                Button("Done") { }

            } message: {

                Text("Your listing is now live.")
            }

            .alert(
                "Missing Information",
                isPresented: $showValidationAlert
            ) {

                Button("OK") { }

            } message: {

                Text(validationMessage)
            }
        }
    }
    func validateListing() {

        if selectedImages.isEmpty {

            validationMessage =
            "Please upload at least one image."

            showValidationAlert = true
            return
        }

        if title.trimmingCharacters(
            in: .whitespaces
        ).isEmpty {

            validationMessage =
            "Please enter a title."

            showValidationAlert = true
            return
        }

        if brand.trimmingCharacters(
            in: .whitespaces
        ).isEmpty {

            validationMessage =
            "Please enter a brand."

            showValidationAlert = true
            return
        }

        if description.trimmingCharacters(
            in: .whitespaces
        ).isEmpty {

            validationMessage =
            "Please enter a description."

            showValidationAlert = true
            return
        }

        if whatsapp.trimmingCharacters(
            in: .whitespaces
        ).isEmpty {

            validationMessage =
            "Please enter your WhatsApp number with country code."

            showValidationAlert = true
            return
        }

        if listingType == "Sell" {

            if Int(price) == nil {

                validationMessage =
                "Please enter a valid selling price."

                showValidationAlert = true
                return
            }

        } else {

            if Int(rentalPrice) == nil {

                validationMessage =
                "Please enter a rental price."

                showValidationAlert = true
                return
            }

            if Int(rentalDuration) == nil {

                validationMessage =
                "Please enter rental duration."

                showValidationAlert = true
                return
            }
        }

        uploadListing()
    }

    func uploadListing() {

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

                sellerName: "Shivanshi",

                sellerWhatsApp: whatsapp
            )

            clearForm()

            isUploading = false

            showSuccessAlert = true
        }
    }

    func clearForm() {

        title = ""

        brand = ""

        description = ""

        price = ""

        rentalPrice = ""

        rentalDuration = ""

        whatsapp = "+91"

        selectedImages.removeAll()

        listingType = "Sell"

        selectedCategory = "Tops"

        selectedSize = "M"

        selectedCondition = "Like New"
    }
}

#Preview {

    UploadScreen()
}
