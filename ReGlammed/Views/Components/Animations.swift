//
//  Animations.swift
//  ReGlammed
//
//  Created by Rashmi Priyadarshi on 25/06/26.
//

import SwiftUI

struct FadeSlideModifier: ViewModifier {

    @State private var show = false

    func body(content: Content) -> some View {

        content
            .opacity(show ? 1 : 0)
            .offset(y: show ? 0 : 25)
            .animation(
                .spring(
                    response: 0.7,
                    dampingFraction: 0.82
                ),
                value: show
            )
            .onAppear {

                show = true
            }
    }
}

extension View {

    func fadeSlide() -> some View {

        modifier(FadeSlideModifier())
    }
}
