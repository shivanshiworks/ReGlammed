//
//  AppFont.swift
//  ReGlammed
//
//  Created by Rashmi Priyadarshi on 25/06/26.
//

import SwiftUI

extension Font {

    static func luxury(_ size: CGFloat) -> Font {
        .custom("anaktoria", size: size)
    }

    static func accent(_ size: CGFloat) -> Font {
        .custom("EDLavonia-Regular", size: size)
    }
}
