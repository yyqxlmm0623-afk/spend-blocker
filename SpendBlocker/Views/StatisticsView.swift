import SwiftUI

struct CalmPeriodView: View {
    let amount: Double
    @ObservedObject var store: ExpenseStore
    let onConfirm: () -> Void

    @State private var remainingSeconds = 10
    @State private var isConfirmed = false

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "clock.fill")
                .font(.system(size: 48))
                .foregroundStyle(.orange)

            Text("购买冷静期")
                .font(.title2)
                .fontWeight(.bold)

            Text("你准备花 ¥\(String(format: "%.0f", amount))，先停 10 秒再决定。")
                .multilineTextAlignment(.center)

            Text("剩余时间: \(remainingSeconds)s")
                .font(.title3)
                .foregroundStyle(.secondary)

            ProgressView(value: Double(10 - remainingSeconds) / 10.0)
                .tint(.orange)

            HStack(spacing: 12) {
                Button("取消") {
                    isConfirmed = false
                }
                .buttonStyle(.bordered)

                Button("我确认要买") {
                    isConfirmed = true
                    onConfirm()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .onAppear {
            let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if remainingSeconds > 0 {
                    remainingSeconds -= 1
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    CalmPeriodView(amount: 250, store: ExpenseStore(), onConfirm: {})
}
