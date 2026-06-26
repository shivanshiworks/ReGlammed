//
//  EditProfileScreen.swift
//  ReGlammed
//
//  Created by Rashmi Priyadarshi on 25/06/26.
//

import SwiftUI

struct EditProfileScreen: View {

    var body: some View {

        ZStack {

            Color.regCream
                .ignoresSafeArea()

            VStack(spacing: 24) {

                Image(systemName: "person.crop.circle")
                    .font(.system(size: 70))
                    .foregroundColor(.regBlue)

                Text("Edit Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.regBrown)

                Text("Coming Soon")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {

    NavigationStack {

        EditProfileScreen()
    }
}
