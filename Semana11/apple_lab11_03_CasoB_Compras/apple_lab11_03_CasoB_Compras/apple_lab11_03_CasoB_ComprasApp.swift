
import SwiftUI
import SwiftData

@main
struct apple_lab11_03_CasoB_ComprasApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            Usuario.self,
            Proveedor.self,
            Producto.self,
            Compra.self
        ])
    }
}
