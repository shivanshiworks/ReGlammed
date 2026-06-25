

import SwiftUI

struct FilterSheet: View {

    @Binding var selectedCategory: String
    @Binding var selectedSize: String
    @Binding var selectedBrand: String

    let categories: [String]
    let sizes: [String]
    let brands: [String]

    @Environment(\.dismiss) private var dismiss

    var body: some View {

        NavigationStack {

            Form {

                Section("Category") {

                    Picker(
                        "Category",
                        selection: $selectedCategory
                    ) {

                        Text("All")
                            .tag("")

                        ForEach(
                            categories,
                            id: \.self
                        ) {
                            Text($0)
                        }
                    }
                }

                Section("Size") {

                    Picker(
                        "Size",
                        selection: $selectedSize
                    ) {

                        Text("All")
                            .tag("")

                        ForEach(
                            sizes,
                            id: \.self
                        ) {
                            Text($0)
                        }
                    }
                }

                Section("Brand") {

                    Picker(
                        "Brand",
                        selection: $selectedBrand
                    ) {

                        Text("All")
                            .tag("")

                        ForEach(
                            brands,
                            id: \.self
                        ) {
                            Text($0)
                        }
                    }
                }
            }
            .navigationTitle("Filters")
            .toolbar {

                ToolbarItem(
                    placement: .topBarLeading
                ) {

                    Button("Clear") {

                        selectedCategory = ""
                        selectedSize = ""
                        selectedBrand = ""
                    }
                }

                ToolbarItem(
                    placement: .topBarTrailing
                ) {

                    Button("Done") {

                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {

    FilterSheet(
        selectedCategory: .constant(""),
        selectedSize: .constant(""),
        selectedBrand: .constant(""),
        categories: [
            "Tops",
            "Bottoms",
            "Dresses"
        ],
        sizes: [
            "S",
            "M",
            "L"
        ],
        brands: [
            "Zara",
            "H&M"
        ]
    )
}
