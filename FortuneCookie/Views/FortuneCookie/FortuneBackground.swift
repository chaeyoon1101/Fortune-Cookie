import SwiftUI

struct FortuneBackground: View {
    var body: some View {
        Color(
            red: 245 / 255,
            green: 235 / 255,
            blue: 220 / 255
        )
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    FortuneBackground()
}
