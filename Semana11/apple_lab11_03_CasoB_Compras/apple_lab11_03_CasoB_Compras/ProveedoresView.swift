
import SwiftUI
import SwiftData

struct ProveedoresView: View {

    var esSupervisor: Bool = false

    @Environment(\.modelContext) private var context
    @Query(sort: \Proveedor.nombre)
    private var proveedores: [Proveedor]

    @State private var nombre = ""
    @State private var ruc = ""

    @State private var mostrarFormulario = false
    @State private var mostrarError = false
    @State private var mensajeError = ""

    var body: some View {
        List {
            if proveedores.isEmpty {
                ContentUnavailableView(
                    "Sin proveedores",
                    systemImage: "truck.box",
                    description: Text(
                        esSupervisor
                        ? "Presiona + para registrar un proveedor."
                        : "No hay proveedores registrados."
                    )
                )
            } else {
                ForEach(proveedores) { proveedor in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(proveedor.nombre)
                            .font(.headline)

                        Text("RUC: \(proveedor.ruc)")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 5)
                }
                .onDelete(perform: eliminar)
                .deleteDisabled(!esSupervisor)
            }
        }
        .navigationTitle("Proveedores")
        .toolbar {
            if esSupervisor {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        mostrarFormulario = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $mostrarFormulario) {
            NavigationStack {
                Form {
                    Section("Datos del proveedor") {
                        TextField("Nombre", text: $nombre)

                        TextField("RUC", text: $ruc)
                            .keyboardType(.numberPad)
                    }

                    Button("Guardar proveedor") {
                        guardar()
                    }
                    .frame(maxWidth: .infinity)
                }
                .navigationTitle("Nuevo proveedor")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") {
                            mostrarFormulario = false
                        }
                    }
                }
            }
        }
        .alert("Aviso", isPresented: $mostrarError) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text(mensajeError)
        }
    }

    private func guardar() {
        guard esSupervisor else { return }

        let nombreLimpio = nombre.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let rucLimpio = ruc.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !nombreLimpio.isEmpty,
              rucLimpio.count == 11,
              rucLimpio.allSatisfy({ $0.isNumber }) else {
            mensajeError = "Ingresa un nombre y un RUC de 11 dígitos."
            mostrarError = true
            return
        }

        guard !proveedores.contains(where: {
            $0.ruc == rucLimpio
        }) else {
            mensajeError = "Este RUC ya está registrado."
            mostrarError = true
            return
        }

        let proveedor = Proveedor(
            nombre: nombreLimpio,
            ruc: rucLimpio
        )

        context.insert(proveedor)

        do {
            try context.save()

            nombre = ""
            ruc = ""
            mostrarFormulario = false
        } catch {
            context.rollback()
            mensajeError = "No se pudo guardar el proveedor."
            mostrarError = true
        }
    }

    private func eliminar(at offsets: IndexSet) {
        guard esSupervisor else { return }

        for indice in offsets {
            context.delete(proveedores[indice])
        }

        do {
            try context.save()
        } catch {
            context.rollback()
            mensajeError = "No se pudo eliminar el proveedor."
            mostrarError = true
        }
    }
}
