import SwiftUI

struct MainTabView: View {

    @State private var selectedTab = 0

    var body: some View {

        ZStack(alignment: .bottom) {

            Group {

                switch selectedTab {

                case 0:
                    NavigationStack {
                        HomeScreen()
                    }

                case 1:
                    NavigationStack {
                        BuyScreen()
                    }

                case 2:
                    NavigationStack {
                        UploadScreen()
                    }

                case 3:
                    NavigationStack {
                        RentScreen()
                    }

                default:
                    NavigationStack {
                        ProfileScreen()
                    }
                }
            }
            .transition(.opacity)

            HStack {

                tabButton(
                    icon: "house.fill",
                    index: 0
                )

                Spacer()

                tabButton(
                    icon: "bag.fill",
                    index: 1
                )

                Spacer()

                uploadButton()

                Spacer()

                tabButton(
                    icon: "hanger",
                    index: 3
                )

                Spacer()

                tabButton(
                    icon: "person.fill",
                    index: 4
                )

            }
            .padding(.horizontal,30)
            .padding(.vertical,14)
            .background(.white)
            .clipShape(Capsule())
            .shadow(
                color: .black.opacity(0.12),
                radius: 18,
                x: 0,
                y: 8
            )
            .padding(.horizontal,20)
            .padding(.bottom,18)
        }
    }

    @ViewBuilder

    func tabButton(
        icon: String,
        index: Int
    ) -> some View {

        Button {

            withAnimation(.spring()) {

                selectedTab = index
            }

        } label: {

            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(
                    selectedTab == index
                    ? .regBrown
                    : .gray
                )
                .frame(width:44,height:44)
                .scaleEffect(
                    selectedTab == index
                    ? 1.15
                    : 1
                )
        }
    }

    @ViewBuilder

    func uploadButton() -> some View {

        Button {

            withAnimation(.spring(
                response:0.35,
                dampingFraction:0.65
            )) {

                selectedTab = 2
            }

        } label: {

            ZStack {

                Circle()
                    .fill(Color.regBrown)
                    .frame(width:68,height:68)

                Circle()
                    .stroke(
                        Color.regYellow,
                        lineWidth:4
                    )
                    .frame(width:74,height:74)

                Image(systemName:"plus")
                    .font(.title2.bold())
                    .foregroundColor(.white)
            }
            .shadow(
                color:.black.opacity(0.2),
                radius:18,
                x:0,
                y:10
            )
            .offset(y:-24)
        }
    }
}

#Preview {

    MainTabView()
}
