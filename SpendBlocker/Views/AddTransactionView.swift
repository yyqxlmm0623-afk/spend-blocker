import SwiftUI

struct HomeView: View {
    @ObservedObject var store: ExpenseStore
    @State private var showAddSheet = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    headerCard
                    recentCard
                    listCard
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Spend Blocker")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                AddTransactionView(store: store)
            }
        }
    }

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("本月消费")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("¥\(String(format: "%.0f", store.monthlySpent()))")
                    .font(.title2)
                    .fontWeight(.bold)
            }

            ProgressView(value: store.progressRatio())
                .tint(store.monthlySpent() > store.monthlyBudget ? .red : .green)

            HStack {
                Text("预算剩余 ¥\(String(format: "%.0f", store.remainingBudget()))")
                Spacer()
                Text("目标 ¥\(String(format: "%.0f", store.monthlyBudget))")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private var recentCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("最近支出")
                .font(.headline)

            ForEach(Array(store.recentTransactions().prefix(3)), id: \ .id) { item in
                HStack {
                    Image(systemName: item.category.icon)
                        .frame(width: 32, height: 32)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())

                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.body)
                        Text(item.category.rawValue)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Text("-¥\(String(format: "%.0f", item.amount))")
                        .fontWeight(.semibold)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var listCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("分类预算")
                .font(.headline)

            ForEach(ExpenseCategory.allCases, id: \ .self) { category in
                let spent = store.spent(for: category)
                let limit = store.categoryBudgetLimit(for: category)
                let ratio = limit > 0 ? min(spent / limit, 1.0) : 0

                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Label(category.rawValue, systemImage: category.icon)
                        Spacer()
                        Text("¥\(String(format: "%.0f", spent)) / ¥\(String(format: "%.0f", limit))")
                            .font(.caption)
                    }
                    ProgressView(value: ratio)
                        .tint(ratio > 0.8 ? .red : .green)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    HomeView(store: ExpenseStore())
}
