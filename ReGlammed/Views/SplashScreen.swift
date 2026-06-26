import SwiftUI

struct SplashScreen: View {

    @State private var logoScale: CGFloat = 0.75
    @State private var logoOpacity: Double = 0
    @State private var subtitleOpacity: Double = 0
    @State private var lineWidth: CGFloat = 0
    @State private var glow = false

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [
                    Color.regCream,
                    Color.regBlue.opacity(0.22),
                    Color.regCream
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            Circle()
                .fill(Color.regYellow.opacity(0.25))
                .frame(width: 360, height: 360)
                .blur(radius: glow ? 70 : 40)
                .scaleEffect(glow ? 1.1 : 0.9)

            Circle()
                .fill(Color.regBlue.opacity(0.15))
                .frame(width: 240, height: 240)
                .offset(x: 130, y: -220)
                .blur(radius: 50)

            Circle()
                .fill(Color.regYellow.opacity(0.15))
                .frame(width: 220, height: 220)
                .offset(x: -120, y: 260)
                .blur(radius: 50)

            VStack(spacing: 28) {

                ZStack {

                    Circle()
                        .fill(.white)
                        .frame(width: 145, height: 145)
                        .shadow(
                            color: .black.opacity(0.08),
                            radius: 20,
                            x: 0,
                            y: 10
                        )

                    Circle()
                        .stroke(
                            Color.regYellow,
                            lineWidth: 5
                        )
                        .frame(width: 160, height: 160)

                    Image(systemName: "hanger")
                        .font(.system(size: 62))
                        .foregroundColor(.regBrown)

                }
                .scaleEffect(logoScale)
                .opacity(logoOpacity)

                Text("ReGlammed")
                    .font(.luxury(42))
                    .foregroundColor(.regBrown)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)

                Capsule()
                    .fill(Color.regYellow)
                    .frame(width: lineWidth, height: 5)

                VStack(spacing: 8) {

                    Text("See it? Like it? Want it?")
                        .font(.accent(28))

                    Text("ReGlam it.")
                        .font(.accent(28))
                        .fontWeight(.bold)
                }
                .foregroundColor(.regBrown.opacity(0.75))
                .opacity(subtitleOpacity)

            }
            .padding(.horizontal, 30)

        }
        .onAppear {

            withAnimation(
                .easeInOut(duration: 3)
                .repeatForever(autoreverses: true)
            ) {
                glow.toggle()
            }

            withAnimation(
                .spring(
                    response: 0.8,
                    dampingFraction: 0.75
                )
            ) {

                logoScale = 1.0
                logoOpacity = 1.0
            }

            withAnimation(
                .easeOut(duration: 0.9)
                .delay(0.5)
            ) {

                lineWidth = 160
            }

            withAnimation(
                .easeIn(duration: 1)
                .delay(1.0)
            ) {

                subtitleOpacity = 1.0
            }
        }
    }
}

#Preview {

    SplashScreen()
}
