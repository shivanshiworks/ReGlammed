import SwiftUI
import FirebaseCore

@main
struct ReGlammedApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate

    @StateObject private var authManager = AuthManager()

    init() {

        FirebaseApp.configure()

        UserManager().createUserIfNeeded()
    }

    var body: some Scene {

        WindowGroup {

            if authManager.isLoggedIn {

                MainTabView()
                    .environmentObject(authManager)

            } else {

                LoginScreen()
                    .environmentObject(authManager)
            }
        }
    }
}
