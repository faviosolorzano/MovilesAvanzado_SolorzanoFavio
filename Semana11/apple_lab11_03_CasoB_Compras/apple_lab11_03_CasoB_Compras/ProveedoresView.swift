
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
        VStack(spacing: 0) {

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Proveedores")
                        .font(.largeTitle.bold())

                    Text("\(proveedores.count) registrados")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if esSupervisor {
                    Button {
                        nombre = ""
                        ruc = ""
                        mostrarFormulario = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3.bold())
                            .foregroundStyle(.white)
                            .frame(width: 46, height: 46)
                            .background(.blue)
                            .clipShape(Circle())
                    }
                    .accessibilityLabel("Agregar proveedor")
                }
            }
            .padding()

            if proveedores.isEmpty {
                Spacer()

                ContentUnavailableView(
                    "No hay proveedores",
                    systemImage: "building.2",
                    description: Text(
                        esSupervisor
                        ? "Presiona + para agregar un proveedor."
                        : "No hay proveedores registrados."
                    )
                )

                Spacer()
            } else {
                List {
                    ForEach(proveedores) { proveedor in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(proveedor.nombre)
                                .font(.headline)

                            Text("RUC: \(proveedor.ruc)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 6)
                    }
                    .onDelete(perform: eliminar)
                    .deleteDisabled(!esSupervisor)
                }
                .listStyle(.plain)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $mostrarFormulario) {
            formularioProveedor
        }
        .alert("Aviso", isPresented: $mostrarError) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text(mensajeError)
        }
    }

    private var formularioProveedor: some View {
        NavigationStack {
            Form {
                Section("Información del proveedor") {
                    TextField("Razón social", text: $nombre)
                        .textInputAutocapitalization(.words)

                    HStack {
                        Text("RUC")
                        Spacer()

                        TextField("11 dígitos", text: $ruc)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: ruc) { _, nuevo in
                                ruc = String(
                                    nuevo.filter {
                                        $0.isASCII && $0.isNumber
                                    }.prefix(11)
                                )
                            }
                    }
                }

                Section {
                    Button {
                        guardar()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Guardar proveedor")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Nuevo proveedor")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        mostrarFormulario = false
                    }
                }
            }
        }
    }

    private func guardar() {
        guard esSupervisor else { return }

        let nombreLimpio = nombre.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !nombreLimpio.isEmpty else {
            mostrarMensaje("Ingresa la razón social del proveedor.")
            return
        }

        guard ruc.count == 11,
              ruc.allSatisfy({ $0.isASCII && $0.isNumber }) else {
            mostrarMensaje("El RUC debe tener 11 números.")
            return
        }

        guard !proveedores.contains(where: { $0.ruc == ruc }) else {
            mostrarMensaje("Ya existe un proveedor con ese RUC.")
            return
        }

        let proveedor = Proveedor(
            nombre: nombreLimpio,
            ruc: ruc
        )

        context.insert(proveedor)

        do {
            try context.save()
            mostrarFormulario = false
            nombre = ""
            ruc = ""
        } catch {
            context.rollback()
            mostrarMensaje("Error al guardar: \(error.localizedDescription)")
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
            mostrarMensaje("No se pudo eliminar el proveedor.")
        }
    }

    private func mostrarMensaje(_ mensaje: String) {
        mensajeError = mensaje
        mostrarError = true
    }
}
