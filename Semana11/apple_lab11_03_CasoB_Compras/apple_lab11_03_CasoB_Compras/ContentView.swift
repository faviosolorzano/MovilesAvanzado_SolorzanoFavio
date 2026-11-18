
import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        LoginView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [
            Usuario.self,
            Proveedor.self,
            Producto.self,
            Compra.self
        ], inMemory: true)
}
