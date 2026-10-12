import Foundation

struct Transaction: Identifiable, Codable {
    var id: UUID
    var title: String
    var amount: Double
    var category: ExpenseCategory
    var date: Date
    var note: String

    init(title: String, amount: Double, category: ExpenseCategory, date: Date = Date(), note: String = "") {
        self.id = UUID()
        self.title = title
        self.amount = amount
        self.category = category
        self.date = date
        self.note = note
    }
}
