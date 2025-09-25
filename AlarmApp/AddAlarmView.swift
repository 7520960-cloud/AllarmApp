import SwiftUI

struct AddAlarmView: View {
    @ObservedObject var viewModel: AlarmViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedTime = Date()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Новый будильник")
                .font(.title)
                .padding()
            
            DatePicker("Время:", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .padding()
            
            Button("Сохранить") {
                viewModel.addAlarm(time: selectedTime)
                dismiss()
            }
            .font(.title2)
            .padding()
        }
    }
}
