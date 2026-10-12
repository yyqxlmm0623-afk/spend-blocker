import Foundation

final class ExpenseStore: ObservableObject {
    @Published var transactions: [Transaction]
    @Published var budgets: [Budget]
    @Published var monthlyBudget: Double
    @Published var calmThreshold: Double
    @Published var calmSeconds: Int

    private let storage = StorageService.shared

    init() {
        self.transactions = storage.loadTransactions()
        self.budgets = storage.loadBudgets().isEmpty ? ExpenseCategory.allCases.map { Budget(category: $0, limit: 800) } : storage.loadBudgets()
        self.monthlyBudget = storage.loadMonthlyBudget() == 0 ? 4000 : storage.loadMonthlyBudget()
        self.calmThreshold = storage.loadCalmThreshold() == 0 ? 100 : storage.loadCalmThreshold()
        self.calmSeconds = storage.loadCalmSeconds() == 0 ? 10 : storage.loadCalmSeconds()
    }

    func addTransaction(title: String, amount: Double, category: ExpenseCategory, note: String) {
        let transaction = Transaction(title: title, amount: amount, category: category, note: note)
        transactions.insert(transaction, at: 0)
        storage.saveTransactions(transactions)
    }

    func monthlySpent() -> Double {
        let calendar = Calendar.current
        let monthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: Date())) ?? Date()

        return transactions.filter { transaction in
            transaction.date >= monthStart
        }.reduce(0) { $0 + $1.amount }
    }

    func spent(for category: ExpenseCategory) -> Double {
        transactions.filter { $0.category == category }.reduce(0) { $0 + $1.amount }
    }

    func recentTransactions() -> [Transaction] {
        transactions.sorted { $0.date > $1.date }
    }

    func progressRatio() -> Double {
        guard monthlyBudget > 0 else { return 0 }
        return min(monthlySpent() / monthlyBudget, 1.0)
    }

    func remainingBudget() -> Double {
        monthlyBudget - monthlySpent()
    }

    func shouldPausePurchase(amount: Double) -> Bool {
        amount >= calmThreshold
    }

    func categoryBudgetLimit(for category: ExpenseCategory) -> Double {
        budgets.first { $0.category == category }?.limit ?? 800
    }

    func updateSettings(monthlyBudget: Double, calmThreshold: Double, calmSeconds: Int) {
        self.monthlyBudget = monthlyBudget
        self.calmThreshold = calmThreshold
        self.calmSeconds = calmSeconds

        storage.saveMonthlyBudget(monthlyBudget)
        storage.saveCalmThreshold(calmThreshold)
        storage.saveCalmSeconds(calmSeconds)
    }

    func saveBudgets() {
        storage.saveBudgets(budgets)
    }
}
