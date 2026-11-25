import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSignedIn = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var listener: AuthStateDidChangeListenerHandle?

    var body: some View {
        VStack(spacing: 20) {
            Text("Laboratorio 14: Firebase")
                .font(.largeTitle)
                .bold()
                .padding(.top, 30)

            if isSignedIn {
                MessagesView()
            } else {
                Spacer()

                Image(systemName: "person.crop.circle")
                    .font(.system(size: 75))
                    .foregroundStyle(.blue)

                TextField("Correo electrónico", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)

                SecureField("Contraseña", text: $password)
                    .textFieldStyle(.roundedBorder)

                HStack(spacing: 20) {
                    Button("Iniciar sesión") {
                        signIn()
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Registrarse") {
                        signUp()
                    }
                    .buttonStyle(.bordered)
                }

                Spacer()
            }
        }
        .padding()
        .alert("Aviso", isPresented: $showAlert) {
            Button("Aceptar") {}
        } message: {
            Text(alertMessage)
        }
        .onAppear {
            listener = Auth.auth().addStateDidChangeListener { _, user in
                isSignedIn = user != nil
                if user == nil {
                    email = ""
                    password = ""
                }
            }
        }
        .onDisappear {
            if let listener = listener {
                Auth.auth().removeStateDidChangeListener(listener)
            }
        }
    }

    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            notify("Ingresa tu correo y contraseña")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            notify(error != nil ? "No se pudo iniciar sesión. Verifica tus datos." : "¡Inicio de sesión exitoso!")
        }
    }

    func signUp() {
        guard !email.isEmpty, password.count >= 6 else {
            notify("Ingresa un correo y una contraseña de al menos 6 caracteres")
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            notify(error != nil ? "No se pudo crear la cuenta. Verifica tus datos." : "¡Cuenta creada correctamente!")
        }
    }

    func notify(_ message: String) {
        alertMessage = message
        showAlert = true
    }
}
