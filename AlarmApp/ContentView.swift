import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = AlarmViewModel()
    @State private var showingAddAlarm = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.alarms) { alarm in
                    HStack {
                        Text(alarm.time, style: .time)
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        Toggle("", isOn: Binding(
                            get: { alarm.isEnabled },
                            set: { _ in viewModel.toggleAlarm(alarm) }
                        ))
                        .labelsHidden()
                    }
                    .padding()
                }
            }
            .navigationTitle("Будильники")
            .toolbar {
                Button(action: { showingAddAlarm = true }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                }
            }
            .sheet(isPresented: $showingAddAlarm) {
                AddAlarmView(viewModel: viewModel)
            }
        }
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
        }
    }
}
