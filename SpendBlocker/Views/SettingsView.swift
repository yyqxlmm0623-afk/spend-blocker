import SwiftUI

struct StatisticsView: View {
    @ObservedObject var store: ExpenseStore

    var body: some View {
        NavigationStack {
            List {
                Section("总览") {
                    HStack {
                        Text("本月总支出")
                        Spacer()
                        Text("¥\(String(format: "%.0f", store.monthlySpent()))")
                            .fontWeight(.semibold)
                    }
                    HStack {
                        Text("本月预算")
                        Spacer()
                        Text("¥\(String(format: "%.0f", store.monthlyBudget))")
                    }
                }

                Section("分类统计") {
                    ForEach(ExpenseCategory.allCases, id: \.self) { category in
                        let amount = store.spent(for: category)
                        HStack {
                            Label(category.rawValue, systemImage: category.icon)
                            Spacer()
                            Text("¥\(String(format: "%.0f", amount))")
                        }
                    }
                }
            }
            .navigationTitle("统计")
        }
    }
}

#Preview {
    StatisticsView(store: ExpenseStore())
}
