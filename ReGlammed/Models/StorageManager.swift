//
//  StorageManager.swift
//  ReGlammed
//
//  Created by Rashmi Priyadarshi on 23/06/26.
//

import Foundation
import FirebaseStorage
import UIKit

class StorageManager {

    static let shared = StorageManager()

    private init() {}

    func uploadImage(
        image: UIImage,
        completion: @escaping (String?) -> Void
    ) {

        guard let imageData =
            image.jpegData(compressionQuality: 0.7)
        else {
            completion(nil)
            return
        }

        let fileName = UUID().uuidString

        let storageRef = Storage.storage()
            .reference()
            .child("listing_images/\(fileName).jpg")

        storageRef.putData(
            imageData,
            metadata: nil
        ) { _, error in

            if error != nil {
                completion(nil)
                return
            }

            storageRef.downloadURL { url, error in

                if error != nil {
                    completion(nil)
                    return
                }

                completion(url?.absoluteString)
            }
        }
    }
}
