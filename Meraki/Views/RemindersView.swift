//
//  RemindersView.swift
//  Meraki
//
//  Created by Christos Eteoglou on 2024-11-08.
//

import SwiftUI
import SwiftData
import UserNotifications

struct RemindersView: View {
    
    @AppStorage("ReminderTime") private var reminderTime: Double = Date().timeIntervalSince1970
    
    @AppStorage("RemindersOn") private var isRemindersOn = false
    @State private var selectedDate = Date().addingTimeInterval(86400)
    @State private var isSettingsDialogShowing = false
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            Text("Reminders")
                .font(.largeTitle)
                .bold()
            
            Text("Remind yourself to do something uplifting everyday.")
            
            Toggle(isOn: $isRemindersOn) {
                Text("Toggle reminders:")
            }
            
            if isRemindersOn {
                HStack {
                    Text("What time?")
                    
                    Spacer()
                    
                    DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                }
            }
            
            Spacer()
        }
        .onAppear(perform: {
            selectedDate = Date(timeIntervalSince1970: reminderTime)
        })
        
        .onChange(of: isRemindersOn) { oldValue, newValue in
            // Check for permissions to send notifications
            let notificationCenter = UNUserNotificationCenter.current()
            
            notificationCenter.getNotificationSettings { settings in
                switch settings.authorizationStatus {
                case .authorized:
                    print("Notifications are authorized")
                    // Schedule the notifications
                    scheduleNotifications()
                case .denied:
                    print("Notifications are denied")
                    isRemindersOn = false
                    // Show a dialog stating we cant send notifications and send user to settings
                    isSettingsDialogShowing = true
                case .notDetermined:
                    print("Notification permission has not been asked yet.")
                    // Request it
                    requestNotificationPermission()
                default:
                    break
                    
                }
            }
        }
        .onChange(of: selectedDate) { oldValue, newValue in
            
            let notificationCenter = UNUserNotificationCenter.current()
            // Unschedule all currently scheduled reminders
            notificationCenter.removeAllPendingNotificationRequests()
            
            // Schedule new reminders
            scheduleNotifications()
            
            // Save new time
            reminderTime = selectedDate.timeIntervalSince1970
        }
        .alert(isPresented: $isSettingsDialogShowing) {
            
            Alert(title: Text("Notifications Disabled"), message: Text("Please enable notifications in your device settings."), primaryButton: .default(Text("Go to Settings"), action: {
                // Go to settings
                goToSettings()
            }), secondaryButton: .cancel())
        }
    }
    
    func goToSettings() {
        
        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
            
            if UIApplication.shared.canOpenURL(appSettings) {
                
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                
            }
        }
    }
    
    func requestNotificationPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Permiission granted")
                // Schedule the notifications
                scheduleNotifications()
            } else {
                print("Permission denied.")
                isRemindersOn = false
                // Show a dialog stating we cant send notifications and send user to settings
                isSettingsDialogShowing = true
            }
            
            if let error = error {
                print("Error requesting permission: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotifications() {
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        // Create the content of the notification
        let content = UNMutableNotificationContent()
        content.title = "Meraki"
        content.body = "Dont forget to do something for yourself today!"
        content.sound = .default
        
        // Define the time components for the notification (8:00 AM in this case)
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.autoupdatingCurrent.component(.hour, from: selectedDate)
        dateComponents.minute = Calendar.autoupdatingCurrent.component(.minute, from: selectedDate)
        
        // Create a trigger that repeats every day at the specified time
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create the notification request with a unique identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Daily notification scheduled successfully.")
            }
        }
        
    }
    
}

#Preview {
    RemindersView()
}
