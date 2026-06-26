//
//  SellerCard.swift
//  ReGlammed
//
//  Created by Rashmi Priyadarshi on 25/06/26.
//

import SwiftUI

struct SellerCard: View {

    let sellerName: String
    let sellerWhatsApp: String

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Text("Seller")

                .font(.headline)

                .foregroundColor(.regBrown)

            HStack(spacing: 16) {

                Circle()

                    .fill(Color.regBlue)

                    .frame(width: 60, height: 60)

                    .overlay {

                        Image(systemName: "person.fill")

                            .font(.title2)

                            .foregroundColor(.regBrown)
                    }

                VStack(alignment: .leading, spacing: 4) {

                    Text(sellerName)

                        .font(.headline)

                        .foregroundColor(.regBrown)

                    Text(sellerWhatsApp)

                        .foregroundColor(.gray)
                }

                Spacer()
            }
        }
        .padding()

        .background(Color.white)

        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )

        .shadow(
            color: .black.opacity(0.05),
            radius: 10,
            x: 0,
            y: 5
        )
    }
}

#Preview {

    ZStack {

        Color.regCream
            .ignoresSafeArea()

        SellerCard(

            sellerName: "Shivanshi",

            sellerWhatsApp: "+91 7483849515"
        )
        .padding()
    }
}
