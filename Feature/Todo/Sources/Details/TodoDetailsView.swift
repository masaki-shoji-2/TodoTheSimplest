import Common
import Domain
import SwiftUI
import UICore

public struct TodoDetailsView: View {
    private let store: Store<TodoDetailsDataFlow>

    public init(
        store: Store<TodoDetailsDataFlow>
    ) {
        self.store = store
    }

    public var body: some View {
        List {
            Section(
                header: Text("Task", bundle: .module)
            ) {
                VStack {
                    Text(store.todo.task)
                }
            }
        }
        .navigationTitle("ToDo".localized(.module))
    }
}

#Preview {
    TodoDetailsView(
        store: mockTodoDetailsStore(
            todo: Todo(
                task: "Buy an apple at the supermarket.",
                isCompleted: false
            )
        )
    )
}
