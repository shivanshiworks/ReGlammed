import Foundation

struct Listing: Identifiable {

    let id: String

    let title: String
    let brand: String

    let category: String
    let size: String
    let condition: String

    let description: String

    let type: String

    let price: Int?

    let rentalPrice: Int?
    let rentalDuration: Int?

    let imageURLs: [String]

    let sellerName: String
    let sellerWhatsApp: String

    let createdAt: Date
}
