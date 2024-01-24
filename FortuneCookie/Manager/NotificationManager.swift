import Foundation
import UserNotifications

struct NotificationManager {
    var notification = Notification(id: UUID().uuidString, title: "오늘의 포춘 쿠키", subTitle: "오늘의 포춘 쿠키를 확인해보세요!")
    
    func requestPermission() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                    print("Notification permission granted.")
                } else {
                    print("Notification permission denied.")
                    
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
    }
    
    func schedule() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestPermission()
            case .authorized, .provisional:
                self.scheduleNotification()
            default:
                break
            }
        }
    }
    
    func scheduleNotification() {
        let date = UserDefaults.standard.object(forKey: "notificationTime") as? Date ?? Date()
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.sound = UNNotificationSound.default
        content.subtitle = notification.subTitle
        
//        print(date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
        
        removeNotification()
        
        UNUserNotificationCenter.current().add(request) { error in
            guard error == nil else { return }
//            print(" id:\(notification.id)")
        }
    }
    
    func removeNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

struct Notification {
    var id: String
    var title: String
    var subTitle: String
}
