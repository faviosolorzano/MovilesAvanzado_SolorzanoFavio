import UIKit

/*

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

*/


// ===== EJERCICIO 7: JUEGO DE ADIVINANZA (ASISTIDO POR IA) =====

let numeroSecreto = 42 // Número fijo que el jugador debe adivinar

// --- Simulación de 5 intentos con variables (no hay input real en Playground) ---
let intentoJuego1 = 20 // Primer intento del jugador
let intentoJuego2 = 50 // Segundo intento del jugador
let intentoJuego3 = 35 // Tercer intento del jugador
let intentoJuego4 = 45 // Cuarto intento del jugador
let intentoJuego5 = 42 // Quinto intento del jugador (coincide con el número secreto)

// --- Arreglo simple simulado con variables individuales, recorrido con un contador ---
var numeroDeIntento = 1 // Contador que lleva el número de intento actual (empieza en 1)
var adivinado = false // Bandera que indica si el jugador ya adivinó el número

// Requisito 3: usar while para recorrer los intentos
while numeroDeIntento <= 5 && !adivinado {
    // El bucle se repite mientras no se pase de 5 intentos y no se haya adivinado

    var intentoActual = 0 // Variable que va a guardar el valor del intento actual dentro del bucle

    // Selecciona qué intento le corresponde según el número de vuelta del bucle
    if numeroDeIntento == 1 {
        intentoActual = intentoJuego1 // En la primera vuelta, usa el primer intento
    } else if numeroDeIntento == 2 {
        intentoActual = intentoJuego2 // En la segunda vuelta, usa el segundo intento
    } else if numeroDeIntento == 3 {
        intentoActual = intentoJuego3 // En la tercera vuelta, usa el tercer intento
    } else if numeroDeIntento == 4 {
        intentoActual = intentoJuego4 // En la cuarta vuelta, usa el cuarto intento
    } else if numeroDeIntento == 5 {
        intentoActual = intentoJuego5 // En la quinta vuelta, usa el quinto intento
    }

    // Requisito 4: mostrar si el número es "Muy alto", "Muy bajo" o "¡Correcto!"
    if intentoActual == numeroSecreto {
        print("Intento \(numeroDeIntento): \(intentoActual) -> ¡Correcto!") // El intento coincide exactamente con el número secreto
        adivinado = true // Activa la bandera para detener el bucle en la siguiente comprobación
    } else if intentoActual > numeroSecreto {
        print("Intento \(numeroDeIntento): \(intentoActual) -> Muy alto") // El intento es mayor que el número secreto
    } else {
        print("Intento \(numeroDeIntento): \(intentoActual) -> Muy bajo") // El intento es menor que el número secreto
    }

    // Requisito 5: contar cuántos intentos necesitó
    if !adivinado {
        numeroDeIntento += 1 // Solo avanza al siguiente intento si todavía no adivinó
    }
}

// --- Requisito 6: mostrar resultado final del juego ---
if adivinado {
    print("¡Ganaste! Adivinaste el número en \(numeroDeIntento) intento(s)") // Informa en cuántos intentos ganó
} else {
    print("Perdiste. El número era: \(numeroSecreto)") // Informa que se acabaron los 5 intentos sin adivinar
}
