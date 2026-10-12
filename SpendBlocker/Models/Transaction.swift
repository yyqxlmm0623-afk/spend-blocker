import Foundation

struct Budget: Identifiable, Codable {
    var id: UUID
    var category: ExpenseCategory
    var limit: Double

    init(category: ExpenseCategory, limit: Double) {
        self.id = UUID()
        self.category = category
        self.limit = limit
    }
}
