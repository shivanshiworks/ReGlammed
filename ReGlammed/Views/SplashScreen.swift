//
//  SplashScreen.swift
//  ReGlammed
//
//  Created by Rashmi Priyadarshi on 22/06/26.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {

            Color.regYellow
                .ignoresSafeArea()

            VStack(spacing: 12) {

                Text("ReGlammed")
                    .font(.system(size: 52, weight: .black))
                    .foregroundColor(.regBrown)


                Divider()
                    .frame(width: 100)

                Text("See it? Like it? Want it?")
                    .foregroundColor(.regBrown.opacity(0.7))

                Text("ReGlam it.")
                    .foregroundColor(.regBrown.opacity(0.7))
            }
        }
    }
}

#Preview {
    SplashScreen()
}
