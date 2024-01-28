import SwiftUI

struct ColorIcon: View {
    @State var index: Int
    @State var color: Color
    @Binding var selectedIndex: Int
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 40, height: 40)
            .overlay(
                index == selectedIndex ?
                Circle()
                    .stroke(Color.white, lineWidth: 3) : nil  
            )
    }
}

#Preview {
    ColorIcon(index: 1, color: .blue, selectedIndex: .constant(1))
}
