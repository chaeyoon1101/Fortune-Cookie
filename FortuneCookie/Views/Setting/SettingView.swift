import SwiftUI
import MessageUI

struct SettingView: View {
    @State private var notificationEnabled: Bool = UserDefaults.standard.bool(forKey: "notificationEnabled")
    
    @State private var notificationTime: Date = UserDefaults.standard.object(forKey: "notificationTime") as? Date ?? Date()
    
    @Binding var haptic: Haptic
    
    @State private var showingSettingAlert: Bool = false
    @State private var showingMailAlert: Bool = false
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
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
                    Text("앱 버전")
                    Spacer()
                    Text("1.0")
                }
                
                Button("문의 하기") {
                    self.isShowingMailView.toggle()
                }
                .disabled(!MFMailComposeViewController.canSendMail())
                .sheet(isPresented: $isShowingMailView) {
                    MailView(result: self.$result)
                        .onDisappear {
                            handleMailResult()
                        }
                }
            }
        }
        .navigationTitle("설정")
    
        .onAppear {
            reloadUserDefaults()
        }
        
        .onChange(of: notificationEnabled, perform: { newValue in
            UserDefaults.standard.set(newValue, forKey: "notificationEnabled")
            
            notificationManager.requestPermission()
            checkNotificationSetting()

            print("changed")
            DispatchQueue.main.async {
                handleNotificationEnabledChange()
            }
        })
        
        .onChange(of: notificationTime, perform: { newNotificationTime in
            UserDefaults.standard.set(newNotificationTime, forKey: "notificationTime")

            DispatchQueue.main.async {
                handleNotificationTimeChange()
            }
        })
        
        .onChange(of: haptic, perform: { newValue in
            let hapticIntensity = newValue.rawValue
            UserDefaults.standard.set(hapticIntensity, forKey: "hapticIntensity")

            DispatchQueue.main.async {
                haptic.vibrate()
            }
        })
        
        .alert("알림 설정", isPresented: $showingSettingAlert) {
            Button("알림 허용하러 가기") {
                openAppSettings()
            }
        } message: {
            Text("알림 설정이 거부되어있어요. \n알림 설정을 허용으로 바꿔주세요!")
        }
        
        .alert("", isPresented: $showingMailAlert) {
            
        } message: {
            Text("소중한 의견 정말 감사드립니다.\n더욱 발전하는 앱이 되도록 노력하겠습니다.")
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
                showingSettingAlert = true
            }
        }
    }
    
    private func handleMailResult() {
        showingMailAlert = true
    }
    
    private func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingsURL)
    }   
}

#Preview {
    SettingView(haptic: .constant(.soft))
}
