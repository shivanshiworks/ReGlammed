import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

class UserManager: ObservableObject {

    @Published var userProfile: UserProfile?

    private let db = Firestore.firestore()

    func createUserIfNeeded() {

        print("CREATE USER CALLED")

        guard let user = Auth.auth().currentUser else {
            print("NO CURRENT USER")
            return
        }

        print("USER FOUND:", user.email ?? "")

        let userRef = db.collection("users").document(user.uid)

        userRef.getDocument { snapshot, error in

            if let snapshot = snapshot,
               snapshot.exists {

                print("USER ALREADY EXISTS")

                self.fetchUser()
                return
            }

            print("CREATING FIRESTORE USER")

            userRef.setData([
                "name": user.displayName ?? "",
                "email": user.email ?? "",
                "whatsapp": "",
                "whatsappVerified": false
            ]) { error in

                if let error = error {
                    print("FIRESTORE ERROR:", error.localizedDescription)
                } else {
                    print("USER CREATED SUCCESSFULLY")
                }

                self.fetchUser()
            }
        }
    }

    func fetchUser() {

        guard let user = Auth.auth().currentUser else {
            return
        }

        db.collection("users")
            .document(user.uid)
            .getDocument { snapshot, error in

                guard let data = snapshot?.data() else {
                    return
                }

                self.userProfile = UserProfile(
                    id: user.uid,
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    whatsapp: data["whatsapp"] as? String ?? "",
                    whatsappVerified: data["whatsappVerified"] as? Bool ?? false
                )
            }
    }

    func saveWhatsApp(
        number: String,
        verified: Bool
    ) {

        guard let user = Auth.auth().currentUser else {
            return
        }

        db.collection("users")
            .document(user.uid)
            .updateData([
                "whatsapp": number,
                "whatsappVerified": verified
            ])
    }
}
