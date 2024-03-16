import Common
import Domain
import SwiftUI
import UICore

public struct TodoEditView: View {
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: Bool
    private let store: Store<TodoEditDataFlow>

    public init(
        store: Store<TodoEditDataFlow>
    ) {
        self.store = store
    }

    public var body: some View {
        NavigationStack {
            Form {
                Section(
                    header: Text("To Do", bundle: .module)
                ) {
                    TextField(
                        "Input a task description.".localized(.module),
                        text: store.binding(
                            referTo: { $0.todo.task },
                            onChange: { store.dispatch(.textInput(text: $0)) }
                        ),
                        axis: .vertical
                    )
                    .frame(
                        height: 200,
                        alignment: .top
                    )
                    .focused($isFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isFocused = true
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel".localized(.module)) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save".localized(.module)) {
                        store.dispatch(.addButtonTapped)
                    }
                }
            }
        }
        .onChange(of: store.dismiss) {
            if store.dismiss {
                dismiss()
            }
        }
    }
}

#Preview {
    TodoEditView(
        store: mockTodoEditStore()
    )
}
