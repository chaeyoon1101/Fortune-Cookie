import SwiftUI
import MessageUI

struct SettingView: View {
    @State private var notificationEnabled: Bool = UserDefaults.standard.bool(forKey: "notificationEnabled")
    
    @State private var notificationTime: Date = UserDefaults.standard.object(forKey: "notificationTime") as? Date ?? Date()
    
    @Binding var haptic: Haptic
    
    @State private var showingSettingAlert: Bool = false
    @State private var showingMailAlert: Bool = false
    
    @State var showingMailView = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    
    let notificationManager = NotificationManager()

    var body: some View {
        Form {
            Section(header: Text("SettingView.GeneralSetting.SectionHeaderText")) {
                Toggle("SettingView.GeneralSetting.NotificationEnableToggleText", isOn: $notificationEnabled)
                
                if notificationEnabled {
                    DatePicker("SettingView.GeneralSetting.NotificationTimeDatePickerText", selection: $notificationTime, displayedComponents: .hourAndMinute)
                }
                
                Picker("SettingView.GeneralSetting.HapticIntensityPickerText", selection: $haptic) {
                    ForEach(Haptic.allCases, id: \.self) { haptic in
                        Text(haptic.name)
                    }
                }
                
                HStack {
                    Text("SettingView.GeneralSetting.AppVersionText")
                    Spacer()
                    Text("1.0")
                }
                
                Button("SettingView.GeneralSetting.InquiryText") {
                    self.showingMailView.toggle()
                }
                .disabled(!MFMailComposeViewController.canSendMail())
                .sheet(isPresented: $showingMailView) {
                    MailView(result: self.$result)
                        .onDisappear {
                            handleMailResult()
                        }
                }
            
                HStack {
                    Text("Select a color")
                    Spacer()
//                    ColorPickerIcon(selectedColorIndex: <#Binding<Int>#>)
                }
                
//                ColorPicker("ee", selection: $selectedColor)
            }
        }
        .navigationTitle("SettingView.NavigationTitle")
    
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
        
        .alert("SettingView.Alert.NotificationSetting.Title", isPresented: $showingSettingAlert) {
            Button("SettingView.Alert.NotificationSetting.ButtonText") {
                openAppSettings()
            }
        } message: {
            Text("SettingView.Alert.NotificationSetting.MessageText")
        }
        
        .alert("", isPresented: $showingMailAlert) {
            
        } message: {
            Text("SettingView.Alert.Inquiry.Message")
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
