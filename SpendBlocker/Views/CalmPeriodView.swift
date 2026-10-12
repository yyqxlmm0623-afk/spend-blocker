import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var store: ExpenseStore

    @State private var title = ""
    @State private var amountText = ""
    @State private var note = ""
    @State private var category: ExpenseCategory = .food
    @State private var date = Date()
    @State private var showCalmPeriod = false
    @State private var pendingAmount: Double = 0

    var body: some View {
        NavigationStack {
            Form {
                Section("消费信息") {
                    TextField("标题", text: $title)
                    TextField("金额", text: $amountText)
                        .keyboardType(.decimalPad)
                    Picker("分类", selection: $category) {
                        ForEach(ExpenseCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    DatePicker("日期", selection: $date, displayedComponents: .date)
                    TextField("备注", text: $note)
                }
            }
            .navigationTitle("添加消费")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("取消") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("保存") {
                        guard let amount = Double(amountText), amount > 0 else { return }
                        pendingAmount = amount
                        if store.shouldPausePurchase(amount: amount) {
                            showCalmPeriod = true
                        } else {
                            store.addTransaction(title: title.isEmpty ? category.rawValue : title, amount: amount, category: category, note: note)
                            dismiss()
                        }
                    }
                }
            }
            .sheet(isPresented: $showCalmPeriod) {
                CalmPeriodView(amount: pendingAmount, store: store) {
                    store.addTransaction(title: title.isEmpty ? category.rawValue : title, amount: pendingAmount, category: category, note: note)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddTransactionView(store: ExpenseStore())
}
