import SwiftUI
import SwiftData

struct ComprasView: View {

    let usuario: Usuario

    @Environment(\.modelContext) private var context

    @Query(sort: \Producto.nombre)
    private var productos: [Producto]

    @Query(sort: \Proveedor.nombre)
    private var proveedores: [Proveedor]

    @State private var busqueda = ""
    @State private var proveedorSeleccionado: PersistentIdentifier?
    @State private var carrito: [PersistentIdentifier: Int] = [:]
    @State private var paso = 0
    @State private var alCredito = false
    @State private var mostrarAlerta = false
    @State private var mensaje = ""
    @State private var confirmarRegistro = false

    private let azul = Color.blue

    // MARK: - Datos

    private var catalogo: [Producto] {
        productos.filter { producto in
            let texto = busqueda.isEmpty
                || producto.nombre.localizedCaseInsensitiveContains(busqueda)
                || producto.categoria.localizedCaseInsensitiveContains(busqueda)
                || (producto.proveedorAsignado?.nombre
                    .localizedCaseInsensitiveContains(busqueda) ?? false)

            let proveedor = proveedorSeleccionado == nil
                || producto.proveedorAsignado?.persistentModelID
                    == proveedorSeleccionado

            return texto && proveedor
        }
    }

    private var seleccionados: [Producto] {
        productos.filter {
            (carrito[$0.persistentModelID] ?? 0) > 0
        }
    }

    private var unidades: Int {
        seleccionados.reduce(0) {
            $0 + (carrito[$1.persistentModelID] ?? 0)
        }
    }

    private var subtotal: Double {
        seleccionados.reduce(0) { resultado, producto in
            let cantidad = carrito[producto.persistentModelID] ?? 0
            return resultado + Double(cantidad) * producto.costoPromedio
        }
    }

    private var igv: Double {
        (subtotal * 0.18 * 100).rounded() / 100
    }

    private var total: Double {
        ((subtotal + igv) * 100).rounded() / 100
    }

    private var compraValida: Bool {
        !seleccionados.isEmpty
        && subtotal > 0
        && subtotal.isFinite
        && total.isFinite
        && seleccionados.allSatisfy {
            $0.proveedorAsignado != nil
            && $0.costoPromedio > 0
            && $0.costoPromedio.isFinite
            && (1...10000).contains(
                carrito[$0.persistentModelID] ?? 0
            )
        }
    }

    private func dinero(_ cantidad: Double) -> String {
        cantidad.formatted(.currency(code: "PEN"))
    }

    // MARK: - Vista principal

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                encabezado

