import SwiftUI

struct FortuneMessagePaper: View {
    var message: String
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("white-paper-texture")
                    .resizable()
                    .frame(
                        width: geometry.size.width * 0.9,
                        height: geometry.size.width * 0.25
                    )
                    .position(
                        x: geometry.size.width / 2.0,
                        y: geometry.size.height / 1.5
                    )
                    .clipped()
                Text(message)
                    .font(.headline)
                    .foregroundColor(.black)
                    .bold()
                    .multilineTextAlignment(.center)
                    .frame(width: geometry.size.width * 0.7)
                    .position(
                        x: geometry.size.width / 2.0,
                        y: geometry.size.height / 1.5
                    )
            }
        }
    }
}

#Preview {
    FortuneMessagePaper(message: "즐거운 하루가 될거예요")
}
