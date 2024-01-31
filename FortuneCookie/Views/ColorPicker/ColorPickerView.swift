import SwiftUI

struct ColorPickerView: View {
    @Binding var isPresented: Bool
    @Binding var selectedColorIndex: Int
    
    var body: some View {
        NavigationView {
            HStack(spacing: 24) {
                ForEach(Color.Background.allCases, id: \.self) { color in
                    ColorIcon(
                        index: color.rawValue,
                        color: color.view,
                        selectedIndex: $selectedColorIndex
                    )
                    .onTapGesture {
                        selectedColorIndex = color.rawValue
                        UserDefaults.standard.set(selectedColorIndex, forKey: "selectedBackgroundColorIndex")
                    }
                }
            }
            .navigationBarItems(
                trailing: Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                } )
        }
    }
        
}

#Preview {
    ColorPickerView(isPresented: .constant(true), selectedColorIndex: .constant(2))
}
