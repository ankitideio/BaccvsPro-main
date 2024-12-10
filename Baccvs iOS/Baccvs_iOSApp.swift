//
//  Baccvs_iOSApp.swift
//  Baccvs iOS
//
//  Created by Mustaqeez Ahmad on 31/01/2023.
//

import SwiftUI
import Combine
import FirebaseFirestoreSwift
import Firebase
import RevenueCat
import OneSignal
import Combine
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
                
               OneSignal.initWithLaunchOptions(launchOptions)
               OneSignal.setAppId("aba6dc55-35fc-4bea-aed2-51f524bcf65a")
                
               OneSignal.promptForPushNotifications(userResponse: { accepted in
                 print("User accepted notification: \(accepted)")
               })
              
              // Set your customer userId
              // OneSignal.setExternalUserId("userId")
                UNUserNotificationCenter.current().delegate = self
              
               return true
    }
    
}
@main
struct Baccvs_iOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var isOpen : Bool?
    @State private var selectedEventId: String = ""
    @State private var isNotifecation : Bool = false
    @AppStorage("isLogedIn") var isLogedIn : Bool = Bool()
    @AppStorage ("isAdmin") var isAdmin : Int?
    @AppStorage ("isUser") var isUser : Int?
    @State private var cancellables = Set<AnyCancellable>()
    @ObservedObject var subscriptionManager = SubscriptionManager()
    init() {
        FirebaseApp.configure()
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_WxXcYxYvRojwHhGVjqvDJKUeMre")
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack{
           
        if isLogedIn && isUser == 1{
            TabNavPage(isNotifecation: isNotifecation, eventID: selectedEventId)
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationDestination(
                                             isPresented: $subscriptionManager.isNotification) {
                                                 EventDetailsPage(eventId: subscriptionManager.selectedEventId)
                                                     .onAppear{
                                                         print(subscriptionManager.selectedEventId)
                                                     }
                                             }
                    }else if isLogedIn && isAdmin == 1{
                        HomePage()
                            .navigationBarTitleDisplayMode(.inline)
                    }else{
                        ContentView()
                            .navigationBarTitleDisplayMode(.inline)
                    }
            }.accentColor(.white)
                .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("Event_Detail"))) { notification in
                    handleNotification(notification)
                }
                .enableLightStatusBar()
                .onAppear{
                    OneSignal.promptForPushNotifications(userResponse: { accepted in
                        print("User accepted notifications: \(accepted)")
                        
                    })
                    
                }
        }
    }
    func handleNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: AnyObject] {
            // Access custom data here
            if let customData = userInfo["custom"] as? [String: Any],
               let additionalData = customData["a"] as? [String: Any] {
                // This is the notification from the specific campaign
                let newid = additionalData["event_id"] as? String ?? ""
                if newid != "" {
                    print(newid)
                    subscriptionManager.selectedEventId = newid
                    subscriptionManager.isNotification = true
                }
            }
        }
    }
}
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        NotificationCenter.default.post(name: NSNotification.Name("Event_Detail"), object: nil, userInfo: userInfo)
        completionHandler()
    }
}
class SubscriptionManager: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    @Published var selectedEventId: String = ""
    @Published var isNotification: Bool = false
    
    init() {
        NotificationCenter.default.publisher(for: NSNotification.Name("Event_Detail"))
            .sink { notification in
                // Handle your notification
                if let userInfo = notification.userInfo as? [String: AnyObject] {
                    // Access custom data here
                    if let customData = userInfo["custom"] as? [String: Any],
                       let additionalData = customData["a"] as? [String: Any] {
                        // This is the notification from the specific campaign
                        let newid = additionalData["event_id"] as? String ?? ""
                        if newid != "" {
                            DispatchQueue.main.async {
                                self.selectedEventId = newid
                                self.isNotification = true
                                print("Notification received")
                            }
                            
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }
}
