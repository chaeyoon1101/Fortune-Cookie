import SwiftUI

struct ContentView: View {
    @State private var fortuneMessage = "test"
    @State private var openedFortuneCookie = false
    @State private var isAnimating = false
    
    var randomMessage: String {
        let fortuneMessages = ModelData().fortuneCookie.messages
        let range = 0..<fortuneMessages.count
        
        let randomMessage = fortuneMessages[Int.random(in: range)]
        
        return randomMessage
    }
    
    var body: some View {
        ZStack {
            FortuneBackground()
            VStack {
                FortuneCookieImage(status: openedFortuneCookie)
                    .onTapGesture {
                        if (!isAnimating) {
                            fortuneMessage = randomMessage
                            isAnimating = true
                            withAnimation {
                                openedFortuneCookie.toggle()
                            } completion: {
                                isAnimating = false
                            }
                        }
                    }
            }
            if (openedFortuneCookie) {
                FortuneMessagePaper(message: fortuneMessage)
            }
        }
    }
}

#Preview {
    ContentView()
}
