// Desarrollado por: Favio Solorzano
import UIKit

class Producto {
    let nombre: String
    let precio: Double
    var stock: Int

    init(nombre: String, precio: Double, stock: Int) {
        self.nombre = nombre
        self.precio = precio
        self.stock = stock
    }
}

class ItemCarrito {
    let producto: Producto
    var cantidad: Int

    init(producto: Producto, cantidad: Int) {
        self.producto = producto
        self.cantidad = cantidad
    }

    func subtotal() -> Double {
        return producto.precio * Double(cantidad)
    }
}

class ClienteModel {
    var nombre: String
    var apellido: String
    var dni: String

    init(nombre: String, apellido: String, dni: String) {
        self.nombre = nombre
        self.apellido = apellido
        self.dni = dni
    }
}

class CarritoModel {
    var items: [ItemCarrito] = []

    func agregar(producto: Producto, cantidad: Int) -> Bool {
        let yaEnCarrito = items.first(where: { $0.producto === producto })
        let cantidadActual = yaEnCarrito?.cantidad ?? 0

        if cantidadActual + cantidad > producto.stock {
            return false
        }
        if let linea = yaEnCarrito {
            linea.cantidad += cantidad
        } else {
            items.append(ItemCarrito(producto: producto, cantidad: cantidad))
        }
        return true
    }

    func subtotal() -> Double {
        return items.reduce(0) { $0 + $1.subtotal() }
    }

    func porcentajeDescuento() -> Double {
        let s = subtotal()
        if s >= 5000 { return 0.15 }
        if s >= 2000 { return 0.10 }
        if s >= 500 { return 0.05 }
        return 0.0
    }

    func descuento() -> Double {
        return subtotal() * porcentajeDescuento()
    }

    func igv() -> Double {
        return (subtotal() - descuento()) * 0.18
    }

    func total() -> Double {
        return subtotal() - descuento() + igv()
    }

    func categoria() -> String {
        switch Int(subtotal()) {
        case ..<500: return "Regular"
        case 500..<2000: return "Frecuente"
        case 2000..<5000: return "VIP"
        default: return "Premium"
        }
    }

    func cantidadTotal() -> Int {
        return items.reduce(0) { $0 + $1.cantidad }
    }

    func vaciar() {
        items.removeAll()
    }

    func confirmarCompra() {
        for item in items {
            item.producto.stock -= item.cantidad
        }
        vaciar()
    }
}
