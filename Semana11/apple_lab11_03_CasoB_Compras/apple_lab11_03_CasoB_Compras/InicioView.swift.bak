
import SwiftUI
import SwiftData

struct InicioView: View {

    let usuario: Usuario

    private var esSupervisor: Bool {
        usuario.rol.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).lowercased() == "supervisor"
    }

    var body: some View {
        TabView {

            if esSupervisor {

                NavigationStack {
                    ResumenView()
                }
                .tabItem {
                    Label(
                        "Resumen",
                        systemImage: "chart.bar.fill"
                    )
                }

                NavigationStack {
                    AprobacionesView()
                }
                .tabItem {
                    Label(
                        "Aprobar",
                        systemImage: "checkmark.shield.fill"
                    )
                }

                NavigationStack {
                    PorPagarView()
                }
                .tabItem {
                    Label(
                        "Por pagar",
                        systemImage: "creditcard.fill"
                    )
                }

            } else {

                NavigationStack {
                    ComprasView(usuario: usuario)
                }
                .tabItem {
                    Label(
                        "Comprar",
                        systemImage: "cart.fill"
                    )
                }

                NavigationStack {
                    MisComprasView(usuario: usuario)
                }
                .tabItem {
                    Label(
                        "Mis compras",
                        systemImage: "list.bullet"
                    )
                }
            }

            NavigationStack {
                ProductosView(esSupervisor: esSupervisor)
            }
            .tabItem {
                Label(
                    "Productos",
                    systemImage: "shippingbox.fill"
                )
            }

            NavigationStack {
                ProveedoresView(esSupervisor: esSupervisor)
            }
            .tabItem {
                Label(
                    "Proveedores",
                    systemImage: "truck.box"
                )
            }
        }
        .tint(.blue)
    }
}
