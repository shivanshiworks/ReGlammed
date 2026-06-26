import SwiftUI
import FirebaseAuth

struct ProfileScreen: View {

    @StateObject private var userManager = UserManager()

    @State private var whatsapp = ""
    @State private var otp = ""

    @State private var otpSent = false

    @State private var showSuccessAlert = false
    @State private var showFailureAlert = false

    @State private var showLogoutAlert = false

    var body: some View {

        NavigationStack {

            ZStack {

                LinearGradient(

                    colors: [

                        Color.regCream,

                        Color.regBlue.opacity(0.15)

                    ],

                    startPoint: .top,

                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {

                    VStack(spacing: 28) {
                        
                        // MARK: Profile Header
                        
                        ZStack {
                            
                            RoundedRectangle(
                                cornerRadius: 32
                            )
                            .fill(Color.white)
                            
                            VStack(spacing: 18) {
                                
                                ZStack {
                                    
                                    Circle()
                                        .fill(Color.regBlue)
                                        .frame(
                                            width: 120,
                                            height: 120
                                        )
                                    
                                    Circle()
                                        .stroke(
                                            Color.regYellow,
                                            lineWidth: 6
                                        )
                                        .frame(
                                            width: 128,
                                            height: 128
                                        )
                                    
                                    Image(systemName: "person.fill")
                                        .font(
                                            .system(size: 48)
                                        )
                                        .foregroundColor(.regBrown)
                                }
                                
                                Text(
                                    userManager.userProfile?.name ??
                                    "Loading..."
                                )
                                .font(
                                    .system(
                                        size: 28,
                                        weight: .bold
                                    )
                                )
                                .foregroundColor(.regBrown)
                                
                                Text(
                                    userManager.userProfile?.email ??
                                    ""
                                )
                                .foregroundColor(.gray)
                                
                                HStack(spacing: 8) {
                                    
                                    Image(
                                        systemName:
                                            userManager.userProfile?.whatsappVerified == true
                                        ?
                                        "checkmark.seal.fill"
                                        :
                                            "clock.fill"
                                    )
                                    
                                    Text(
                                        
                                        userManager.userProfile?.whatsappVerified == true
                                        ?
                                        
                                        "Verified Seller"
                                        
                                        :
                                            
                                            "Verification Pending"
                                    )
                                }
                                .font(.subheadline.bold())
                                .foregroundColor(.regBrown)
                                .padding(.horizontal,18)
                                .padding(.vertical,8)
                                .background(Color.regYellow)
                                .clipShape(Capsule())
                            }
                            .padding(.vertical,30)
                        }
                        .shadow(
                            color:.black.opacity(0.08),
                            radius:18,
                            x:0,
                            y:10
                        )
                        // MARK: Quick Actions
                        
                        VStack(spacing: 16) {
                            
                            NavigationLink {
                                
                                MyListingsScreen()
                                
                            } label: {
                                
                                premiumRow(
                                    
                                    title: "My Listings",
                                    
                                    subtitle: "Manage your uploaded items",
                                    
                                    icon: "square.grid.2x2.fill",
                                    
                                    color: .regBlue
                                )
                            }
                            
                            NavigationLink {
                                
                                SavedCartScreen()
                                
                            } label: {
                                
                                premiumRow(
                                    
                                    title: "Saved Cart",
                                    
                                    subtitle: "View saved favourites",
                                    
                                    icon: "bag.fill",
                                    
                                    color: .regYellow
                                )
                            }
                            
                            NavigationLink {
                                
                                EditProfileScreen()
                                
                            } label: {
                                
                                premiumRow(
                                    
                                    title: "Edit Profile",
                                    
                                    subtitle: "Update your information",
                                    
                                    icon: "person.crop.circle",
                                    
                                    color: .regBlue
                                )
                            }
                        }
                        
                        // MARK: Verification
                        
                        InputCard(
                            title: "WhatsApp Verification"
                        ) {
                            
                            Text(
                                "Enter your WhatsApp number with country code."
                            )
                            .foregroundColor(.gray)
                            
                            TextField(
                                "+91XXXXXXXXXX",
                                text: $whatsapp
                            )
                            .keyboardType(.phonePad)
                            
                            Divider()
                            
                            PrimaryButton(
                                
                                title: "Send OTP",
                                
                                color: .regBlue
                                
                            ) {
                                
                                PhoneAuthManager.shared.sendOTP(
                                    phoneNumber: whatsapp
                                ) { success in
                                    
                                    DispatchQueue.main.async {
                                        
                                        if success {
                                            
                                            otpSent = true
                                        }
                                    }
                                }
                            }
                            
                            if otpSent {
                                
                                Divider()
                                
                                TextField(
                                    "Enter OTP",
                                    text: $otp
                                )
                                .keyboardType(.numberPad)
                                
                                Divider()
                                
                                PrimaryButton(
                                    
                                    title: "Verify",
                                    
                                    color: .regYellow
                                    
                                ) {
                                    
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
                                }
                            }
                        }
                        // MARK: Logout

                        PrimaryButton(

                            title: "Logout",

                            color: Color.red.opacity(0.18)

                        ) {

                            showLogoutAlert = true
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
                "Logout?",
                isPresented: $showLogoutAlert
            ) {

                Button(
                    "Logout",
                    role: .destructive
                ) {

                    try? Auth.auth().signOut()
                }

                Button(
                    "Cancel",
                    role: .cancel
                ) { }

            } message: {

                Text(
                    "You'll need to sign in again to continue."
                )
            }

            .alert(
                "Verification Successful",
                isPresented: $showSuccessAlert
            ) {

                Button("OK") { }

            } message: {

                Text(
                    "Your WhatsApp number has been verified."
                )
            }

            .alert(
                "Verification Failed",
                isPresented: $showFailureAlert
            ) {

                Button("OK") { }

            } message: {

                Text(
                    "Incorrect OTP. Please try again."
                )
            }
        }
    }

    @ViewBuilder

    func premiumRow(

        title: String,

        subtitle: String,

        icon: String,

        color: Color

    ) -> some View {

        HStack(spacing: 18) {

            ZStack {

                RoundedRectangle(
                    cornerRadius: 14
                )
                .fill(color)
                .frame(
                    width: 54,
                    height: 54
                )

                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(.regBrown)
            }

            VStack(
                alignment: .leading,
                spacing: 4
            ) {

                Text(title)
                    .font(.headline)
                    .foregroundColor(.regBrown)

                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 22
            )
        )
        .shadow(
            color: .black.opacity(0.05),
            radius: 10,
            x: 0,
            y: 5
        )
    }
}
#Preview {

    NavigationStack {

        ProfileScreen()
    }
}
