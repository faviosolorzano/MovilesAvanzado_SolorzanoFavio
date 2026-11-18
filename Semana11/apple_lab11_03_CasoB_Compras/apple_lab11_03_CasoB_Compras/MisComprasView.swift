
import SwiftUI
import SwiftData

struct MisComprasView: View {

    let usuario: Usuario

    @Query(sort: \Compra.fecha, order: .reverse)
    private var compras: [Compra]

    @State private var filtro = "Todas"

    private let filtros = ["Todas", "Pendientes", "Rechazadas"]

    private var comprasFiltradas: [Compra] {
        compras.filter { compra in
            guard compra.comprador?.persistentModelID ==
                    usuario.persistentModelID else {
                return false
            }

            switch filtro {
            case "Pendientes":
                return compra.estado == "Pendiente"
            case "Rechazadas":
                return compra.estado == "Rechazada"
            default:
                return true
            }
        }
    }

    var body: some View {
        VStack(spacing: 12) {

            Picker("Filtrar compras", selection: $filtro) {
                ForEach(filtros, id: \.self) { opcion in
                    Text(opcion).tag(opcion)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            List {
                ForEach(comprasFiltradas) { compra in
                    VStack(alignment: .leading, spacing: 8) {

                        HStack {
                            Text(compra.producto?.nombre ?? "Producto")
                                .font(.headline)

                            Spacer()

                            Text(compra.estado)
                                .font(.caption)
                                .foregroundStyle(
                                    compra.estado == "Aprobada" ? .green :
                                    compra.estado == "Pendiente" ? .orange :
                                    .red
                                )
                        }

                        Text("Proveedor: \(compra.proveedor?.nombre ?? "Sin proveedor")")

                        Text("Cantidad: \(compra.cantidad)")

                        Text("Total: S/ \(compra.total, specifier: "%.2f")")
                            .fontWeight(.semibold)

                        Text(compra.fecha, style: .date)
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        if compra.estado == "Rechazada" {
                            Text("Motivo: \(compra.motivoRechazo ?? "No especificado")")
                                .foregroundStyle(.red)
                        }

                        if compra.estado == "Aprobada" {
                            Text(compra.pagada ? "Pagada" : "Por pagar")
                                .font(.caption)
                                .foregroundStyle(
                                    compra.pagada ? .green : .orange
                                )
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            .overlay {
                if comprasFiltradas.isEmpty {
                    ContentUnavailableView(
                        "Sin compras",
                        systemImage: "cart",
                        description: Text("No hay compras para mostrar")
                    )
                }
            }
        }
        .navigationTitle("Mis compras")
    }
}
