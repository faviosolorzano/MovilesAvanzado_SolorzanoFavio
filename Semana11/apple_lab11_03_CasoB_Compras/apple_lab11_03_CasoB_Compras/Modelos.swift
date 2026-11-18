
import Foundation
import SwiftData

@Model
final class Usuario {
    var nombre: String
    var usuario: String
    var clave: String
    var rol: String

    @Relationship(deleteRule: .deny, inverse: \Compra.comprador)
    var compras: [Compra] = []

    init(
        nombre: String,
        usuario: String,
        clave: String,
        rol: String
    ) {
        self.nombre = nombre
        self.usuario = usuario
        self.clave = clave
        self.rol = rol
    }
}

@Model
final class Proveedor {
    var nombre: String
    var ruc: String

    @Relationship(deleteRule: .deny, inverse: \Compra.proveedor)
    var compras: [Compra] = []

    init(nombre: String, ruc: String) {
        self.nombre = nombre
        self.ruc = ruc
    }
}

@Model
final class Producto {
    var nombre: String
    var categoria: String
    var stock: Int
    var costoPromedio: Double

    // Relación nueva: proveedor asignado al producto.
    var proveedorAsignado: Proveedor?

    @Relationship(deleteRule: .deny, inverse: \Compra.producto)
    var compras: [Compra] = []

    init(
        nombre: String,
        categoria: String,
        stock: Int,
        costoPromedio: Double,
        proveedorAsignado: Proveedor? = nil
    ) {
        self.nombre = nombre
        self.categoria = categoria
        self.stock = stock
        self.costoPromedio = costoPromedio
        self.proveedorAsignado = proveedorAsignado
    }
}

@Model
final class Compra {
    var fecha: Date
    var cantidad: Int
    var costoUnitario: Double
    var igv: Double
    var total: Double
    var alCredito: Bool
    var vence: Date
    var estado: String
    var pagada: Bool
    var motivoRechazo: String?

    var comprador: Usuario?
    var proveedor: Proveedor?
    var producto: Producto?

    init(
        cantidad: Int,
        costoUnitario: Double,
        alCredito: Bool,
        comprador: Usuario,
        proveedor: Proveedor,
        producto: Producto
    ) {
        let ahora = Date()
        let subtotal = Double(cantidad) * costoUnitario
        let impuesto = subtotal * 0.18
        let totalCompra = subtotal + impuesto

        self.fecha = ahora
        self.cantidad = cantidad
        self.costoUnitario = costoUnitario
        self.igv = impuesto
        self.total = totalCompra
        self.alCredito = alCredito

        self.vence = Calendar.current.date(
            byAdding: .day,
            value: 30,
            to: ahora
        ) ?? ahora

        self.estado = totalCompra < 5000
            ? "Aprobada"
            : "Pendiente"

        self.pagada = !alCredito && totalCompra < 5000
        self.motivoRechazo = nil

        self.comprador = comprador
        self.proveedor = proveedor
        self.producto = producto
    }
}
