
import Foundation
import SwiftData

@Model
final class CompraMultiple {

    var fecha: Date
    var total: Double
    var igv: Double
    var alCredito: Bool
    var vence: Date
    var estado: String
    var pagada: Bool
    var motivoRechazo: String?
    var comprador: Usuario?

    @Relationship(
        deleteRule: .cascade,
        inverse: \DetalleCompraMultiple.compra
    )
    var detalles: [DetalleCompraMultiple] = []

    init(
        comprador: Usuario,
        alCredito: Bool,
        subtotal: Double
    ) {
        let hoy = Date()

        // Calcular primero usando variables locales
        let impuesto = (subtotal * 0.18 * 100).rounded() / 100
        let totalCalculado = ((subtotal + impuesto) * 100).rounded() / 100
        let estadoCalculado = totalCalculado < 5000
            ? "Aprobada"
            : "Pendiente"

        // Inicializar todas las propiedades
        self.fecha = hoy
        self.total = totalCalculado
        self.igv = impuesto
        self.alCredito = alCredito

        self.vence = Calendar.current.date(
            byAdding: .day,
            value: 30,
            to: hoy
        ) ?? hoy

        self.estado = estadoCalculado
        self.pagada = !alCredito && estadoCalculado == "Aprobada"
        self.motivoRechazo = nil
        self.comprador = comprador
    }
}

@Model
final class DetalleCompraMultiple {

    var cantidad: Int
    var costoUnitario: Double
    var subtotal: Double

    var producto: Producto?
    var proveedor: Proveedor?
    var compra: CompraMultiple?

    init(
        producto: Producto,
        proveedor: Proveedor,
        cantidad: Int,
        costoUnitario: Double
    ) {
        self.producto = producto
        self.proveedor = proveedor
        self.cantidad = cantidad
        self.costoUnitario = costoUnitario
        self.subtotal = (
            Double(cantidad) * costoUnitario * 100
        ).rounded() / 100
        self.compra = nil
    }
}
