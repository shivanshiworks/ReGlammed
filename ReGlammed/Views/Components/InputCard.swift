//
//  InputCard.swift
//  ReGlammed
//
//  Created by Rashmi Priyadarshi on 25/06/26.
//

import SwiftUI

struct InputCard<Content: View>: View {

    let title: String

    @ViewBuilder
    let content: Content

    init(
        title: String,
        @ViewBuilder content: () -> Content
    ) {

        self.title = title
        self.content = content()
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 14) {

            Text(title)
                .font(.headline)
                .foregroundColor(.regBrown)

            content
        }
        .padding(18)
        .background(Color.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 22
            )
        )
        .shadow(
            color: .black.opacity(0.05),
            radius: 8,
            x: 0,
            y: 4
        )
    }
}

#Preview {

    ZStack {

        Color.regCream
            .ignoresSafeArea()

        InputCard(title: "Basic Information") {

            TextField(
                "Title",
                text: .constant("")
            )

            Divider()

            TextField(
                "Brand",
                text: .constant("")
            )
        }
        .padding()
    }
}
