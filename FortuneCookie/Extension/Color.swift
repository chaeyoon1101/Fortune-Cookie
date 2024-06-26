import SwiftUI

extension Color {
    static func getBackground(index: Int) -> Color {
        let color = Color.Background(rawValue: index)?.view ?? .white
        
        return color
    }
    
    enum Background: Int, CaseIterable {
        case coral = 0
        case mint
        case blue
        case lavender
        case rose
        case gray
        
        var view: Color {
            switch self {
            case .coral:
                return Color(
                    red: 255 / 255,
                    green: 240 / 255,
                    blue: 224 / 255
                )
            case .gray:
                return Color(
                    red: 220 / 255,
                    green: 220 / 255,
                    blue: 220 / 255
                )
            case .mint:
                return Color(
                    red: 224 / 255,
                    green: 255 / 255,
                    blue: 224 / 255
                )
            case .blue:
                return Color(
                    red: 173 / 255,
                    green: 216 / 255,
                    blue: 230 / 255
                )
            case .lavender:
                return Color(
                    red: 230 / 255,
                    green: 230 / 255,
                    blue: 250 / 255
                )
            case .rose:
                return Color(
                    red: 255 / 255,
                    green: 228 / 255,
                    blue: 225 / 255
                )
            }
        }
        
        var name: String {
            switch self {
            case .coral:
                return "Coral"
            case .mint:
                return "Mint"
            case .blue:
                return "Blue"
            case .lavender:
                return "Lavender"
            case .rose:
                return "rose"
            case .gray:
                return "gray"
            }
        }
    }
}
