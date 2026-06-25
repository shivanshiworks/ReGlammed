import UIKit
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        print("APP DELEGATE LOADED")

        return true
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {

        Auth.auth().setAPNSToken(deviceToken, type: .unknown)

        print("APNS TOKEN REGISTERED")
    }

    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {

        if Auth.auth().canHandleNotification(userInfo) {

            print("FIREBASE HANDLED NOTIFICATION")

            completionHandler(.noData)

            return
        }

        completionHandler(.newData)
    }
}
