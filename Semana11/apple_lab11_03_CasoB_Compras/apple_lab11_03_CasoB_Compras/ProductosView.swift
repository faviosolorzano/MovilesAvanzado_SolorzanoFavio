
import SwiftUI
import SwiftData

struct ProductosView: View {

    var esSupervisor: Bool = false

    @Environment(\.modelContext) private var context

    @Query(sort: \Producto.nombre)
    private var productos: [Producto]

    @State private var nombre = ""
    @State private var categoria = ""
    @State private var stock = ""
    @State private var costo = ""

    @State private var mostrarFormulario = false
    @State private var mostrarError = false
    @State private var mensajeError = ""

    var body: some View {
        List {
            if productos.isEmpty {
                ContentUnavailableView {
                    Label(
                        "No hay productos registrados",
                        systemImage: "shippingbox"
                    )
                } description: {
                    Text(
                        esSupervisor
                        ? "Presiona + para agregar un producto."
                        : "Todavía no hay productos disponibles."
                    )
                }
            } else {
                ForEach(productos) { producto in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(producto.nombre)
                            .font(.headline)

                        Text("Categoría: \(producto.categoria)")

                        Text("Stock: \(producto.stock)")

                        Text(
                            "Costo promedio: S/ \(producto.costoPromedio, specifier: "%.2f")"
                        )
                        .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 5)
                }
                .onDelete(perform: eliminar)
                .deleteDisabled(!esSupervisor)
            }
        }
        .navigationTitle("Productos")
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
                    Section("Datos del producto") {
                        TextField("Nombre", text: $nombre)

                        TextField("Categoría", text: $categoria)

                        TextField("Stock inicial", text: $stock)
                            .keyboardType(.numberPad)

                        TextField("Costo promedio", text: $costo)
                            .keyboardType(.decimalPad)
                    }

                    Section {
                        Button("Guardar producto") {
                            guardar()
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .navigationTitle("Nuevo producto")
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

        let categoriaLimpia = categoria.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !nombreLimpio.isEmpty,
              !categoriaLimpia.isEmpty,
              let stockValor = Int(stock),
              stockValor >= 0,
              let costoValor = Double(
                costo.replacingOccurrences(of: ",", with: ".")
              ),
              costoValor >= 0 else {

            mensajeError = "Completa correctamente todos los campos."
            mostrarError = true
            return
        }

        let producto = Producto(
            nombre: nombreLimpio,
            categoria: categoriaLimpia,
            stock: stockValor,
            costoPromedio: costoValor
        )

        context.insert(producto)

        do {
            try context.save()

            nombre = ""
            categoria = ""
            stock = ""
            costo = ""

            mostrarFormulario = false
        } catch {
            context.rollback()
            mensajeError = "No se pudo guardar el producto."
            mostrarError = true
        }
    }

    private func eliminar(at offsets: IndexSet) {
        guard esSupervisor else { return }

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
