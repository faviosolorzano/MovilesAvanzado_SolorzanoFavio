
import SwiftUI
import SwiftData

struct PorPagarView: View {

    @Environment(\.modelContext) private var context

    // Compras originales
    @Query(sort: \Compra.fecha, order: .reverse)
    private var compras: [Compra]

    // Compras nuevas con varios productos
    @Query(sort: \CompraMultiple.fecha, order: .reverse)
    private var comprasMultiples: [CompraMultiple]

    @State private var filtro = 0
    @State private var error = ""

    // MARK: - Filtros

    private var creditos: [Compra] {
        compras.filter {
            $0.alCredito && $0.estado == "Aprobada"
        }
    }

    private var creditosMultiples: [CompraMultiple] {
        comprasMultiples.filter {
            $0.alCredito && $0.estado == "Aprobada"
        }
    }

    private var filtradas: [Compra] {
        creditos.filter { compra in
            coincideFiltro(
                pagada: compra.pagada,
                vence: compra.vence
            )
        }
    }

    private var filtradasMultiples: [CompraMultiple] {
        creditosMultiples.filter { compra in
            coincideFiltro(
                pagada: compra.pagada,
                vence: compra.vence
            )
        }
    }

    private func coincideFiltro(
        pagada: Bool,
        vence: Date
    ) -> Bool {
        switch filtro {
        case 0:
            return !pagada
        case 1:
            return !pagada && vence < Date()
        default:
            return pagada
        }
    }

    private var totalPendiente: Double {
        let anteriores = creditos
            .filter { !$0.pagada }
            .reduce(0) { $0 + $1.total }

        let nuevas = creditosMultiples
            .filter { !$0.pagada }
            .reduce(0) { $0 + $1.total }

        return anteriores + nuevas
    }

    // MARK: - Pantalla

    var body: some View {
        VStack(spacing: 12) {

            Picker("Estado", selection: $filtro) {
                Text("Pendientes").tag(0)
                Text("Vencidas").tag(1)
                Text("Pagadas").tag(2)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 5) {
                Text("Total por pagar")
                    .foregroundStyle(.secondary)

                Text(
                    totalPendiente,
                    format: .currency(code: "PEN")
                )
                .font(.title.bold())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            List {

                // Compras múltiples
                ForEach(filtradasMultiples) { compra in
                    tarjetaCompraMultiple(compra)
                }

                // Compras originales
                ForEach(filtradas) { compra in
                    tarjetaCompraOriginal(compra)
                }
            }
            .overlay {
                if filtradas.isEmpty && filtradasMultiples.isEmpty {
                    ContentUnavailableView(
                        "Sin registros",
                        systemImage: "creditcard",
                        description: Text(
                            "No hay compras en esta categoría."
                        )
                    )
                }
            }
        }
        .navigationTitle("Por pagar")
        .alert(
            "Error",
            isPresented: Binding(
                get: { !error.isEmpty },
                set: {
                    if !$0 {
                        error = ""
                    }
                }
            )
        ) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text(error)
        }
    }

    // MARK: - Compra múltiple

    private func tarjetaCompraMultiple(
        _ compra: CompraMultiple
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack {
                Label(
                    "Compra de varios productos",
                    systemImage: "cart.fill"
                )
                .font(.headline)

                Spacer()

                Text("\(compra.detalles.count) productos")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Divider()

            ForEach(compra.detalles) { detalle in
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(
                            detalle.producto?.nombre ?? "Producto"
                        )
                        .font(.subheadline.bold())

                        Text(
                            "Proveedor: \(detalle.proveedor?.nombre ?? "Sin proveedor")"
                        )
                        .font(.caption)
                        .foregroundStyle(.secondary)

                        Text("\(detalle.cantidad) unidades")
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

            Divider()

            Text(
                "Comprador: \(compra.comprador?.nombre ?? "Sin comprador")"
            )
            .font(.subheadline)

            Text(
                "Vence: \(compra.vence.formatted(date: .abbreviated, time: .omitted))"
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)

            Text(
                compra.total,
                format: .currency(code: "PEN")
            )
            .font(.title3.bold())
            .foregroundStyle(.blue)

            etiquetaEstado(
                pagada: compra.pagada,
                vence: compra.vence
            )
        }
        .padding(.vertical, 8)
        .swipeActions(edge: .trailing) {
            if !compra.pagada {
                Button {
                    pagarMultiple(compra)
                } label: {
                    Label("Pagar", systemImage: "checkmark")
                }
                .tint(.green)
            }
        }
    }

    // MARK: - Compra original

    private func tarjetaCompraOriginal(
        _ compra: Compra
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {

            Text(compra.producto?.nombre ?? "Producto")
                .font(.headline)

            Text(
                "Proveedor: \(compra.proveedor?.nombre ?? "Sin proveedor")"
            )

            Text(
                "Comprador: \(compra.comprador?.nombre ?? "Sin comprador")"
            )

            Text(
                "Vence: \(compra.vence.formatted(date: .abbreviated, time: .omitted))"
            )

            Text(
                compra.total,
                format: .currency(code: "PEN")
            )
            .fontWeight(.bold)

            etiquetaEstado(
                pagada: compra.pagada,
                vence: compra.vence
            )
        }
        .padding(.vertical, 6)
        .swipeActions(edge: .trailing) {
            if !compra.pagada {
                Button {
                    pagarOriginal(compra)
                } label: {
                    Label("Pagar", systemImage: "checkmark")
                }
                .tint(.green)
            }
        }
    }

    // MARK: - Estado

    private func etiquetaEstado(
        pagada: Bool,
        vence: Date
    ) -> some View {
        Group {
            if pagada {
                Label(
                    "PAGADA",
                    systemImage: "checkmark.circle.fill"
                )
                .foregroundStyle(.green)

            } else if vence < Date() {
                Label(
                    "VENCIDA",
                    systemImage: "exclamationmark.triangle.fill"
                )
                .foregroundStyle(.red)

            } else {
                Label(
                    "PENDIENTE",
                    systemImage: "clock"
                )
                .foregroundStyle(.orange)
            }
        }
        .font(.subheadline.bold())
    }

    // MARK: - Registrar pagos

    private func pagarOriginal(_ compra: Compra) {
        guard compra.estado == "Aprobada",
              compra.alCredito,
              !compra.pagada else {
            return
        }

        compra.pagada = true
        guardarCambios()
    }

    private func pagarMultiple(_ compra: CompraMultiple) {
        guard compra.estado == "Aprobada",
              compra.alCredito,
              !compra.pagada else {
            return
        }

        compra.pagada = true
        guardarCambios()
    }

    private func guardarCambios() {
        do {
            try context.save()
        } catch {
            context.rollback()
            self.error = error.localizedDescription
        }
    }
}
