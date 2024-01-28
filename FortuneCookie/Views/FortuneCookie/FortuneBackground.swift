import SwiftUI

struct FortuneBackground: View {
    @Binding var selectedColor: Int

    var body: some View {
        ZStack {
            Color.Background(rawValue: selectedColor)?.view
                .edgesIgnoringSafeArea(.all)
        }
        
    }
}

#Preview {
    FortuneBackground(selectedColor: .constant(1))
}
