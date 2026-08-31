import UIKit

// ===== EJERCICIO 1: CONDICIONALES =====


let nota = 15.0
if nota >= 13.0 {
    print("Aprobado con \(nota)")
} else {
    print("Desaprobado con \(nota)")
}

// --- TODO 1: Validar si una persona es mayor de edad ---
let edad = 17
if edad >= 18 {
    print("Es mayor de edad")
} else {
    print("Es menor de edad")
}

// --- TODO 2: Clasificar una nota con else if ---
let miNota = 16.0
if miNota >= 18 {
    print("Excelente")
} else if miNota >= 15 {
    print("Bueno")
} else if miNota >= 13 {
    print("Aprobado")
} else {
    print("Desaprobado")
}

// --- TODO 3: Verificar si un número es positivo, negativo o cero ---
let numero = -5
if numero > 0 {
    print("Positivo")
} else if numero < 0 {
    print("Negativo")
} else {
    print("Cero")
}

// ===== FIX: Encuentra y corrige los 3 errores =====

// Error 1: faltaba la llave "{" de apertura después del else if
let temperatura = 35
if temperatura > 30 {
    print("Hace calor")
} else if temperatura > 20 {
    print("Clima agradable")
} else {
    print("Hace frío")
}

// Error 2 y 3: la comparación estaba invertida (debía ser >=) y la resta
// también estaba invertida (debía ser compra - saldo para dar un número positivo)
let saldo = 100.0
let compra = 150.0
if saldo >= compra {
    print("Compra realizada")
} else {
    print("Saldo insuficiente: te faltan \(compra - saldo)")
}

let hora = 25
if hora >= 0 && hora < 12 {
    print("Buenos días")
} else if hora >= 12 && hora < 18 {
    print("Buenas tardes")
} else if hora >= 18 && hora <= 23 {
    print("Buenas noches")
} else {
    print("Hora inválida")
}

// ===== PREDICT: ¿Qué imprime cada bloque? =====

let x = 10
if x > 5 && x < 20 {
    print("Dentro del rango")
} else {
    print("Fuera del rango")
} // PREDICT 1: "Dentro del rango" (porque 10 está entre 5 y 20)

let y = 15
if y > 20 {
    print("Mayor que 20")
} else if y > 10 {
    print("Mayor que 10")
} else if y > 5 {
    print("Mayor que 5")
} // PREDICT 2: "Mayor que 10" — no imprime "Mayor que 5" porque el
  // else-if se detiene en la PRIMERA condición verdadera que encuentra

let esLunes = true
let llueve = false
if esLunes && llueve {
    print("Lunes lluvioso")
} else if esLunes || llueve {
    print("Es lunes O llueve")
} else {
    print("Ni lunes ni llueve")
} // PREDICT 3: "Es lunes O llueve" (esLunes es true, con || basta una condición verdadera)

