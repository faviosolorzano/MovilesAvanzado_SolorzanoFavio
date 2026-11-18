
import SwiftUI
import SwiftData

struct MisComprasMultiplesView: View {

    let usuario: Usuario

    @Query(sort: \CompraMultiple.fecha, order: .reverse)
    private var compras: [CompraMultiple]

    private var misCompras: [CompraMultiple] {
        compras.filter {
            $0.comprador?.persistentModelID
                == usuario.persistentModelID
        }
    }

    var body: some View {
        List {
            if misCompras.isEmpty {
                ContentUnavailableView(
                    "Sin compras",
                    systemImage: "cart",
                    description: Text(
                        "Tus compras registradas aparecerán aquí."
                    )
                )
            }

            ForEach(misCompras) { compra in
                Section {
                    ForEach(compra.detalles) { detalle in
                        HStack(spacing: 12) {
                            Image(systemName: "shippingbox")
                                .foregroundStyle(.blue)

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
                            .font(.subheadline)
                        }
                    }

                    HStack {
                        Label(
                            compra.alCredito ? "Crédito" : "Contado",
                            systemImage: "creditcard"
                        )

                        Spacer()

                        Text(
                            compra.pagada ? "Pagada" : "No pagada"
                        )
                        .foregroundStyle(
                            compra.pagada
                                ? Color.green
                                : Color.secondary
                        )
                    }
                    .font(.caption)
                } header: {
                    HStack {
                        Text(
                            compra.fecha,
                            format: .dateTime.day().month().year()
                        )

                        Spacer()

                        Text(compra.estado)
                            .foregroundStyle(
                                compra.estado == "Aprobada"
                                    ? Color.green
                                    : compra.estado == "Pendiente"
                                        ? Color.orange
                                        : Color.red
                            )
                    }
                } footer: {
                    HStack {
                        Text("\(compra.detalles.count) productos")

                        Spacer()

                        Text(
                            "Total: \(compra.total.formatted(.currency(code: "PEN")))"
                        )
                        .fontWeight(.bold)
                    }
                }
            }
        }
        .navigationTitle("Mis compras")
    }
}
