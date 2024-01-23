import SwiftUI

struct ContentView: View {
    @State private var messageText = "test"
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
            backgroundView
            VStack {
                fortuneCookie
                    .onTapGesture {
                        if (!isAnimating) {
                            messageText = randomMessage
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
                fortuneMessagePaper
            }
        }
    }
    
    private var backgroundView: some View {
        Color(red: 245 / 255, green: 235 / 255, blue: 220 / 255)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var fortuneCookie: some View {
        if openedFortuneCookie {
            return GeometryReader { geometry in
                Image("openedFortunecookie")
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .position(
                        x: geometry.size.width / 2.0,
                        y: geometry.size.height / 2.0
                    )
            }
        } else {
            return GeometryReader { geometry in
                Image("fortunecookie")
                    .resizable()
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8)
                    .position(
                        x: geometry.size.width / 2.0,
                        y: geometry.size.height / 2.0
                    )
            }
        }
    }
    
    private var fortuneMessagePaper: some View {
         
    return ZStack {
            GeometryReader { geometry in
                Image("white-paper-texture")
                    .resizable()
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.3)
                    .position(
                        x: geometry.size.width / 2.0,
                        y: geometry.size.height / 1.5
                    )
                    .clipped()
                Text(messageText)
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
    ContentView()
}
