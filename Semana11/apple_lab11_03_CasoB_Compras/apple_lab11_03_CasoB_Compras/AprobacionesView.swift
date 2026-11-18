
import SwiftUI
import SwiftData

struct AprobacionesView: View {

    @Environment(\.modelContext) private var context

    @Query(sort: \Compra.fecha, order: .reverse)
    private var compras: [Compra]

    @State private var compraRechazar: Compra?
    @State private var motivo = ""
    @State private var mostrarRechazo = false
    @State private var mostrarError = false
    @State private var mensajeError = ""

    private var pendientes: [Compra] {
        compras.filter { $0.estado == "Pendiente" }
    }

    var body: some View {
        List {
            ForEach(pendientes) { compra in
                VStack(alignment: .leading, spacing: 12) {

                    Text(compra.producto?.nombre ?? "Producto")
                        .font(.headline)

                    Text("Comprador: \(compra.comprador?.nombre ?? "Sin nombre")")

                    Text("Proveedor: \(compra.proveedor?.nombre ?? "Sin proveedor")")

                    Text("Cantidad: \(compra.cantidad)")

                    Text("Total: S/ \(compra.total, specifier: "%.2f")")
                        .fontWeight(.bold)

                    if let producto = compra.producto {
                        let stockNuevo = producto.stock + compra.cantidad

                        let promedioNuevo = (
                            Double(producto.stock) * producto.costoPromedio
                            + Double(compra.cantidad) * compra.costoUnitario
                        ) / Double(stockNuevo)

                        Divider()

                        Text("Vista previa del inventario")
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Text("Stock: \(producto.stock) → \(stockNuevo)")

                        Text(
                            "Costo promedio: S/ \(producto.costoPromedio, specifier: "%.2f") → S/ \(promedioNuevo, specifier: "%.2f")"
                        )
                        .font(.caption)
                    }

                    HStack {
                        Button("Rechazar", role: .destructive) {
                            compraRechazar = compra
                            motivo = ""
                            mostrarRechazo = true
                        }
                        .buttonStyle(.bordered)

                        Spacer()

                        Button("Aprobar") {
                            aprobar(compra)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .overlay {
            if pendientes.isEmpty {
                ContentUnavailableView(
                    "Sin aprobaciones",
                    systemImage: "checkmark.circle",
                    description: Text("No hay compras pendientes")
                )
            }
        }
        .navigationTitle("Aprobaciones")
        .alert("Rechazar compra", isPresented: $mostrarRechazo) {
            TextField("Motivo del rechazo", text: $motivo)

            Button("Cancelar", role: .cancel) {
                compraRechazar = nil
            }

            Button("Confirmar rechazo", role: .destructive) {
                rechazar()
            }
        } message: {
            Text("Es obligatorio indicar el motivo del rechazo.")
        }
        .alert("Aviso", isPresented: $mostrarError) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text(mensajeError)
        }
    }

    private func aprobar(_ compra: Compra) {
        guard compra.estado == "Pendiente",
              let producto = compra.producto else {
            mensajeError = "No se puede aprobar esta compra."
            mostrarError = true
            return
        }

        let stockActual = producto.stock
        let nuevoStock = stockActual + compra.cantidad

        guard nuevoStock > 0 else { return }

        let nuevoPromedio = (
            Double(stockActual) * producto.costoPromedio
            + Double(compra.cantidad) * compra.costoUnitario
        ) / Double(nuevoStock)

        producto.stock = nuevoStock
        producto.costoPromedio = nuevoPromedio
        compra.estado = "Aprobada"

        do {
            try context.save()
        } catch {
            context.rollback()
            mensajeError = "Error al aprobar: \(error.localizedDescription)"
            mostrarError = true
        }
    }

    private func rechazar() {
        let motivoLimpio = motivo.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !motivoLimpio.isEmpty else {
            mensajeError = "Debes escribir un motivo de rechazo."
            mostrarError = true
            return
        }

        guard let compra = compraRechazar,
              compra.estado == "Pendiente" else {
            return
        }

        compra.estado = "Rechazada"
        compra.motivoRechazo = motivoLimpio

        do {
            try context.save()
            compraRechazar = nil
            motivo = ""
        } catch {
            context.rollback()
            mensajeError = "Error al rechazar: \(error.localizedDescription)"
            mostrarError = true
        }
    }
}
