import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

struct Message: Identifiable, Codable {
    let id: String
    let text: String
    let userEmail: String
    let timestamp: Date
}

class DatabaseService: ObservableObject {
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?

    @Published var messages: [Message] = []
    @Published var errorMessage = ""

    func addMessage(text: String) {
        guard let user = Auth.auth().currentUser else { return }

        let message = Message(
            id: UUID().uuidString,
            text: text,
            userEmail: user.email ?? "Desconocido",
            timestamp: Date()
        )

        do {
            try db.collection("messages")
                .document(message.id)
                .setData(from: message) { error in
                    if let error = error {
                        DispatchQueue.main.async {
                            self.errorMessage = "Error al acceder a la base de datos."
                        }
                    }
                }
        } catch {
            errorMessage = "Error al acceder a la base de datos."
        }
    }

    func startListening() {
        listener?.remove()

        listener = db.collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.errorMessage = "Error al acceder a la base de datos."
                        return
                    }

                    self.messages = snapshot?.documents.compactMap {
                        try? $0.data(as: Message.self)
                    } ?? []
                }
            }
    }

    func stopListening() {
        listener?.remove()
        listener = nil
    }
}
