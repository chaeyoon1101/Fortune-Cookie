import SwiftUI

struct ContentView: View {
    @State private var fortuneMessage: String = ""
    
    @State private var openedFortuneCookie = false
    
    @State private var isAnimating = false
    
    @State private var haptic: Haptic = Haptic(
        rawValue: UserDefaults.standard.integer(
            forKey: "hapticIntensity"
        )
    ) ?? .soft
    
    @State private var backgroundColorIndex = UserDefaults.standard.integer(forKey: "selectedBackgroundColorIndex")
    
    var randomMessage: String {
        let fortuneMessages = ModelData().fortuneCookie.messages
        let range = 0..<fortuneMessages.count
        
        let randomMessage = fortuneMessages[Int.random(in: range)]
        
        return randomMessage
    }

    var body: some View {
        NavigationView {
            ZStack {
                FortuneBackground(selectedColor: $backgroundColorIndex)
                VStack {
                    ZStack(alignment: .top) {
                        HStack {
                            ColorPickerIcon(selectedColorIndex: $backgroundColorIndex)
                                .padding()
                            
                            Spacer()
                            
                            NavigationLink(destination: SettingView(haptic: $haptic), label: {
                                Image(systemName: "gear")
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(.black)
                                    .clipShape(Circle())
                                    .padding()
                            })
                        }
                        
                        FortuneCookieImage(status: openedFortuneCookie)
                            .onTapGesture {
                                if (!isAnimating) {
                                    if (!openedFortuneCookie) {
                                        haptic.vibrate()
                                    }
                                    fortuneMessage = randomMessage
                                    isAnimating = true
                                    if #available(iOS 17.0, *) {
                                        withAnimation {
                                            openedFortuneCookie.toggle()
                                        } completion: {
                                            isAnimating = false
                                        }
                                    } else {
                                        withAnimation {
                                            openedFortuneCookie.toggle()
                                            isAnimating = false
                                        }
                                    }
                                }
                            }
                    }
                }
                if (openedFortuneCookie) {
                    FortuneMessagePaper(message: fortuneMessage)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    Group {
        ContentView()
            .environment(\.locale, .init(identifier: "en"))
    }
}
