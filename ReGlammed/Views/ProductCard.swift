import SwiftUI

struct ProductCard: View {

    let title: String
    let brand: String
    let price: Int
    let badge: String

    var imageURL: String? = nil

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            if let imageURL,
               let url = URL(string: imageURL) {

                AsyncImage(url: url) { image in

                    image
                        .resizable()
                        .scaledToFill()

                } placeholder: {

                    Rectangle()
                        .fill(Color.regBlue)
                }
                .frame(height: 220)
                .clipped()
                .cornerRadius(16)

            } else {

                Rectangle()
                    .fill(Color.regBlue)
                    .frame(height: 220)
                    .cornerRadius(16)
                    .overlay {

                        Image(systemName: "hanger")
                            .font(.system(size: 40))
                            .foregroundColor(
                                .regBrown.opacity(0.5)
                            )
                    }
            }

            HStack {

                Text(badge)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.regYellow)
                    .cornerRadius(8)

                Spacer()
            }

            Text(title)
                .font(.headline)
                .foregroundColor(.regBrown)

            Text(brand)
                .foregroundColor(
                    .regBrown.opacity(0.7)
                )

            Text("₹\(price)")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.regBrown)
        }
        .padding()
        .background(.white)
        .cornerRadius(20)
        .shadow(
            color: .black.opacity(0.05),
            radius: 10,
            x: 0,
            y: 4
        )
    }
}

#Preview {

    ZStack {

        Color.regCream
            .ignoresSafeArea()

        ProductCard(
            title: "Zara Black Dress",
            brand: "Zara",
            price: 1200,
            badge: "SELL"
        )
        .padding()
    }
}
