import Foundation
import Combine

class SavedCartManager: ObservableObject {

    @Published var savedListingIDs: [String] = []

    private let key = "savedListingIDs"

    init() {

        loadSavedItems()
    }

    func toggleSaved(
        listingID: String
    ) {

        if savedListingIDs.contains(listingID) {

            savedListingIDs.removeAll {
                $0 == listingID
            }

        } else {

            savedListingIDs.append(listingID)
        }

        saveItems()
    }

    func isSaved(
        listingID: String
    ) -> Bool {

        savedListingIDs.contains(
            listingID
        )
    }

    private func saveItems() {

        UserDefaults.standard.set(
            savedListingIDs,
            forKey: key
        )
    }

    private func loadSavedItems() {

        savedListingIDs =
            UserDefaults.standard.stringArray(
                forKey: key
            ) ?? []
    }
}
