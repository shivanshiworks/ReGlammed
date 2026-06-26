//
//  SplashRootView.swift
//  ReGlammed
//
//  Created by Rashmi Priyadarshi on 25/06/26.
//

import SwiftUI

struct SplashRootView: View {

    @EnvironmentObject var authManager: AuthManager

    @State private var showSplash = true

    var body: some View {

        Group {

            if showSplash {

                SplashScreen()

            } else {

                if authManager.isLoggedIn {

                    MainTabView()

                } else {

                    LoginScreen()
                }
            }
        }
        .onAppear {

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

                withAnimation(.easeInOut) {

                    showSplash = false
                }
            }
        }
    }
}

#Preview {

    SplashRootView()
        .environmentObject(AuthManager())
}
