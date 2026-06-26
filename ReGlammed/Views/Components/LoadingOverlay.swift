//
//  LoadingOverlay.swift
//  ReGlammed
//
//  Created by Rashmi Priyadarshi on 25/06/26.
//

import SwiftUI

struct LoadingOverlay: View {

    let message: String

    var body: some View {

        ZStack {

            Color.black
                .opacity(0.18)
                .ignoresSafeArea()

            VStack(spacing: 22) {

                ZStack {

                    Circle()
                        .fill(Color.regYellow)
                        .frame(width: 80, height: 80)

                    ProgressView()
                        .tint(.regBrown)
                        .scaleEffect(2)
                }

                Text(message)
                    .font(.headline)
                    .foregroundColor(.regBrown)
            }
            .padding(.horizontal, 36)
            .padding(.vertical, 30)
            .background(Color.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 28)
            )
            .shadow(
                color: .black.opacity(0.12),
                radius: 20,
                x: 0,
                y: 10
            )
        }
    }
}

#Preview {

    LoadingOverlay(
        message: "Uploading..."
    )
}