                switch paso {
                case 0:
                    vistaCatalogo
                case 1:
                    vistaCarrito
                case 2:
                    vistaPago
                default:
                    vistaResumen
                }
            }
            .padding(16)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Comprar")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            barraInferior
        }
        .confirmationDialog(
            "¿Registrar esta compra?",
            isPresented: $confirmarRegistro
        ) {
            Button("Confirmar registro") {
                registrarCompra()
            }

            Button("Cancelar", role: .cancel) {}
        } message: {
            Text("Total de la compra: \(dinero(total))")
        }
        .alert("Compras", isPresented: $mostrarAlerta) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text(mensaje)
        }
    }

    // MARK: - Encabezado

    private var encabezado: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text([
                        "Explorar productos",
                        "Mi carrito",
                        "Forma de pago",
                        "Resumen final"
                    ][paso])
                    .font(.title2.bold())

                    Text("Paso \(paso + 1) de 4")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "cart.fill")
                    .font(.title2)
                    .foregroundStyle(azul)
                    .frame(width: 48, height: 48)
                    .background(
                        azul.opacity(0.1),
                        in: RoundedRectangle(cornerRadius: 14)
                    )
            }

            HStack(spacing: 6) {
                ForEach(0..<4, id: \.self) { numero in
                    Capsule()
                        .fill(
                            numero <= paso
                                ? azul
                                : Color.gray.opacity(0.2)
                        )
                        .frame(height: 5)
                }
            }
        }
    }

    // MARK: - Catálogo

    private var vistaCatalogo: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)

                TextField(
                    "Buscar productos...",
                    text: $busqueda
                )
                .textInputAutocapitalization(.never)

                if !busqueda.isEmpty {
                    Button {
                        busqueda = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(14)
            .background(
                Color(.systemBackground),
                in: RoundedRectangle(cornerRadius: 14)
            )

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    botonFiltro("Todos", id: nil)

                    ForEach(proveedores) { proveedor in
                        botonFiltro(
                            proveedor.nombre,
                            id: proveedor.persistentModelID
                        )
                    }
                }
            }

            HStack {
                Text("Productos disponibles")
                    .font(.headline)

                Spacer()

                Text("\(catalogo.count)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            if catalogo.isEmpty {
                ContentUnavailableView(
                    "Sin productos",
                    systemImage: "shippingbox",
                    description: Text(
                        "Prueba otra búsqueda o filtro."
                    )
                )
            } else {
                LazyVStack(spacing: 12) {
                    ForEach(catalogo) { producto in
                        tarjetaProducto(producto)
                    }
                }
            }
        }
    }

    private func botonFiltro(
        _ nombre: String,
        id: PersistentIdentifier?
    ) -> some View {
        let activo = proveedorSeleccionado == id

        return Button {
            proveedorSeleccionado = id
        } label: {
            Text(nombre)
                .font(.subheadline.weight(.medium))
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .foregroundStyle(
                    activo ? Color.white : Color.primary
                )
                .background(
                    activo ? azul : Color(.systemBackground),
                    in: Capsule()
                )
        }
        .buttonStyle(.plain)
    }

    private func tarjetaProducto(
        _ producto: Producto
    ) -> some View {
        let cantidad = carrito[producto.persistentModelID] ?? 0
        let disponible = producto.proveedorAsignado != nil
            && producto.costoPromedio > 0
            && producto.costoPromedio.isFinite

        return VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: "shippingbox.fill")
                    .font(.title2)
                    .foregroundStyle(azul)
                    .frame(width: 56, height: 56)
                    .background(
                        azul.opacity(0.09),
                        in: RoundedRectangle(cornerRadius: 13)
                    )

                VStack(alignment: .leading, spacing: 5) {
                    Text(producto.nombre)
                        .font(.headline)

                    Text(producto.categoria)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Label(
                        producto.proveedorAsignado?.nombre
                            ?? "Sin proveedor",
                        systemImage: "building.2"
                    )
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }

                Spacer(minLength: 0)
            }

            Divider()

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(dinero(producto.costoPromedio))
                        .font(.title3.bold())
                        .foregroundStyle(azul)

                    Text("Stock actual: \(producto.stock)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if cantidad > 0 {
                    HStack(spacing: 12) {
                        Button {
                            cambiarCantidad(producto, cambio: -1)
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .font(.title2)
                        }

                        Text("\(cantidad)")
                            .font(.headline)
                            .monospacedDigit()

                        Button {
                            cambiarCantidad(producto, cambio: 1)
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                        .disabled(cantidad >= 10000)
                    }
                    .buttonStyle(.borderless)
                } else {
                    Button {
                        cambiarCantidad(producto, cambio: 1)
                    } label: {
                        Label("Agregar", systemImage: "plus")
                            .font(.subheadline.bold())
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(!disponible)
                }
            }

            if !disponible {
                Text("Asigna un proveedor y un costo válido.")
                    .font(.caption)
                    .foregroundStyle(.orange)
            }
        }
        .padding(15)
        .background(
            Color(.systemBackground),
            in: RoundedRectangle(cornerRadius: 16)
        )
    }

    private func cambiarCantidad(
        _ producto: Producto,
        cambio: Int
    ) {
        let id = producto.persistentModelID
        let actual = carrito[id] ?? 0
        let nuevo = max(0, min(10000, actual + cambio))

        if nuevo == 0 {
            carrito.removeValue(forKey: id)
        } else {
            carrito[id] = nuevo
        }
    }

    // MARK: - Carrito

    private var vistaCarrito: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Revisa y modifica las cantidades.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            ForEach(seleccionados) { producto in
                tarjetaProducto(producto)
            }

            tarjeta {
                fila("Productos", "\(seleccionados.count)")
                fila("Unidades", "\(unidades)")
            }

            Button {
                paso = 0
            } label: {
                Label(
                    "Seguir agregando productos",
                    systemImage: "plus.circle"
                )
            }
        }
    }

    // MARK: - Pago

    private var vistaPago: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Selecciona cómo deseas pagar.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            tarjeta {
                Button {
                    alCredito = false
                } label: {
                    opcionPago(
                        "Contado",
                        descripcion: "Pago inmediato al aprobarse.",
                        icono: "banknote",
                        seleccionado: !alCredito
                    )
                }
                .buttonStyle(.plain)

                Divider()

                Button {
                    alCredito = true
                } label: {
                    opcionPago(
                        "Crédito",
                        descripcion: "Plazo de 30 días.",
                        icono: "calendar",
                        seleccionado: alCredito
                    )
                }
                .buttonStyle(.plain)
            }

            Text(
                "La forma de pago se aplicará a toda la compra."
            )
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }

    private func opcionPago(
        _ nombre: String,
        descripcion: String,
        icono: String,
        seleccionado: Bool
    ) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icono)
                .font(.title2)
                .foregroundStyle(azul)
                .frame(width: 34)

            VStack(alignment: .leading, spacing: 4) {
                Text(nombre)
                    .font(.headline)

                Text(descripcion)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(
                systemName: seleccionado
                    ? "largecircle.fill.circle"
                    : "circle"
            )
            .font(.title3)
            .foregroundStyle(
                seleccionado ? azul : Color.gray
            )
        }
        .padding(.vertical, 10)
        .contentShape(Rectangle())
    }

    // MARK: - Resumen final

    private var vistaResumen: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Verifica los datos antes de registrar.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            tarjeta {
                Text("Productos seleccionados")
                    .font(.headline)

                ForEach(seleccionados) { producto in
                    Divider()

                    VStack(alignment: .leading, spacing: 5) {
                        Text(producto.nombre)
                            .font(.subheadline.bold())

                        Text(
                            producto.proveedorAsignado?.nombre
                                ?? "Sin proveedor"
                        )
                        .font(.caption)
                        .foregroundStyle(.secondary)

                        let cantidad =
                            carrito[producto.persistentModelID] ?? 0

                        fila(
                            "\(cantidad) × \(dinero(producto.costoPromedio))",
                            dinero(
                                Double(cantidad)
                                    * producto.costoPromedio
                            )
                        )
                    }
                }
            }

            tarjeta {
                fila("Subtotal", dinero(subtotal))
                fila("IGV (18 %)", dinero(igv))

                Divider()

                fila("TOTAL", dinero(total), destacado: true)

                Divider()

                fila(
                    "Forma de pago",
                    alCredito ? "Crédito" : "Contado"
                )
            }

            Label(
                total >= 5000
                    ? "Requiere aprobación del Supervisor"
                    : "Aprobación automática",
                systemImage: total >= 5000
                    ? "clock"
                    : "checkmark.shield.fill"
            )
            .font(.subheadline)
            .foregroundStyle(
                total >= 5000 ? Color.orange : Color.green
            )
        }
    }

    // MARK: - Componentes

    private func tarjeta<Contenido: View>(
        @ViewBuilder contenido: () -> Contenido
    ) -> some View {
        VStack(
            alignment: .leading,
            spacing: 13,
            content: contenido
        )
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color(.systemBackground),
            in: RoundedRectangle(cornerRadius: 16)
        )
    }

    private func fila(
        _ titulo: String,
        _ valor: String,
        destacado: Bool = false
    ) -> some View {
        HStack {
            Text(titulo)
                .foregroundStyle(
                    destacado ? Color.primary : Color.secondary
                )

            Spacer()

            Text(valor)
                .fontWeight(destacado ? .bold : .medium)
                .foregroundStyle(
                    destacado ? azul : Color.primary
                )
        }
        .font(destacado ? .headline : .subheadline)
    }

    private var barraInferior: some View {
        HStack(spacing: 10) {
            if paso > 0 {
                Button {
                    paso -= 1
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.headline)
                        .frame(width: 45, height: 50)
                }
                .buttonStyle(.bordered)
            }

            Button {
                if paso < 3 {
                    paso += 1
                } else {
                    confirmarRegistro = true
                }
            } label: {
                HStack(spacing: 8) {
                    if paso == 0 {
                        Image(systemName: "cart.fill")
                        Text("Carrito (\(unidades))")
                    } else if paso == 1 {
                        Text("Elegir forma de pago")
                    } else if paso == 2 {
                        Text("Ver resumen final")
                    } else {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Registrar compra")
                    }

                    if paso < 3 {
                        Image(systemName: "arrow.right")
                    }
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!compraValida)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(.regularMaterial)
    }

    // MARK: - Registrar compra

    private func registrarCompra() {
        guard compraValida else {
            mensaje = "Revisa los productos seleccionados."
            mostrarAlerta = true
            return
        }

        // Validar antes de modificar el inventario.
        for producto in seleccionados {
            let cantidad = carrito[producto.persistentModelID] ?? 0

            let resultado = producto.stock.addingReportingOverflow(
                cantidad
            )

            if producto.stock < 0 || resultado.overflow {
                mensaje = "Stock inválido: \(producto.nombre)"
                mostrarAlerta = true
                return
            }
        }

        let compra = CompraMultiple(
            comprador: usuario,
            alCredito: alCredito,
            subtotal: subtotal
        )

        context.insert(compra)

        for producto in seleccionados {
            guard let proveedor = producto.proveedorAsignado else {
                continue
            }

            let cantidad = carrito[producto.persistentModelID] ?? 0

            let detalle = DetalleCompraMultiple(
                producto: producto,
                proveedor: proveedor,
                cantidad: cantidad,
                costoUnitario: producto.costoPromedio
            )

            context.insert(detalle)
            detalle.compra = compra

            if compra.estado == "Aprobada" {
                let stockAnterior = producto.stock
                let stockNuevo = stockAnterior + cantidad

                producto.costoPromedio = (
                    Double(stockAnterior) * producto.costoPromedio
                    + Double(cantidad) * detalle.costoUnitario
                ) / Double(stockNuevo)

                producto.stock = stockNuevo
            }
        }

        do {
            try context.save()

            mensaje = compra.estado == "Pendiente"
                ? "Compra registrada. Esperando aprobación del Supervisor."
                : "Compra registrada e inventario actualizado."

            carrito.removeAll()
            busqueda = ""
            proveedorSeleccionado = nil
            alCredito = false
            paso = 0

        } catch {
            context.rollback()
            mensaje = "Error al guardar: \(error.localizedDescription)"
        }

        mostrarAlerta = true
    }
}
