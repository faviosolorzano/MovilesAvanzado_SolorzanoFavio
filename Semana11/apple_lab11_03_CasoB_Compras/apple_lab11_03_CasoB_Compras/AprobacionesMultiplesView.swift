
import SwiftUI
import SwiftData

struct AprobacionesMultiplesView: View {

    @Environment(\.modelContext) private var context

    @Query(sort: \CompraMultiple.fecha, order: .reverse)
    private var compras: [CompraMultiple]

    @State private var mostrarAlerta = false
    @State private var mensaje = ""

    private var pendientes: [CompraMultiple] {
        compras.filter { $0.estado == "Pendiente" }
    }

    var body: some View {
        List {
            if pendientes.isEmpty {
                ContentUnavailableView(
                    "Sin compras pendientes",
                    systemImage: "checkmark.shield",
                    description: Text(
                        "Todas las solicitudes están revisadas."
                    )
                )
            }

            ForEach(pendientes) { compra in
                Section {
                    ForEach(compra.detalles) { detalle in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(
                                    detalle.producto?.nombre
                                        ?? "Producto"
                                )
                                .font(.subheadline.bold())

                                Text(
                                    "\(detalle.proveedor?.nombre ?? "Proveedor") · \(detalle.cantidad) unidades"
                                )
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }

                            Spacer()

                            Text(
                                detalle.subtotal,
                                format: .currency(code: "PEN")
                            )
                        }
                    }

                    HStack(spacing: 12) {
                        Button {
                            decidir(compra, aprobar: true)
                        } label: {
                            Label(
                                "Aprobar",
                                systemImage: "checkmark"
                            )
                        }
                        .buttonStyle(.borderedProminent)

                        Spacer()

                        Button(role: .destructive) {
                            decidir(compra, aprobar: false)
                        } label: {
                            Label(
                                "Rechazar",
                                systemImage: "xmark"
                            )
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding(.vertical, 5)
                } header: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(
                            compra.comprador?.nombre
                                ?? "Comprador"
                        )

                        Text(
                            compra.fecha,
                            format: .dateTime.day().month().year()
                        )
                        .font(.caption)
                    }
                } footer: {
                    Text(
                        "Total: \(compra.total.formatted(.currency(code: "PEN")))"
                    )
                    .fontWeight(.bold)
                }
            }
        }
        .navigationTitle("Aprobaciones")
        .alert("Resultado", isPresented: $mostrarAlerta) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text(mensaje)
        }
    }

    private func decidir(
        _ compra: CompraMultiple,
        aprobar: Bool
    ) {
        guard compra.estado == "Pendiente" else {
            return
        }

        if aprobar {
            // Validar todos los productos primero.
            guard !compra.detalles.isEmpty else {
                mensaje = "La compra no tiene productos."
                mostrarAlerta = true
                return
            }

            for detalle in compra.detalles {
                guard let producto = detalle.producto else {
                    mensaje = "Falta un producto."
                    mostrarAlerta = true
                    return
                }

                let resultado = producto.stock
                    .addingReportingOverflow(detalle.cantidad)

                guard producto.stock >= 0,
                      detalle.cantidad > 0,
                      resultado.overflow == false else {
                    mensaje = "Stock inválido: \(producto.nombre)"
                    mostrarAlerta = true
                    return
                }
            }

            // Actualizar inventario al aprobar.
            for detalle in compra.detalles {
                guard let producto = detalle.producto else {
                    continue
                }

                let anterior = producto.stock
                let nuevo = anterior + detalle.cantidad

                producto.costoPromedio = (
                    Double(anterior) * producto.costoPromedio
                    + Double(detalle.cantidad) * detalle.costoUnitario
                ) / Double(nuevo)

                producto.stock = nuevo
            }

            compra.estado = "Aprobada"
            compra.pagada = !compra.alCredito

        } else {
            compra.estado = "Rechazada"
            compra.pagada = false
            compra.motivoRechazo = "Rechazada por el Supervisor"
        }

        do {
            try context.save()

            mensaje = aprobar
                ? "Compra aprobada. Inventario actualizado."
                : "Compra rechazada correctamente."

        } catch {
            context.rollback()
            mensaje = "Error: \(error.localizedDescription)"
        }

        mostrarAlerta = true
    }
}
