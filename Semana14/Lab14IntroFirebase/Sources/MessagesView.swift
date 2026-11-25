import SwiftUI
import FirebaseAuth

struct MessagesView: View {
    @StateObject private var databaseService = DatabaseService()
    @State private var newMessage = ""

    var body: some View {
        VStack {
            HStack {
                Text("Mensajes")
                    .font(.title2)
                    .bold()

                Spacer()

                Button("Cerrar sesión") {
                    do {
                        try Auth.auth().signOut()
                    } catch {
                        databaseService.errorMessage =
                            "No se pudo cerrar sesión."
                    }
                }
                .foregroundStyle(.red)
            }
            .padding(.vertical)

            List(databaseService.messages) { message in
                VStack(alignment: .leading, spacing: 6) {
                    Text(message.text)

                    HStack {
                        Text(message.userEmail)
                        Spacer()
                        Text(message.timestamp, style: .time)
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
                .padding(.vertical, 5)
            }
            .listStyle(.plain)

            if !databaseService.errorMessage.isEmpty {
                Text(databaseService.errorMessage)
                    .font(.caption)
                    .foregroundStyle(.red)
            }

            HStack {
                TextField("Escribe un mensaje...", text: $newMessage)
                    .textFieldStyle(.roundedBorder)

                Button("Enviar") {
                    databaseService.addMessage(text: newMessage)
                    newMessage = ""
                }
                .buttonStyle(.borderedProminent)
                .disabled(newMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .onAppear {
            databaseService.startListening()
        }
        .onDisappear {
            databaseService.stopListening()
        }
    }
}
