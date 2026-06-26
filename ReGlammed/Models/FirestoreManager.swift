import Foundation
import Combine
import FirebaseFirestore

class FirestoreManager: ObservableObject {

    @Published var listings: [Listing] = []

    private let db = Firestore.firestore()

    func addListing(
        title: String,
        brand: String,
        category: String,
        size: String,
        condition: String,
        description: String,
        type: String,
        price: Int?,
        rentalPrice: Int?,
        rentalDuration: Int?,
        imageURLs: [String],
        sellerID: String,
        sellerName: String,
        sellerWhatsApp: String
    ) {

        db.collection("listings").addDocument(
            data: [

                "title": title,
                "brand": brand,

                "category": category,
                "size": size,
                "condition": condition,

                "description": description,

                "type": type,

                "price": price as Any,

                "rentalPrice": rentalPrice as Any,
                "rentalDuration": rentalDuration as Any,

                "imageURLs": imageURLs,
                "SellerID": sellerID,
                "sellerName": sellerName,
                "sellerWhatsApp": sellerWhatsApp,

                "createdAt": Timestamp()
            ]
        )
    }

    func fetchListings() {

        db.collection("listings")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener { snapshot, error in

                guard let documents = snapshot?.documents else {
                    return
                }

                self.listings = documents.compactMap { document in

                    let data = document.data()

                    return Listing(

                        id: document.documentID,

                        title: data["title"] as? String ?? "",
                        brand: data["brand"] as? String ?? "",

                        category: data["category"] as? String ?? "",
                        size: data["size"] as? String ?? "",
                        condition: data["condition"] as? String ?? "",

                        description: data["description"] as? String ?? "",

                        type: data["type"] as? String ?? "",
                        sellerID: data["sellerID"] as? String ?? "",
                        price: data["price"] as? Int,

                        rentalPrice: data["rentalPrice"] as? Int,
                        rentalDuration: data["rentalDuration"] as? Int,

                        imageURLs: data["imageURLs"] as? [String] ?? [],

                        sellerName: data["sellerName"] as? String ?? "",
                        
                        sellerWhatsApp: data["sellerWhatsApp"] as? String ?? "",

                        createdAt:
                            (data["createdAt"] as? Timestamp)?
                            .dateValue() ?? Date()
                    )
                }
            }
    }

    func deleteListing(
        id: String
    ) {

        db.collection("listings")
            .document(id)
            .delete()
    }
    func updateListing(
        listing: Listing
    ) {

        db.collection("listings")
            .document(listing.id)
            .updateData([

                "title": listing.title,

                "brand": listing.brand,

                "category": listing.category,

                "size": listing.size,

                "condition": listing.condition,

                "description": listing.description,

                "price": listing.price as Any,

                "rentalPrice": listing.rentalPrice as Any,

                "rentalDuration": listing.rentalDuration as Any
            ])
    }
}
