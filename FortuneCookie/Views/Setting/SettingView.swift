import SwiftUI

struct SettingView: View {
    @State private var notificationEnabled: Bool = UserDefaults.standard.bool(forKey: "notificationEnabled")
    
    @State private var notificationTime: Date = UserDefaults.standard.object(forKey: "notificationTime") as? Date ?? Date()
    
    @Binding var haptic: Haptic
    
    @State private var showingAlert: Bool = false
    
    let notificationManager = NotificationManager()

    var body: some View {
        Form {
            Section(header: Text("기본 세팅")) {
                Toggle("알림 설정 받기", isOn: $notificationEnabled)
                
                if notificationEnabled {
                    DatePicker("시간 설정", selection: $notificationTime, displayedComponents: .hourAndMinute)
                }
                
                Picker("진동 강도", selection: $haptic) {
                    ForEach(Haptic.allCases, id: \.self) { haptic in
                        Text(haptic.name)
                    }
                }
                
                HStack {
                    Text("App Version")
                    Spacer()
                    Text("1.0.0")
                }
                
            }
        }
        .navigationTitle("설정")
        
        .onAppear {
            reloadUserDefaults()
        }
        
        .onChange(of: notificationEnabled, initial: true) { oldValue, newValue in
            UserDefaults.standard.set(newValue, forKey: "notificationEnabled")
            
            if oldValue != newValue {
                notificationManager.requestPermission()
                checkNotificationSetting()
            }
            
            handleNotificationEnabledChange()
        }
        
        .onChange(of: notificationTime, initial: true) { _, newNotificationTime in
            UserDefaults.standard.set(newNotificationTime, forKey: "notificationTime")
            
            handleNotificationTimeChange()
        }
        
        .onChange(of: haptic, { _, newValue in
            let hapticIntensity = newValue.rawValue
            UserDefaults.standard.set(hapticIntensity, forKey: "hapticIntensity")
            
            haptic.vibrate()
        })
        
        .alert("알림 설정", isPresented: $showingAlert) {
            Button("알림 허용하러 가기") {
                openAppSettings()
            }
        } message: {
            Text("알림 설정이 거부되어있어요. \n알림 설정을 허용으로 바꿔주세요!")
        }
    }
    
    private func reloadUserDefaults() {
        notificationEnabled = UserDefaults.standard.bool(forKey: "notificationEnabled")
        notificationTime = UserDefaults.standard.object(forKey: "notificationTime") as? Date ?? Date()
        haptic = Haptic(
            rawValue: UserDefaults.standard.integer(
                forKey: "hapticIntensity"
            )
        ) ?? .soft
    }

    private func handleNotificationEnabledChange() {
        if notificationEnabled {
            notificationManager.schedule()
        } else {
            notificationManager.removeNotification()
        }
    }
    
    private func handleNotificationTimeChange() {
        if notificationEnabled {
            notificationManager.scheduleNotification()
        }
    }
    
    private func checkNotificationSetting() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .denied {
                showingAlert = true
            }
        }
    }
    
    private func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingsURL)
    }
}

#Preview {
    SettingView(haptic: .constant(.soft))
}
