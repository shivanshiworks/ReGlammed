import SwiftUI
import FirebaseAuth

struct ProfileScreen: View {

    @StateObject private var userManager = UserManager()

    @State private var whatsapp = ""
    @State private var otp = ""

    @State private var otpSent = false

    @State private var showSuccessAlert = false
    @State private var showFailureAlert = false

    var body: some View {

        NavigationStack {

            ZStack {

                Color.regCream
                    .ignoresSafeArea()

                ScrollView {

                    VStack(spacing: 24) {

                        VStack(spacing: 14) {

                            Circle()
                                .fill(Color.regBlue)
                                .frame(width: 110, height: 110)
                                .overlay {

                                    Image(systemName: "person.fill")
                                        .font(.system(size: 45))
                                        .foregroundColor(.regBrown)
                                }

                            Text(
                                userManager.userProfile?.name ??
                                "Loading..."
                            )
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.regBrown)

                            Text(
                                userManager.userProfile?.email ??
                                ""
                            )
                            .foregroundColor(.gray)
                        }

                        VStack(spacing: 16) {

                            NavigationLink {

                                MyListingsScreen()

                            } label: {

                                profileRow(
                                    title: "My Listings",
                                    icon: "square.grid.2x2.fill"
                                )
                            }

                            NavigationLink {

                                SavedCartScreen()

                            } label: {

                                profileRow(
                                    title: "Saved Cart",
                                    icon: "bag.fill"
                                )
                            }

                            Button {

                            } label: {

                                profileRow(
                                    title: "Edit Profile",
                                    icon: "pencil"
                                )
                            }
                            .buttonStyle(.plain)
                        }

                        VStack(alignment: .leading, spacing: 18) {

                            Text("Account Verification")
                                .font(.headline)
                                .foregroundColor(.regBrown)

                            TextField(
                                "WhatsApp (+Country Code)",
                                text: $whatsapp
                            )
                            .keyboardType(.phonePad)
                            .padding()
                            .background(.white)
                            .cornerRadius(14)

                            Button {

                                print("SEND OTP CLICKED")

                                PhoneAuthManager.shared.sendOTP(
                                    phoneNumber: whatsapp
                                ) { success in

                                    DispatchQueue.main.async {

                                        if success {

                                            otpSent = true
                                        }
                                    }
                                }

                            } label: {

                                Text("Send OTP")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.regBlue)
                                    .foregroundColor(.regBrown)
                                    .cornerRadius(14)
                            }

                            if otpSent {

                                TextField(
                                    "Enter OTP",
                                    text: $otp
                                )
                                .keyboardType(.numberPad)
                                .padding()
                                .background(.white)
                                .cornerRadius(14)

                                Button {

                                    PhoneAuthManager.shared.verifyOTP(
                                        code: otp
                                    ) { success in

                                        DispatchQueue.main.async {

                                            if success {

                                                userManager.saveWhatsApp(
                                                    number: whatsapp,
                                                    verified: true
                                                )

                                                userManager.fetchUser()

                                                showSuccessAlert = true

                                            } else {

                                                showFailureAlert = true
                                            }
                                        }
                                    }

                                } label: {

                                    Text("Verify OTP")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.regYellow)
                                        .foregroundColor(.regBrown)
                                        .cornerRadius(14)
                                }
                            }

                            HStack {

                                Circle()
                                    .fill(
                                        userManager.userProfile?.whatsappVerified == true
                                        ? Color.green
                                        : Color.red
                                    )
                                    .frame(width: 10)

                                Text(
                                    userManager.userProfile?.whatsappVerified == true
                                    ?
                                    "Verified Seller"
                                    :
                                    "Not Verified"
                                )
                            }
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(22)

                        Button {

                            try? Auth.auth().signOut()

                        } label: {

                            Text("Logout")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red.opacity(0.12))
                                .foregroundColor(.red)
                                .cornerRadius(16)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)

            .onAppear {

                userManager.fetchUser()

                DispatchQueue.main.asyncAfter(
                    deadline: .now() + 0.5
                ) {

                    if let savedNumber =
                        userManager.userProfile?.whatsapp {

                        whatsapp = savedNumber
                    }
                }
            }

            .alert(
                "Verification Successful",
                isPresented: $showSuccessAlert
            ) {

                Button("OK") { }

            } message: {

                Text("WhatsApp verified.")
            }

            .alert(
                "Verification Failed",
                isPresented: $showFailureAlert
            ) {

                Button("OK") { }

            } message: {

                Text("Incorrect OTP.")
            }
        }
    }

    @ViewBuilder

    func profileRow(
        title: String,
        icon: String
    ) -> some View {

        HStack {

            Image(systemName: icon)
                .foregroundColor(.regBrown)
                .frame(width: 28)

            Text(title)
                .foregroundColor(.regBrown)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(.white)
        .cornerRadius(18)
    }
}

#Preview {

    ProfileScreen()
}
