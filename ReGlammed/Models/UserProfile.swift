//
//  UserProfile.swift
//  ReGlammed
//
//  Created by Rashmi Priyadarshi on 23/06/26.
//

import Foundation

struct UserProfile: Identifiable {

    let id: String

    var name: String
    var email: String

    var whatsapp: String
    var whatsappVerified: Bool
}
