//
//  PrimaryButton.swift
//  ReGlammed
//
//  Created by Rashmi Priyadarshi on 25/06/26.
//

import SwiftUI

struct PrimaryButton: View {

    let title: String
    let color: Color
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.regBrown)
                .frame(maxWidth: .infinity)
                .frame(height: 58)
                .background(color)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 18
                    )
                )
                .shadow(
                    color: .black.opacity(0.08),
                    radius: 8,
                    x: 0,
                    y: 4
                )
        }
        .buttonStyle(.plain)
        .scaleEffect(1)
        .animation(
            .easeInOut(duration: 0.2),
            value: UUID()
        )
    }
}

#Preview {

    ZStack {

        Color.regCream
            .ignoresSafeArea()

        VStack(spacing: 20) {

            PrimaryButton(
                title: "Continue",
                color: .regBlue
            ) {

            }

            PrimaryButton(
                title: "Publish Listing",
                color: .regYellow
            ) {

            }
        }
        .padding()
    }
}
