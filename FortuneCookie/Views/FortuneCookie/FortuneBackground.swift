import SwiftUI

struct FortuneBackground: View {
    var body: some View {
        ZStack {
            Color.Background(rawValue: 5)?.view
                .edgesIgnoringSafeArea(.all)
            
            FortuneCookieImage(status: false)
        }
        
    }
}

#Preview {
    FortuneBackground()
}
