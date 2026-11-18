
import SwiftUI
import SwiftData
import Charts

struct ResumenView: View {
    @Query private var productos: [Producto]
    @Query private var compras: [Compra]
    @Query private var proveedores: [Proveedor]

    private var aprobadas: [Compra] {
        compras.filter { $0.estado == "Aprobada" }
    }

    private var pendientes: [Compra] {
        compras.filter { $0.estado == "Pendiente" }
    }

    private var inventario: Double {
        productos.reduce(0) {
            $0 + Double($1.stock) * $1.costoPromedio
        }
    }

    private var creditoFiscal: Double {
        aprobadas.reduce(0) { $0 + $1.igv }
    }

    private var importePendiente: Double {
        pendientes.reduce(0) { $0 + $1.total }
    }

    private var datosProveedores: [(nombre: String, total: Double)] {
        proveedores.map { proveedor in
            (
                nombre: proveedor.nombre,
                total: aprobadas
                    .filter { $0.proveedor?.persistentModelID == proveedor.persistentModelID }
                    .reduce(0) { $0 + $1.total }
            )
        }
        .filter { $0.total > 0 }
        .sorted { $0.total > $1.total }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                tarjeta(
                    titulo: "Valor del inventario",
                    valor: inventario,
                    icono: "shippingbox.fill",
                    color: .blue
                )

                tarjeta(
                    titulo: "Crédito fiscal (IGV)",
                    valor: creditoFiscal,
                    icono: "percent",
                    color: .green
                )

                tarjeta(
                    titulo: "Compras por aprobar: \(pendientes.count)",
                    valor: importePendiente,
                    icono: "clock.fill",
                    color: .orange
                )

                VStack(alignment: .leading, spacing: 12) {
                    Text("Compras por proveedor")
                        .font(.headline)

                    if datosProveedores.isEmpty {
                        ContentUnavailableView(
                            "Sin compras aprobadas",
                            systemImage: "chart.bar"
                        )
                    } else {
                        Chart {
                            ForEach(datosProveedores, id: \.nombre) { dato in
                                BarMark(
                                    x: .value("Proveedor", dato.nombre),
                                    y: .value("Total", dato.total)
                                )
                                .foregroundStyle(.blue)
                            }
                        }
                        .frame(height: 250)
                    }
                }
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 14))
            }
            .padding()
        }
        .navigationTitle("Resumen")
    }

    private func tarjeta(
        titulo: String,
        valor: Double,
        icono: String,
        color: Color
    ) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icono)
                .font(.title2)
                .foregroundStyle(color)
                .frame(width: 44, height: 44)
                .background(color.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 5) {
                Text(titulo)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(valor, format: .currency(code: "PEN"))
                    .font(.title2.bold())
            }

            Spacer()
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 14))
    }
}
