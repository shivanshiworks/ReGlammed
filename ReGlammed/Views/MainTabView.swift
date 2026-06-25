import SwiftUI

struct MainTabView: View {

    @State private var selectedTab = 0

    init() {

        UITabBar.appearance().backgroundColor = UIColor.white

        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }

    var body: some View {

        TabView(selection: $selectedTab) {

            HomeScreen()
                .tabItem {

                    Image(systemName: "house.fill")

                    Text("Home")
                }
                .tag(0)

            BuyScreen()
                .tabItem {

                    Image(systemName: "bag.fill")

                    Text("Buy")
                }
                .tag(1)

            UploadScreen()
                .tabItem {

                    Image(systemName: "plus.circle.fill")

                    Text("Upload")
                }
                .tag(2)

            RentScreen()
                .tabItem {

                    Image(systemName: "hanger")

                    Text("Rent")
                }
                .tag(3)

            ProfileScreen()
                .tabItem {

                    Image(systemName: "person.fill")

                    Text("Profile")
                }
                .tag(4)
        }
        .tint(.regBrown)
    }
}

#Preview {

    MainTabView()
}
