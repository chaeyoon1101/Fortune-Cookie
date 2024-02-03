import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .fortuneCookie
    
    enum Tab {
        case fortuneCookie
        case setting
    }
    
    @AppStorage("hapticIntensity") private var haptic: Haptic = .soft
    
    var body: some View {
        TabView(selection: $selection) {
            FortuneCookieView(haptic: $haptic)
                .tabItem {
                  Image(systemName: "house")
                  Text("포춘쿠키")
                }
                .tag(Tab.fortuneCookie)
            SettingView(haptic: $haptic)
                .tabItem {
                  Image(systemName: "gear")
                  Text("설정")
                }
                .tag(Tab.setting)
        }
        .onAppear() {
            UITabBar.appearance().barTintColor = .black
        }
        .font(.headline)
    }
    
}

#Preview {
    ContentView()
}
