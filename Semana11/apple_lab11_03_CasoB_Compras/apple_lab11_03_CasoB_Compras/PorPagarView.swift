
import SwiftUI
import SwiftData

struct PorPagarView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Compra.fecha, order: .reverse)
    private var compras: [Compra]

    @State private var filtro = 0
    @State private var error = ""

    private var creditos: [Compra] {
        compras.filter {
            $0.alCredito && $0.estado == "Aprobada"
        }
    }

    private var filtradas: [Compra] {
        creditos.filter { compra in
            switch filtro {
            case 0:
                return !compra.pagada
            case 1:
                return !compra.pagada && compra.vence < Date()
            default:
                return compra.pagada
            }
        }
    }

    private var totalPendiente: Double {
        creditos.filter { !$0.pagada }
            .reduce(0) { $0 + $1.total }
    }

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

                Text(totalPendiente, format: .currency(code: "PEN"))
                    .font(.title.bold())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            List {
                ForEach(filtradas) { compra in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(compra.producto?.nombre ?? "Producto")
                            .font(.headline)

                        Text("Proveedor: \(compra.proveedor?.nombre ?? "Sin proveedor")")

                        Text("Comprador: \(compra.comprador?.nombre ?? "Sin comprador")")

                        Text("Vence: \(compra.vence.formatted(date: .abbreviated, time: .omitted))")

                        Text(compra.total, format: .currency(code: "PEN"))
                            .fontWeight(.bold)

                        if compra.pagada {
                            Label("PAGADA", systemImage: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                        } else if compra.vence < Date() {
                            Label("VENCIDA", systemImage: "exclamationmark.triangle.fill")
                                .foregroundStyle(.red)
                        } else {
                            Label("PENDIENTE", systemImage: "clock")
                                .foregroundStyle(.orange)
                        }
                    }
                    .padding(.vertical, 6)
                    .swipeActions(edge: .trailing) {
                        if !compra.pagada {
                            Button {
                                pagar(compra)
                            } label: {
                                Label("Pagar", systemImage: "checkmark")
                            }
                            .tint(.green)
                        }
                    }
                }
            }
            .overlay {
                if filtradas.isEmpty {
                    ContentUnavailableView(
                        "Sin registros",
                        systemImage: "creditcard",
                        description: Text("No hay compras en esta categoría.")
                    )
                }
            }
        }
        .navigationTitle("Por pagar")
        .alert("Error", isPresented: Binding(
            get: { !error.isEmpty },
            set: { if !$0 { error = "" } }
        )) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text(error)
        }
    }

    private func pagar(_ compra: Compra) {
        guard compra.estado == "Aprobada",
              compra.alCredito,
              !compra.pagada else { return }

        compra.pagada = true

        do {
            try context.save()
        } catch {
            context.rollback()
            self.error = error.localizedDescription
        }
    }
}
