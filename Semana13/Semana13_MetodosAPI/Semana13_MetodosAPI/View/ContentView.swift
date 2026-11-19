
import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = UserViewModel()

    @State private var showingForm = false
    @State private var editingUser: User? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)

                    TextField(
                        "Buscar usuario por nombre",
                        text: $viewModel.searchText
                    )
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()

                    if !viewModel.searchText.isEmpty {
                        Button {
                            viewModel.searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(12)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                .padding(.vertical, 10)

                List {
                    ForEach(viewModel.filteredUsers) { user in
                        VStack(alignment: .leading, spacing: 6) {

                            Text(user.name)
                                .font(.headline)

                            Text("@\(user.username)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)

                            Label(
                                user.email,
                                systemImage: "envelope"
                            )
                            .font(.caption)
                            .foregroundStyle(.blue)
                        }
                        .padding(.vertical, 5)
                        .swipeActions(edge: .trailing) {

                            Button(role: .destructive) {
                                Task {
                                    await viewModel.deleteUser(user)
                                }
                            } label: {
                                Label("Eliminar", systemImage: "trash")
                            }

                            Button {
                                editingUser = user
                                showingForm = true
                            } label: {
                                Label("Editar", systemImage: "pencil")
                            }
                            .tint(.orange)
                        }
                    }
                }
                .listStyle(.plain)
                .overlay {
                    if viewModel.filteredUsers.isEmpty {
                        ContentUnavailableView(
                            "Sin resultados",
                            systemImage: "magnifyingglass",
                            description: Text(
                                "No se encontraron usuarios."
                            )
                        )
                    }
                }
            }
            .navigationTitle("Gestión de usuarios")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        editingUser = nil
                        showingForm = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .task {
                if viewModel.users.isEmpty {
                    await viewModel.fetchUsers()
                }
            }
            .sheet(isPresented: $showingForm) {
                UserFormView(user: editingUser) { savedUser in
                    Task {
                        if editingUser == nil {
                            await viewModel.addUser(savedUser)
                        } else {
                            await viewModel.updateUser(savedUser)
                        }
                    }
                }
            }
            .alert(
                "Error",
                isPresented: Binding(
                    get: { !viewModel.errorMessage.isEmpty },
                    set: {
                        if !$0 {
                            viewModel.errorMessage = ""
                        }
                    }
                )
            ) {
                Button("Aceptar", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}

#Preview {
    ContentView()
}
