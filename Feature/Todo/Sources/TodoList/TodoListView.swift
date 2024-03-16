import Common
import Domain
import SwiftUI
import Swinject
import UICore

public struct TodoListView: View {
    private let navigator: Navigator
    private let store: Store<TodoDataFlow>

    public init(
        navigator: Navigator,
        store: Store<TodoDataFlow>
    ) {
        self.navigator = navigator
        self.store = store
    }

    public var body: some View {
        NavigationStack {
            List {
                ForEach(store.todos) { todo in
                    NavigationLink(
                        destination: navigator.navigate(.todo(.detail(todo)))
                            .onDisappear {
                                store.dispatch(.lifecycle(.onLoad))
                            }
                    ) {
                        TodoCell(
                            todo: todo,
                            onDeleteIconTap: { store.dispatch(.deleteIconTapped(todo: $0)) }
                        )
                    }
                }
                .confirmationDialog(
                    "Are you sure you want to delete this task?".localized(.module),
                    isPresented: store.binding(
                        referTo: { $0.showActionSheet },
                        onChange: { _ in store.dispatch(.dismissActionSheet) }
                    ),
                    titleVisibility: .visible,
                    presenting: store.selectedTodo
                ) { todo in
                    Button("Delete".localized(.module), role: .destructive) {
                        store.dispatch(.todoCellDeleted(todoId: todo.id))
                    }
                    Button("Cancel".localized(.module), role: .cancel) {}
                }
            }
            .navigationTitle("To Do".localized(.module))
            .toolbar {
                Button(action: {
                    store.dispatch(.addTodoButtonTapped)
                }) {
                    Image(systemName: "plus")
                }
            }
            .animation(.default, value: store.todos)
        }
        .sheet(
            isPresented: store.binding(
                referTo: { $0.showEditView },
                onChange: { store.dispatch(.sheetVisibilityChanged(isPresented: $0)) }
            )
        ) {
            navigator.navigate(.todo(.edit()))
                .presentationDetents([.large])
        }
        .onAppear {
            print("TodoListView#onAppear")
        }
        .onLoad {
            print("TodoListView#onLoad")
            store.dispatch(.lifecycle(.onLoad))
        }
    }
}

#Preview {
    TodoListView(
        navigator: MockNavigator(),
        store: mockTodoStore()
    )
}

public struct TodoCell: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var animationToggle: Bool = false
    public let todo: Todo
    public let onDeleteIconTap: (Todo) -> Void

    public init(
        todo: Todo,
        onDeleteIconTap: @escaping (Todo) -> Void
    ) {
        self.todo = todo
        self.onDeleteIconTap = onDeleteIconTap
    }

    public var body: some View {
        HStack {
            Text("\(todo.task)")
                .font(.headline)
                .lineLimit(1)
            Spacer()
            Image(systemName: colorScheme == .light ? "trash" : "trash.fill")
                .symbolEffect(.bounce, value: animationToggle)
                .onTapGesture {
                    animationToggle.toggle()
                    onDeleteIconTap(todo)
                }
        }
        .padding(.all, 8)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TodoCell(
        todo: Todo(task: "English exam", isCompleted: false),
        onDeleteIconTap: { _ in }
    )
}
