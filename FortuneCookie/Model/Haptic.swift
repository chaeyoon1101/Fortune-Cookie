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
            return NSLocalizedString("SettingView.GeneralSetting.HapticIntensityPicker.soft", comment: "soft")
        case .rigid:
            return NSLocalizedString("SettingView.GeneralSetting.HapticIntensityPicker.rigid", comment: "rigid")
        case .light:
            return NSLocalizedString("SettingView.GeneralSetting.HapticIntensityPicker.light", comment: "light")
        case .medium:
            return NSLocalizedString("SettingView.GeneralSetting.HapticIntensityPicker.medium", comment: "medium")
        case .heavy:
            return NSLocalizedString("SettingView.GeneralSetting.HapticIntensityPicker.heavy", comment: "heavy")
        case .twice:
            return NSLocalizedString("SettingView.GeneralSetting.HapticIntensityPicker.twice", comment: "twice")
        case .threeTimes:
            return NSLocalizedString("SettingView.GeneralSetting.HapticIntensityPicker.threeTimes", comment: "threeTimes")
        case .none:
            return NSLocalizedString("SettingView.GeneralSetting.HapticIntensityPicker.none", comment: "none")
        }
    }
}
