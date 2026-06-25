//
//  ImagePicker.swift
//  ReGlammed
//
//  Created by Rashmi Priyadarshi on 23/06/26.
//

import SwiftUI
import PhotosUI

struct ImagePicker: View {

    @Binding var selectedImages: [UIImage]

    @State private var selectedItems: [PhotosPickerItem] = []

    var body: some View {

        PhotosPicker(
            selection: $selectedItems,
            maxSelectionCount: 5,
            matching: .images
        ) {

            VStack {

                Image(systemName: "photo.on.rectangle")

                Text("Add Photos (Max 5)")
            }
        }
        .onChange(of: selectedItems) {

            Task {

                selectedImages.removeAll()

                for item in selectedItems {

                    if let data = try? await item.loadTransferable(
                        type: Data.self
                    ),
                    let image = UIImage(data: data) {

                        selectedImages.append(image)
                    }
                }
            }
        }
    }
}
