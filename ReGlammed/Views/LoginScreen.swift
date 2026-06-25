import SwiftUI

struct LoginScreen: View {

    @EnvironmentObject var authManager: AuthManager

    var body: some View {

        ZStack {

            Color.regCream
                .ignoresSafeArea()

            VStack(spacing: 24) {

                Spacer()

                Text("ReGlammed")
                    .font(.system(size: 42, weight: .bold))
                    .foregroundColor(.regBrown)

                Text("Fashion deserves another chance")
                    .foregroundColor(.regBrown.opacity(0.7))

                Button {

                    authManager.signInWithGoogle()

                } label: {

                    Text("Continue with Google")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.regBlue)
                        .foregroundColor(.regBrown)
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                Spacer()
            }
        }
    }
}

#Preview {
    LoginScreen()
        .environmentObject(AuthManager())
}
