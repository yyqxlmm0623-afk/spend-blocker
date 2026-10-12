import Foundation

enum ExpenseCategory: String, CaseIterable, Codable {
    case food = "餐饮"
    case shopping = "购物"
    case transport = "交通"
    case entertainment = "娱乐"
    case bills = "账单"
    case health = "健康"
    case other = "其他"

    var icon: String {
        switch self {
        case .food:
            return "fork.knife"
        case .shopping:
            return "bag"
        case .transport:
            return "car"
        case .entertainment:
            return "gamecontroller"
        case .bills:
            return "doc.text"
        case .health:
            return "cross.case"
        case .other:
            return "ellipsis.circle"
        }
    }
}
