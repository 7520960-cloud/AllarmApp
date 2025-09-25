import Foundation
import UserNotifications

class AlarmViewModel: ObservableObject {
    @Published var alarms: [Alarm] = []
    
    func addAlarm(time: Date) {
        let alarm = Alarm(time: time)
        alarms.append(alarm)
        scheduleAlarm(alarm)
    }
    
    func toggleAlarm(_ alarm: Alarm) {
        if let index = alarms.firstIndex(where: { $0.id == alarm.id }) {
            alarms[index].isEnabled.toggle()
            
            if alarms[index].isEnabled {
                scheduleAlarm(alarms[index])
            } else {
                cancelAlarm(alarm)
            }
        }
    }
    
    func scheduleAlarm(_ alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "⏰ Будильник"
        content.body = "Пора вставать!"
        content.sound = UNNotificationSound.default
        
        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: alarm.time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
        
        let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelAlarm(_ alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.id.uuidString])
    }
}
