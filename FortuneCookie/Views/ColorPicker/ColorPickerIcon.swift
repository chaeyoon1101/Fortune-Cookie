import SwiftUI
import UIKit

struct ColorPickerIcon: View {
    @State private var isColorPickerModalPresented = false
    @Binding var selectedColorIndex: Int
    
    let gradient = [Color.red, Color.orange, Color.yellow, Color.green, Color.blue, Color.indigo, Color.purple]
    
    var body: some View {
        Circle()
            .fill(Color.getBackground(index: selectedColorIndex))
            .overlay(
                Circle()
                    .stroke(LinearGradient(
                        gradient: Gradient(colors: gradient),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ), lineWidth: 3)
            )
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 2)
                    .padding(2)
            )
            .frame(width: 36, height: 36)
            .onTapGesture {
                isColorPickerModalPresented.toggle()
            }

            .sheet(isPresented: $isColorPickerModalPresented) {
                if #available(iOS 16.4, *) {
                    ColorPickerView(isPresented: $isColorPickerModalPresented, selectedColorIndex: $selectedColorIndex)
                        .presentationBackgroundInteraction(.enabled(upThrough: .height(100.0)))
                        .presentationDetents([.height(100.0)])
                        .presentationBackground(.clear)
                       
                } else {
                    ColorPickerView(isPresented: $isColorPickerModalPresented, selectedColorIndex: $selectedColorIndex)
                }
            }       
    }
}

#Preview {
    ColorPickerIcon(selectedColorIndex: .constant(1))
}
