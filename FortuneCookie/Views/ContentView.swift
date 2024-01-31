import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
              FortuneCookieView()
                .tabItem {
                  Image(systemName: "1.square.fill")
                  Text("First")
                }
              Text("Another Tab")
                .tabItem {
                  Image(systemName: "2.square.fill")
                  Text("Second")
                }
//              SettingView(haptic: <#T##Binding<Haptic>#>)
//                .tabItem {
//                  Image(systemName: "3.square.fill")
//                  Text("Third")
//                }
//                .badge(10)
            }
            .font(.headline)
    }
}

#Preview {
    ContentView()
}
