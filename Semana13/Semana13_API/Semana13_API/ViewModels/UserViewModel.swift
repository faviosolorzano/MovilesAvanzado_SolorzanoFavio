
import Foundation
import Combine

class UserViewModel: ObservableObject {

    // Lista de usuarios obtenidos de la API
    @Published var users: [User] = []

    // Texto ingresado en el buscador
    @Published var searchText: String = ""

    // Filtrar usuarios por nombre
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter { user in
                user.name.lowercased().contains(
                    searchText.lowercased()
                )
            }
        }
    }

    // Obtener usuarios desde la API
    func fetchUsers() {

        guard let url = URL(
            string: "https://jsonplaceholder.typicode.com/users"
        ) else {
            print("URL inválida")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let data = data {
                do {
                    let decodedUsers = try JSONDecoder().decode(
                        [User].self,
                        from: data
                    )

                    DispatchQueue.main.async {
                        self.users = decodedUsers
                    }

                } catch {
                    print("Error al decodificar: \(error)")
                }

            } else if let error = error {
                print("Error de red: \(error)")
            }

        }.resume()
    }
}
