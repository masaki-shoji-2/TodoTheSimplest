import Common
import Domain
import SwiftUI
import UICore

public struct SettingsView: View {
    private let store: Store<SettingsDataFlow>

    public init(store: Store<SettingsDataFlow>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack {
            List {
                Section(header: Text("App Version".localized(.module))) {
                    Text("\(store.appConfig.versionName)")
                }
            }
            .navigationTitle("Settings".localized(.module))
        }
    }
}

#Preview {
    SettingsView(store: mockSettingsStore())
}
