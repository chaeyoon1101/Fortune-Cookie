//
//  FortuneCookieImage.swift
//  FortuneCookie
//
//  Created by 임채윤 on 1/23/24.
//

import SwiftUI

struct FortuneCookieImage: View {
    var status: Bool
    
    var body: some View {
        if status {
            return GeometryReader { geometry in
                Image("openedFortunecookie")
                    .resizable()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.width
                    )
                    .position(
                        x: geometry.size.width / 2.0,
                        y: geometry.size.height / 2.0
                    )
            }
        } else {
            return GeometryReader { geometry in
                Image("fortunecookie")
                    .resizable()
                    .frame(
                        width: geometry.size.width * 0.8,
                        height: geometry.size.width * 0.8
                    )
                    .position(
                        x: geometry.size.width / 2.0,
                        y: geometry.size.height / 2.0
                    )
            }
        }
    }
}

#Preview {
    FortuneCookieImage(status: false)
}
