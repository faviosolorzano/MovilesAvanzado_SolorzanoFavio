
import SwiftUI
import SwiftData

struct RegistroView: View {

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Query private var usuarios: [Usuario]

    @State private var nombre = ""
    @State private var usuario = ""
    @State private var clave = ""
    @State private var rol = "Comprador"

    @State private var mensaje = ""
    @State private var mostrarAlerta = false
    @State private var registroExitoso = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Datos del usuario") {
                    TextField("Nombre completo", text: $nombre)

                    TextField("Usuario", text: $usuario)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()

                    SecureField("Contraseña", text: $clave)
                }

                Section("Rol del usuario") {
                    Picker("Seleccionar rol", selection: $rol) {
                        Text("Comprador").tag("Comprador")
                        Text("Supervisor").tag("Supervisor")
                    }
                    .pickerStyle(.segmented)
                }

                Section {
                    Button("Registrar usuario") {
                        registrar()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Registro")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cerrar") {
                        dismiss()
                    }
                }
            }
            .alert("Registro", isPresented: $mostrarAlerta) {
                Button("Aceptar") {
                    if registroExitoso {
                        dismiss()
                    }
                }
            } message: {
                Text(mensaje)
            }
        }
    }

    private func registrar() {
        let nombreLimpio = nombre.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let usuarioLimpio = usuario.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !nombreLimpio.isEmpty,
              !usuarioLimpio.isEmpty,
              !clave.isEmpty else {
            mensaje = "Completa todos los campos."
            registroExitoso = false
            mostrarAlerta = true
            return
        }

        guard !usuarios.contains(where: {
            $0.usuario.lowercased() == usuarioLimpio.lowercased()
        }) else {
            mensaje = "El usuario ya existe."
            registroExitoso = false
            mostrarAlerta = true
            return
        }

        let nuevo = Usuario(
            nombre: nombreLimpio,
            usuario: usuarioLimpio,
            clave: clave,
            rol: rol
        )

        context.insert(nuevo)

        do {
            try context.save()
            mensaje = "Usuario registrado correctamente."
            registroExitoso = true
        } catch {
            context.rollback()
            mensaje = "No se pudo guardar el usuario."
            registroExitoso = false
        }

        mostrarAlerta = true
    }
}
