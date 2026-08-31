import UIKit

// ===== EJERCICIO 6: CARRITO MEJORADO (ASISTIDO POR IA) =====

// --- Datos de productos (mismos del ejercicio 5, para mantener consistencia) ---
let prodA = "Laptop" // Nombre del primer producto
let precioA = 3500.0 // Precio unitario del primer producto
let cantA = 1 // Cantidad comprada del primer producto

let prodB = "Mouse" // Nombre del segundo producto
let precioB = 45.50 // Precio unitario del segundo producto
let cantB = 4 // Cantidad comprada del segundo producto (4, para probar el descuento por cantidad)

let prodC = "Teclado" // Nombre del tercer producto
let precioC = 120.00 // Precio unitario del tercer producto
let cantC = 1 // Cantidad comprada del tercer producto

let prodD = "Monitor" // Nombre del cuarto producto
let precioD = 890.00 // Precio unitario del cuarto producto
let cantD = 1 // Cantidad comprada del cuarto producto

let prodE = "USB Cable" // Nombre del quinto producto
let precioE = 15.00 // Precio unitario del quinto producto
let cantE = 3 // Cantidad comprada del quinto producto (3, para probar el descuento por cantidad)

// --- Cupón de descuento (simulado, no hay input real en Playground) ---
let cuponIngresado = "DESCUENTO20" // Código de cupón que el cliente ingresó, simulado como constante

// --- Requisito 5: Validación de datos ---
var hayError = false // Bandera que indica si se encontró algún dato inválido en el carrito
if precioA < 0 || precioB < 0 || precioC < 0 || precioD < 0 || precioE < 0 {
    // Revisa si algún precio del carrito es negativo
    print("Error: hay un precio negativo en el carrito") // Muestra el mensaje de error correspondiente
    hayError = true // Activa la bandera de error para detener el cálculo
}
if cantA == 0 || cantB == 0 || cantC == 0 || cantD == 0 || cantE == 0 {
    // Revisa si alguna cantidad comprada es igual a cero
    print("Error: hay una cantidad en cero en el carrito") // Muestra el mensaje de error correspondiente
    hayError = true // Activa la bandera de error para detener el cálculo
}

if !hayError { // Solo se ejecuta el cálculo del carrito si no se encontró ningún error de validación

    // --- Función que calcula el subtotal de un producto aplicando el descuento por cantidad ---
    func calcularSubtotal(precio: Double, cantidad: Int) -> Double {
        var subtotal = precio * Double(cantidad) // Calcula el subtotal base: precio por cantidad
        if cantidad >= 3 {
            // Requisito 1: si se compran 3 o más unidades del mismo producto
            subtotal = subtotal - (subtotal * 0.05) // Se resta un 5% extra de descuento a ese producto
        }
        return subtotal // Devuelve el subtotal ya con el descuento aplicado (si correspondía)
    }

    // --- Calcula el subtotal de cada producto usando la función anterior ---
    let subA = calcularSubtotal(precio: precioA, cantidad: cantA) // Subtotal de Laptop
    let subB = calcularSubtotal(precio: precioB, cantidad: cantB) // Subtotal de Mouse (con descuento por cantidad)
    let subC = calcularSubtotal(precio: precioC, cantidad: cantC) // Subtotal de Teclado
    let subD = calcularSubtotal(precio: precioD, cantidad: cantD) // Subtotal de Monitor
    let subE = calcularSubtotal(precio: precioE, cantidad: cantE) // Subtotal de USB Cable (con descuento por cantidad)

    // --- Suma todos los subtotales para obtener el total antes del cupón ---
    let subtotalGeneral = subA + subB + subC + subD + subE // Suma de los 5 subtotales de productos

    // --- Requisito 2: Aplicar cupón de descuento ---
    var totalConCupon = subtotalGeneral // Por defecto el total con cupón es igual al subtotal general
    if cuponIngresado == "DESCUENTO20" {
        // Verifica si el código de cupón ingresado coincide con el cupón válido
        totalConCupon = subtotalGeneral - (subtotalGeneral * 0.20) // Resta un 20% adicional al total
        print("Cupón DESCUENTO20 aplicado: 20% de descuento adicional") // Informa que el cupón sí se aplicó
    } else {
        print("No se aplicó ningún cupón válido") // Informa que el cupón ingresado no es válido
    }

    // --- Requisito 3: Envío gratis o con costo ---
    var costoEnvio = 25.00 // Por defecto, el costo de envío es S/. 25.00
    if totalConCupon > 3000 {
        // Verifica si el total (ya con cupón aplicado) supera los S/. 3000
        costoEnvio = 0.0 // Si supera el monto, el envío pasa a ser gratuito
        print("Envío gratis por compra mayor a S/. 3000") // Informa que el envío quedó gratis
    } else {
        print("Costo de envío: S/. \(costoEnvio)") // Informa el costo de envío que se cobrará
    }

    // --- Calcula el total final sumando el costo de envío ---
    let totalFinal = totalConCupon + costoEnvio // Suma el total con cupón más el costo de envío

    // --- Requisito 4: Puntos de fidelidad ---
    let puntosFidelidad = Int(totalFinal / 100) // Por cada S/. 100 del total final, se gana 1 punto (se trunca el decimal)

    // --- Imprime el resumen final del carrito mejorado ---
    print("========================================") // Línea separadora superior del ticket
    print("TICKET DE COMPRA MEJORADO") // Título del ticket
    print("========================================") // Línea separadora
    print("Subtotal general: S/. \(subtotalGeneral)") // Muestra el subtotal antes de aplicar el cupón
    print("Total con cupón: S/. \(totalConCupon)") // Muestra el total después de aplicar el cupón
    print("Costo de envío: S/. \(costoEnvio)") // Muestra el costo de envío ya calculado
    print("TOTAL FINAL: S/. \(totalFinal)") // Muestra el monto final que el cliente debe pagar
    print("Puntos de fidelidad ganados: \(puntosFidelidad)") // Muestra los puntos de fidelidad obtenidos
    print("========================================") // Línea separadora final del ticket
}
