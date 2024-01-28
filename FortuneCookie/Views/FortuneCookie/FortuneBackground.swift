import SwiftUI

struct FortuneBackground: View {
    @Binding var selectedColor: Int

    var body: some View {
        ZStack {
            Color.getBackground(index: selectedColor)
                .edgesIgnoringSafeArea(.all)
        }
        
    }
}

#Preview {
    FortuneBackground(selectedColor: .constant(1))
}
