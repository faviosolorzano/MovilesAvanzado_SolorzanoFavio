
import SwiftUI
import SwiftData

struct ProductosView: View {

    var esSupervisor: Bool = false

    @Environment(\.modelContext) private var context

    @Query(sort: \Producto.nombre)
    private var productos: [Producto]

    @Query(sort: \Proveedor.nombre)
    private var proveedores: [Proveedor]

    @State private var mostrarFormulario = false
    @State private var productoEditar: Producto?

    @State private var nombre = ""
    @State private var categoria = "Tecnología"
    @State private var stock = "0"
    @State private var costo = ""
    @State private var proveedorID: PersistentIdentifier?

    @State private var mostrarError = false
    @State private var mensajeError = ""

    private let categorias = [
        "Tecnología",
        "Computación",
        "Oficina",
        "Papelería",
        "Mobiliario",
        "Limpieza",
        "Herramientas",
        "Otros"
    ]

    private var proveedorSeleccionado: Proveedor? {
        proveedores.first {
            $0.persistentModelID == proveedorID
        }
    }

    var body: some View {
        VStack(spacing: 0) {

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Productos")
                        .font(.title2.bold())

                    Text("\(productos.count) registrados")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if esSupervisor {
                    Button {
                        nuevoProducto()
                    } label: {
                        Image(systemName: "plus")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .background(.blue)
                            .clipShape(Circle())
                    }
                }
            }
            .padding()

            if productos.isEmpty {
                ContentUnavailableView(
                    "Sin productos",
                    systemImage: "shippingbox",
                    description: Text(
                        "El Supervisor debe registrar productos."
                    )
                )
            } else {
                List {
                    ForEach(productos) { producto in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(producto.nombre)
                                    .font(.headline)

                                Spacer()

                                if esSupervisor {
                                    Button {
                                        editarProducto(producto)
                                    } label: {
                                        Image(
                                            systemName: "pencil.circle"
                                        )
                                        .font(.title3)
                                    }
                                    .buttonStyle(.borderless)
                                }
                            }

                            Text(producto.categoria)
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            Label(
                                producto.proveedorAsignado?.nombre
                                    ?? "Sin proveedor asignado",
                                systemImage: "building.2"
                            )
                            .font(.subheadline)
                            .foregroundStyle(
                                producto.proveedorAsignado == nil
                                    ? .orange
                                    : .secondary
                            )

                            HStack {
                                Label(
                                    "Stock: \(producto.stock)",
                                    systemImage: "shippingbox"
                                )

                                Spacer()

                                Text(
                                    producto.costoPromedio,
                                    format: .currency(code: "PEN")
                                )
                                .fontWeight(.semibold)
                            }
                            .font(.subheadline)
                        }
                        .padding(.vertical, 5)
                    }
                    .onDelete(
                        perform: esSupervisor
                            ? eliminarProductos
                            : nil
                    )
                }
            }
        }
        .navigationTitle("Productos")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $mostrarFormulario) {
            formularioProducto
        }
        .alert("Aviso", isPresented: $mostrarError) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text(mensajeError)
        }
    }

    private var formularioProducto: some View {
        NavigationStack {
            Form {
                Section("Información del producto") {
                    TextField("Nombre", text: $nombre)

                    Picker("Categoría", selection: $categoria) {
                        ForEach(categorias, id: \.self) { item in
                            Text(item).tag(item)
                        }
                    }
                }

                Section("Proveedor") {
                    Picker(
                        "Proveedor asignado",
                        selection: $proveedorID
                    ) {
                        Text("Seleccionar")
                            .tag(nil as PersistentIdentifier?)

                        ForEach(proveedores) { item in
                            Text(item.nombre)
                                .tag(
                                    Optional(item.persistentModelID)
                                )
                        }
                    }

                    if proveedores.isEmpty {
                        Text(
                            "Registra primero un proveedor."
                        )
                        .foregroundStyle(.orange)
                    }
                }

                Section("Inventario y costo") {
                    TextField("Stock", text: $stock)
                        .keyboardType(.numberPad)
                        .onChange(of: stock) { _, nuevo in
                            stock = String(
                                nuevo.filter {
                                    $0.isASCII && $0.isNumber
                                }
                            )
                        }

                    TextField("Costo unitario S/", text: $costo)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle(
                productoEditar == nil
                    ? "Nuevo producto"
                    : "Editar producto"
            )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        mostrarFormulario = false
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        guardarProducto()
                    }
                }
            }
        }
    }

    private func nuevoProducto() {
        productoEditar = nil
        nombre = ""
        categoria = "Tecnología"
        stock = "0"
        costo = ""
        proveedorID = nil
        mostrarFormulario = true
    }

    private func editarProducto(_ producto: Producto) {
        productoEditar = producto
        nombre = producto.nombre
        categoria = producto.categoria
        stock = "\(producto.stock)"
        costo = "\(producto.costoPromedio)"
        proveedorID =
            producto.proveedorAsignado?.persistentModelID

        mostrarFormulario = true
    }

    private func guardarProducto() {
        let nombreLimpio = nombre.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let costoNumero = Double(
            costo.replacingOccurrences(of: ",", with: ".")
        ) ?? 0

        guard !nombreLimpio.isEmpty,
              let stockNumero = Int(stock),
              stockNumero >= 0,
              costoNumero > 0,
              costoNumero.isFinite,
              let proveedor = proveedorSeleccionado else {
            mensajeError = """
            Completa todos los campos.

            El costo debe ser mayor que cero y debes asignar un proveedor.
            """
            mostrarError = true
            return
        }

        if let producto = productoEditar {
            producto.nombre = nombreLimpio
            producto.categoria = categoria
            producto.stock = stockNumero
            producto.costoPromedio = costoNumero
            producto.proveedorAsignado = proveedor
        } else {
            let producto = Producto(
                nombre: nombreLimpio,
                categoria: categoria,
                stock: stockNumero,
                costoPromedio: costoNumero,
                proveedorAsignado: proveedor
            )

            context.insert(producto)
        }

        do {
            try context.save()
            mostrarFormulario = false
        } catch {
            context.rollback()
            mensajeError = error.localizedDescription
            mostrarError = true
        }
    }

    private func eliminarProductos(at offsets: IndexSet) {
        for indice in offsets {
            context.delete(productos[indice])
        }

        do {
            try context.save()
        } catch {
            context.rollback()
            mensajeError = "No se pudo eliminar el producto."
            mostrarError = true
        }
    }
}
