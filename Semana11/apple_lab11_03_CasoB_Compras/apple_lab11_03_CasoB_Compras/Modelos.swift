
import Foundation
import SwiftData

// MARK: - USUARIO
@Model
final class Usuario {
    var nombre: String
    var usuario: String
    var clave: String
    var rol: String

    @Relationship(deleteRule: .deny, inverse: \Compra.comprador)
    var compras: [Compra] = []

    init(nombre: String, usuario: String, clave: String, rol: String) {
        self.nombre = nombre
        self.usuario = usuario
        self.clave = clave
        self.rol = rol
    }
}

// MARK: - PROVEEDOR
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

// MARK: - PRODUCTO
@Model
final class Producto {
    var nombre: String
    var categoria: String
    var stock: Int
    var costoPromedio: Double

    @Relationship(deleteRule: .deny, inverse: \Compra.producto)
    var compras: [Compra] = []

    init(
        nombre: String,
        categoria: String,
        stock: Int,
        costoPromedio: Double
    ) {
        self.nombre = nombre
        self.categoria = categoria
        self.stock = stock
        self.costoPromedio = costoPromedio
    }
}

// MARK: - COMPRA
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
        // Calcular valores antes de inicializar
        let fechaActual = Date()
        let subtotal = Double(cantidad) * costoUnitario
        let igvCalculado = subtotal * 0.18
        let totalCalculado = subtotal + igvCalculado

        let fechaVencimiento = Calendar.current.date(
            byAdding: .day,
            value: 30,
            to: fechaActual
        ) ?? fechaActual

        let estadoInicial = totalCalculado < 5000	
            ? "Aprobada"
            : "Pendiente"

        let pagadaInicial = !alCredito && estadoInicial == "Aprobada"

        // Inicializar propiedades
        self.fecha = fechaActual
        self.cantidad = cantidad
        self.costoUnitario = costoUnitario
        self.igv = igvCalculado
        self.total = totalCalculado
        self.alCredito = alCredito
        self.vence = fechaVencimiento
        self.estado = estadoInicial
        self.pagada = pagadaInicial
        self.motivoRechazo = nil

        // Relaciones
        self.comprador = comprador
        self.proveedor = proveedor
        self.producto = producto
    }
}
