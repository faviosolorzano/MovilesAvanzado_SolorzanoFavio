
import SwiftUI

struct UserFormView: View {

    @Environment(\.dismiss) private var dismiss

    var user: User?
    var onSave: (User) -> Void

    @State private var name = ""
    @State private var username = ""
    @State private var email = ""

    private var isEditing: Bool {
        user != nil
    }

    private var validForm: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty
        && !username.trimmingCharacters(in: .whitespaces).isEmpty
        && !email.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Información del usuario") {

                    TextField("Nombre completo", text: $name)

                    TextField(
                        "Nombre de usuario",
                        text: $username
                    )
                    .textInputAutocapitalization(.never)

                    TextField(
                        "Correo electrónico",
                        text: $email
                    )
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                }
            }
            .navigationTitle(
                isEditing ? "Editar usuario" : "Nuevo usuario"
            )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        let savedUser = User(
                            id: user?.id,
                            name: name,
                            username: username,
                            email: email
                        )

                        onSave(savedUser)
                        dismiss()
                    }
                    .disabled(!validForm)
                }
            }
            .onAppear {
                if let user = user {
                    name = user.name
                    username = user.username
                    email = user.email
                }
            }
        }
    }
}

