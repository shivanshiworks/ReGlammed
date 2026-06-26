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

            SplashRootView()
                .environmentObject(authManager)
        }
    }
}
