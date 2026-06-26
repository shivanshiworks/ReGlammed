import SwiftUI

struct ProductCard: View {

    let title: String
    let brand: String
    let price: Int
    let badge: String

    var imageURL: String? = nil

    @State private var isPressed = false
    @State private var saved = false

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {

            ZStack(alignment: .top) {

                if let imageURL,
                   let url = URL(string: imageURL) {

                    AsyncImage(url: url) { image in

                        image
                            .resizable()
                            .scaledToFill()

                    } placeholder: {

                        Rectangle()
                            .fill(Color.regBlue.opacity(0.35))
                    }

                } else {

                    Rectangle()
                        .fill(Color.regBlue.opacity(0.35))

                        .overlay {

                            Image(systemName: "hanger")

                                .font(.system(size: 44))

                                .foregroundColor(.regBrown.opacity(0.45))
                        }
                }

                LinearGradient(

                    colors: [

                        .clear,

                        Color.black.opacity(0.12)

                    ],

                    startPoint: .center,

                    endPoint: .bottom
                )

                HStack {

                    Text(badge)

                        .font(.caption2)

                        .fontWeight(.bold)

                        .foregroundColor(.regBrown)

                        .padding(.horizontal,12)

                        .padding(.vertical,7)

                        .background(Color.regYellow)

                        .clipShape(Capsule())

                    Spacer()

                    Button {

                        withAnimation(
                            .spring(
                                response:0.35,
                                dampingFraction:0.6
                            )
                        ) {

                            saved.toggle()
                        }

                    } label: {

                        Image(

                            systemName:

                            saved

                            ?

                            "heart.fill"

                            :

                            "heart"
                        )

                        .font(.title3)

                        .foregroundColor(

                            saved

                            ?

                            .pink

                            :

                            .white
                        )

                        .symbolEffect(
                            .bounce,
                            value: saved
                        )
                    }
                }
                .padding(16)

                VStack {

                    Spacer()

                    HStack {

                        Spacer()

                        Circle()

                            .fill(.white.opacity(0.9))

                            .frame(width: 42,height:42)

                            .overlay {

                                Image(systemName:"arrow.up.right")

                                    .foregroundColor(.regBrown)
                            }
                    }
                    .padding(16)
                }
            }
            .frame(height:285)
            .clipShape(
                RoundedRectangle(
                    cornerRadius:30
                )
            )

            VStack(alignment:.leading,spacing:8) {

                Text(title)

                    .font(
                        .system(
                            size:20,
                            weight:.bold
                        )
                    )

                    .foregroundColor(.regBrown)

                    .lineLimit(2)

                Text(brand)

                    .font(.subheadline)

                    .foregroundColor(.gray)

                HStack {

                    Text("₹\(price)")

                        .font(
                            .system(
                                size:24,
                                weight:.black
                            )
                        )

                        .foregroundColor(.regBrown)

                    Spacer()

                    Text("View")

                        .font(.caption)

                        .fontWeight(.bold)

                        .foregroundColor(.regBrown)
                }
            }
            .padding(18)
        }
        .background(.white)

        .clipShape(
            RoundedRectangle(
                cornerRadius:30
            )
        )

        .shadow(

            color:.black.opacity(0.08),

            radius:20,

            x:0,

            y:12
        )

        .scaleEffect(
            isPressed
            ? 0.97
            : 1
        )

        .animation(
            .spring(
                response:0.35,
                dampingFraction:0.7
            ),
            value:isPressed
        )

        .onLongPressGesture(
            minimumDuration:0,
            pressing:{ pressing in

                isPressed = pressing

            },
            perform:{}
        )
    }
}

#Preview {

    ZStack {

        Color.regCream
            .ignoresSafeArea()

        ProductCard(

            title:"Zara Satin Dress",

            brand:"Zara",

            price:1899,

            badge:"SELL"
        )
        .padding()
    }
}
