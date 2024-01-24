import Foundation

let hapticManager = HapticManager()

enum Haptic: Int, CaseIterable {
    case soft = 0
    case rigid
    case light
    case medium
    case heavy
    case twice
    case threeTimes
    case none
    
    func vibrate() {
        switch self {
        case .soft:
            hapticManager.impact(style: .soft)
            break
        case .rigid:
            hapticManager.impact(style: .rigid)
            break
        case .light:
            hapticManager.impact(style: .light)
            break
        case .medium:
            hapticManager.impact(style: .medium)
            break
        case .heavy:
            hapticManager.impact(style: .heavy)
            break
        case .twice:
            hapticManager.notification(type: .success)
            break
        case .threeTimes:
            hapticManager.notification(type: .error)
            break
        case .none:
            break
        }
    }
    
    var name: String {
        switch self {
        case .soft:
            return "부드럽게"
        case .rigid:
            return "딱딱하게"
        case .light:
            return "가볍게"
        case .medium:
            return "적당하게"
        case .heavy:
            return "세게"
        case .twice:
            return "두 번"
        case .threeTimes:
            return "세 번"
        case .none:
            return "끄기"
        }
    }
}


