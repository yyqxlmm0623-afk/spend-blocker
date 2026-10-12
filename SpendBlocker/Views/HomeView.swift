import SwiftUI

struct ContentView: View {
    @StateObject private var store = ExpenseStore()

    var body: some View {
        TabView {
            HomeView(store: store)
                .tabItem {
                    Label("首页", systemImage: "house")
                }

            StatisticsView(store: store)
                .tabItem {
                    Label("统计", systemImage: "chart.bar")
                }

            SettingsView(store: store)
                .tabItem {
                    Label("设置", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    ContentView()
}
