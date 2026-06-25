import Foundation
import FirebaseAuth

class PhoneAuthManager {

    static let shared = PhoneAuthManager()

    private init() {}

    var verificationID: String?

    func sendOTP(
        phoneNumber: String,
        completion: @escaping (Bool) -> Void
    ) {

        print("STARTING OTP FOR:", phoneNumber)

        PhoneAuthProvider.provider()
            .verifyPhoneNumber(
                phoneNumber,
                uiDelegate: nil
            ) { verificationID, error in

                if let error = error {

                    print("OTP ERROR:")
                    print(error)
                    print(error.localizedDescription)

                    completion(false)

                    return
                }

                print("VERIFICATION ID:")
                print(verificationID ?? "nil")

                self.verificationID = verificationID

                completion(true)
            }
    }

    func verifyOTP(
        code: String,
        completion: @escaping (Bool) -> Void
    ) {

        guard let verificationID = verificationID else {

            print("NO VERIFICATION ID")

            completion(false)

            return
        }

        let credential = PhoneAuthProvider.provider()
            .credential(
                withVerificationID: verificationID,
                verificationCode: code
            )

        print("OTP VERIFIED")

        completion(
            credential.provider == "phone"
        )
    }
}
