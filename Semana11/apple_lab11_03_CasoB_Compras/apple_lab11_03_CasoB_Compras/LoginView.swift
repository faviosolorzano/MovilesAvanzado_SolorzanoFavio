
import SwiftUI
import SwiftData

struct LoginView: View {
    @Environment(\.modelContext) private var context
    @Query private var usuarios: [Usuario]

    @State private var usuario = ""
    @State private var clave = ""
    @State private var usuarioActual: Usuario?
    @State private var mostrarRegistro = false
    @State private var mostrarError = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "cart.fill")
                    .font(.system(size: 65))
                    .foregroundStyle(.blue)

                Text("Sistema de Compras")
                    .font(.title.bold())

                TextField("Usuario", text: $usuario)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()

                SecureField("Contraseña", text: $clave)
                    .textFieldStyle(.roundedBorder)

                Button("Iniciar sesión") {
                    iniciarSesion()
                }
                .buttonStyle(.borderedProminent)

                Button("Registrarse") {
                    mostrarRegistro = true
                }
            }
            .padding(25)
            .navigationDestination(item: $usuarioActual) { usuario in
                InicioView(usuario: usuario)
            }
            .sheet(isPresented: $mostrarRegistro) {
                RegistroView()
            }
            .alert("Error", isPresented: $mostrarError) {
                Button("Aceptar", role: .cancel) {}
            } message: {
                Text("Usuario o contraseña incorrectos")
            }
        }
    }

    private func iniciarSesion() {
        if let encontrado = usuarios.first(where: {
            $0.usuario == usuario && $0.clave == clave
        }) {
            usuarioActual = encontrado
        } else {
            mostrarError = true
        }
    }
}
