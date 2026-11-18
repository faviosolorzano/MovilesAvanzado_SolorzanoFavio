
import SwiftUI
import SwiftData

struct ComprasView: View {
    let usuario: Usuario

    @Environment(\.modelContext) private var context
    @Query(sort: \Proveedor.nombre) private var proveedores: [Proveedor]
    @Query(sort: \Producto.nombre) private var productos: [Producto]

    @State private var proveedorID: PersistentIdentifier?
    @State private var productoID: PersistentIdentifier?
    @State private var cantidad = 1
    @State private var costoUnitario = ""
    @State private var alCredito = false
    @State private var mensaje = ""
    @State private var mostrarAlerta = false

    private var proveedor: Proveedor? {
        proveedores.first { $0.persistentModelID == proveedorID }
    }

    private var producto: Producto? {
        productos.first { $0.persistentModelID == productoID }
    }

    private var costo: Double {
        Double(costoUnitario.replacingOccurrences(of: ",", with: ".")) ?? 0
    }

    private var subtotal: Double {
        Double(cantidad) * costo
    }

    private var igv: Double {
        subtotal * 0.18
    }

    private var total: Double {
        subtotal + igv
    }

    var body: some View {
        Form {
            Section("Proveedor") {
                Picker("Seleccionar proveedor", selection: $proveedorID) {
                    Text("Seleccionar").tag(nil as PersistentIdentifier?)
                    ForEach(proveedores) { proveedor in
                        Text(proveedor.nombre)
                            .tag(Optional(proveedor.persistentModelID))
                    }
                }
            }

            Section("Producto") {
                Picker("Seleccionar producto", selection: $productoID) {
                    Text("Seleccionar").tag(nil as PersistentIdentifier?)
                    ForEach(productos) { producto in
                        Text(producto.nombre)
                            .tag(Optional(producto.persistentModelID))
                    }
                }
            }

            Section("Datos de compra") {
                Stepper("Cantidad: \(cantidad)", value: $cantidad, in: 1...10000)

                TextField("Costo unitario", text: $costoUnitario)
                    .keyboardType(.decimalPad)

                Toggle("Crédito a 30 días", isOn: $alCredito)
            }

            Section("Resumen") {
                LabeledContent("Subtotal", value: subtotal, format: .currency(code: "PEN"))
                LabeledContent("IGV (18 %)", value: igv, format: .currency(code: "PEN"))
                LabeledContent("Total", value: total, format: .currency(code: "PEN"))

                if total >= 5000 {
                    Text("Requiere aprobación del supervisor")
                        .foregroundStyle(.orange)
                }
            }

            Section {
                Button(total >= 5000 ? "Enviar a aprobación" : "Registrar compra") {
                    registrarCompra()
                }
                .frame(maxWidth: .infinity)
                .disabled(proveedor == nil || producto == nil || costo <= 0)
            }
        }
        .navigationTitle("Nueva compra")
        .alert("Resultado", isPresented: $mostrarAlerta) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text(mensaje)
        }
    }

    private func registrarCompra() {
        guard let proveedor, let producto, costo > 0 else {
            mensaje = "Completa los datos de la compra"
            mostrarAlerta = true
            return
        }

        let compra = Compra(
            cantidad: cantidad,
            costoUnitario: costo,
            alCredito: alCredito,
            comprador: usuario,
            proveedor: proveedor,
            producto: producto
        )

        context.insert(compra)

        if compra.estado == "Aprobada" {
            let stockAnterior = producto.stock
            let stockNuevo = stockAnterior + cantidad

            producto.costoPromedio = (
                Double(stockAnterior) * producto.costoPromedio
                + Double(cantidad) * costo
            ) / Double(stockNuevo)

            producto.stock = stockNuevo
        }

        do {
            try context.save()

            mensaje = compra.estado == "Pendiente"
                ? "Compra enviada a aprobación"
                : "Compra registrada correctamente"

            cantidad = 1
            costoUnitario = ""
            alCredito = false
            proveedorID = nil
            productoID = nil
        } catch {
            context.rollback()
            mensaje = "Error al guardar la compra: \(error.localizedDescription)"
        }

        mostrarAlerta = true
    }
}
