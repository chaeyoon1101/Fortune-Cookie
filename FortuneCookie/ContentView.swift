import SwiftUI

struct ContentView: View {
    @State private var messageText = ""
    @State private var openedFortuneCookie = false
    
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
                        withAnimation {
                            openedFortuneCookie.toggle()
                        }
                        messageText = randomMessage
                    }
                
                Text(messageText)
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    private var backgroundView: some View {
        Color(red: 255 / 255, green: 250 / 255, blue: 240 / 255)
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
}

#Preview {
    ContentView()
}
