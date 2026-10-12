import Foundation

final class StorageService {
    static let shared = StorageService()

    private let transactionsKey = "spend_blocker_transactions"
    private let budgetsKey = "spend_blocker_budgets"
    private let monthlyBudgetKey = "spend_blocker_monthly_budget"
    private let calmThresholdKey = "spend_blocker_calm_threshold"
    private let calmSecondsKey = "spend_blocker_calm_seconds"

    private let userDefaults = UserDefaults.standard

    func saveTransactions(_ transactions: [Transaction]) {
        let data = try? JSONEncoder().encode(transactions)
        userDefaults.set(data, forKey: transactionsKey)
    }

    func loadTransactions() -> [Transaction] {
        guard let data = userDefaults.data(forKey: transactionsKey) else { return [] }
        return (try? JSONDecoder().decode([Transaction].self, from: data)) ?? []
    }

    func saveBudgets(_ budgets: [Budget]) {
        let data = try? JSONEncoder().encode(budgets)
        userDefaults.set(data, forKey: budgetsKey)
    }

    func loadBudgets() -> [Budget] {
        guard let data = userDefaults.data(forKey: budgetsKey) else {
            return ExpenseCategory.allCases.map { Budget(category: $0, limit: 800) }
        }
        return (try? JSONDecoder().decode([Budget].self, from: data)) ?? []
    }

    func saveMonthlyBudget(_ value: Double) {
        userDefaults.set(value, forKey: monthlyBudgetKey)
    }

    func loadMonthlyBudget() -> Double {
        userDefaults.double(forKey: monthlyBudgetKey)
    }

    func saveCalmThreshold(_ value: Double) {
        userDefaults.set(value, forKey: calmThresholdKey)
    }

    func loadCalmThreshold() -> Double {
        userDefaults.double(forKey: calmThresholdKey)
    }

    func saveCalmSeconds(_ value: Int) {
        userDefaults.set(value, forKey: calmSecondsKey)
    }

    func loadCalmSeconds() -> Int {
        userDefaults.integer(forKey: calmSecondsKey)
    }
}
