import Foundation

// calendario de pagos
//ingresar el nombre del producto, precio, cantidad
let igv = 0.18

func CalcularDescuento(cantidad: Int, subtotal: Double) -> Double {
    if cantidad > 10 {
        return subtotal * 0.15
    } else if cantidad > 5 {
        return subtotal * 0.10
    } else {
        return 0.0
    }
}

func obtenerInteres(plan: Int) -> Double {
    if plan == 6 {
        return 0.05
    } else if plan == 12 {
        return 0.10
    } else if plan == 24 {
        return 0.18
    } else {
        return 0.0
    }
}

print("ingrese el nombre del producto")
let producto = readLine() ?? ""
print("ingrese el precio del producto")
let precio = Double(readLine() ?? "0") ?? 0.0
print("ingrese la cantidad del producto")
let cantidad = Int(readLine() ?? "0") ?? 0

let subtotal = precio * Double(cantidad)
let descuento = CalcularDescuento(cantidad: cantidad, subtotal: subtotal)

let montobase = subtotal - descuento
let montoIgv = montobase * igv
let total = montobase + montoIgv

print("El monto total a pagar es: \(total)")



print("Elija el plan de pago: 6, 12 o 24")
let plan = Int(readLine() ?? "0") ?? 0

let interes = obtenerInteres(plan: plan)
let montoFinanciado = total * (1 + interes)
let cuota = montoFinanciado / Double(plan)

print("producto: \(producto)      interes: \(interes)      cuota: \(cuota)")
print("monto compra: \(total)      monto financiado: \(montoFinanciado)")


