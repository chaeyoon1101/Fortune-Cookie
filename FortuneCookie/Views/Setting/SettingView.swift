import SwiftUI
import MessageUI

struct SettingView: View {
    @AppStorage("notificationEnabled") private var notificationEnabled: Bool = false
    
    @State private var notificationTime: Date = UserDefaults.standard.object(forKey: "notificationTime") as? Date ?? Date()
    
    @Binding var haptic: Haptic
    
    @State private var showingSettingAlert: Bool = false
    @State private var showingMailAlert: Bool = false
    
    @State var isMailViewPresented = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    
    let notificationManager = NotificationManager()

    var body: some View {
        NavigationView {
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
                        self.isMailViewPresented.toggle()
                    }
                    .disabled(!MFMailComposeViewController.canSendMail())
                    .sheet(isPresented: $isMailViewPresented) {
                        MailView(result: self.$result)
                            .onDisappear {
                                handleMailResult()
                            }
                    }
                }
            }
            .navigationTitle("SettingView.NavigationTitle")
            .navigationBarTitleDisplayMode(.inline)
        
            .onAppear {
                reloadUserDefaults()
            }
            
            .onChange(of: notificationEnabled, perform: { newValue in
                notificationManager.requestPermission()
                checkNotificationSetting()

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
    }
    
    
    private func reloadUserDefaults() {
        notificationTime = UserDefaults.standard.object(forKey: "notificationTime") as? Date ?? Date()
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
