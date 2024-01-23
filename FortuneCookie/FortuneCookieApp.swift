import SwiftUI
import UIKit

@main
struct FortuneCookieApp: App {
    func setNotification() -> Void {
        let manager = NotificationManager()
        let notificationEnabled: Bool = UserDefaults.standard.bool(forKey: "notificationEnabled")
       
        print(notificationEnabled)
        
        manager.requestPermission()
        
        if notificationEnabled {
            manager.schedule()
        } else {
            manager.removeNotification()
        }
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        setNotification()
    }
    
    
}

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.alert, .badge, .sound])
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called
        // shortly after application:didFinishLaunchingWithOptions
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
