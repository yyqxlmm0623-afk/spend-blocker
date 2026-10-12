import SwiftUI

struct SettingsView: View {
    @ObservedObject var store: ExpenseStore

    @State private var monthlyBudgetText: String
    @State private var calmThresholdText: String
    @State private var calmSecondsText: String

    init(store: ExpenseStore) {
        self.store = store
        _monthlyBudgetText = State(initialValue: String(format: "%.0f", store.monthlyBudget))
        _calmThresholdText = State(initialValue: String(format: "%.0f", store.calmThreshold))
        _calmSecondsText = State(initialValue: String(store.calmSeconds))
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("预算设置") {
                    TextField("月预算", text: $monthlyBudgetText)
                        .keyboardType(.decimalPad)
                    TextField("冷静期阈值", text: $calmThresholdText)
                        .keyboardType(.decimalPad)
                    TextField("冷静期秒数", text: $calmSecondsText)
                        .keyboardType(.numberPad)
                }

                Button("保存设置") {
                    let budget = Double(monthlyBudgetText) ?? store.monthlyBudget
                    let threshold = Double(calmThresholdText) ?? store.calmThreshold
                    let seconds = Int(calmSecondsText) ?? store.calmSeconds
                    store.updateSettings(monthlyBudget: budget, calmThreshold: threshold, calmSeconds: seconds)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .navigationTitle("设置")
        }
    }
}

#Preview {
    SettingsView(store: ExpenseStore())
}
