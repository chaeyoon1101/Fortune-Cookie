import SwiftUI

struct ColorPickerView: View {
    @Environment(\.presentationMode) var presentationMode
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
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                } )
        }
    }
        
}

#Preview {
    ColorPickerView(selectedColorIndex: .constant(2))
}
