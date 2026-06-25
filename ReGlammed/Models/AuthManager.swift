import Foundation
import Combine
import UIKit
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class AuthManager: ObservableObject {

    @Published var isLoggedIn = false

    init() {
        checkUser()
    }

    func checkUser() {
        isLoggedIn = Auth.auth().currentUser != nil
    }

    func signInWithGoogle() {

        guard let clientID = FirebaseApp.app()?.options.clientID else {
            return
        }

        let config = GIDConfiguration(clientID: clientID)

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }

        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in

            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                return
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )

            Auth.auth().signIn(with: credential) { result, error in

                if let error = error {
                    print("FIREBASE LOGIN ERROR:", error.localizedDescription)
                    return
                }

                let userManager = UserManager()
                userManager.createUserIfNeeded()

                DispatchQueue.main.async {
                    self.isLoggedIn = true
                }
            }
        }
    }

    func signOut() {

        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()

            DispatchQueue.main.async {
                self.isLoggedIn = false
            }

        } catch {
            print(error.localizedDescription)
        }
    }
}
