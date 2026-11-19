
import Foundation
import Combine

@MainActor
class UserViewModel: ObservableObject {

    @Published var users: [User] = []
    @Published var searchText = ""
    @Published var errorMessage = ""

    private let apiURL =
        "https://jsonplaceholder.typicode.com/users"

    var filteredUsers: [User] {
        guard !searchText.isEmpty else {
            return users
        }

        return users.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
            || $0.username.localizedCaseInsensitiveContains(searchText)
        }
    }

    // GET - Obtener usuarios
    func fetchUsers() async {
        guard let url = URL(string: apiURL) else { return }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            try validate(response)

            users = try JSONDecoder().decode(
                [User].self,
                from: data
            )

        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // POST - Agregar usuario
    func addUser(_ user: User) async {
        guard let url = URL(string: apiURL) else { return }

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue(
                "application/json; charset=UTF-8",
                forHTTPHeaderField: "Content-Type"
            )
            request.httpBody = try JSONEncoder().encode(user)

            let (_, response) = try await URLSession.shared.data(
                for: request
            )

            try validate(response)

            var newUser = user
            newUser.id = (users.compactMap { $0.id }.max() ?? 0) + 1
            users.insert(newUser, at: 0)

        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // PUT - Actualizar usuario
    func updateUser(_ user: User) async {
        guard let id = user.id,
              let url = URL(string: "\(apiURL)/\(id)")
        else { return }

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue(
                "application/json; charset=UTF-8",
                forHTTPHeaderField: "Content-Type"
            )
            request.httpBody = try JSONEncoder().encode(user)

            let (_, response) = try await URLSession.shared.data(
                for: request
            )

            try validate(response)

            if let index = users.firstIndex(
                where: { $0.id == id }
            ) {
                users[index] = user
            }

        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // DELETE - Eliminar usuario
    func deleteUser(_ user: User) async {
        guard let id = user.id,
              let url = URL(string: "\(apiURL)/\(id)")
        else { return }

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"

            let (_, response) = try await URLSession.shared.data(
                for: request
            )

            try validate(response)

            users.removeAll { $0.id == id }

        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func validate(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
            throw URLError(.badServerResponse)
        }
    }
}
