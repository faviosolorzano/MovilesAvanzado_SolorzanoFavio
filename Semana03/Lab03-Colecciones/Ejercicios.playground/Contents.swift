// Desarrollado por: Favio Solorzano
// Ejercicio 6: Gestión de Notas — con IA

import Foundation // Importa Foundation para usar funciones básicas de Swift.

var notasAlumnos: [String: [Double]] = [:] // Crea un diccionario para guardar cada alumno con sus tres notas.

print("¿Cuántos alumnos desea registrar?") // Solicita la cantidad de alumnos.

let cantidadAlumnos = Int(readLine() ?? "") ?? 0 // Lee y convierte la cantidad ingresada a Int.

for i in 1...cantidadAlumnos { // Repite el registro según la cantidad de alumnos.

    print("\nAlumno \(i) - Nombre:") // Solicita el nombre del alumno actual.

    let nombre = readLine() ?? "" // Lee y guarda el nombre del alumno.

    var notas: [Double] = [] // Crea un arreglo vacío para guardar las tres notas.

    for j in 1...3 { // Repite tres veces para pedir tres notas.

        print("Nota \(j):") // Solicita la nota correspondiente.

        let nota = Double(readLine() ?? "") ?? 0 // Lee y convierte la nota a Double.

        notas.append(nota) // Agrega la nota al arreglo del alumno.
    }

    notasAlumnos[nombre] = notas // Guarda al alumno y sus notas en el diccionario.
}

var promedios: [String: Double] = [:] // Crea un diccionario para guardar el promedio de cada alumno.

var sumaGeneral = 0.0 // Guarda la suma de todos los promedios.

var notaMasAlta = 0.0 // Guarda la nota más alta encontrada.

var notaMasBaja = 20.0 // Guarda la nota más baja encontrada.

var aprobados = 0 // Cuenta cuántos alumnos aprobaron.

print("\n===== REPORTE DE NOTAS =====") // Muestra el título del reporte.

for (nombre, notas) in notasAlumnos { // Recorre cada alumno y sus notas.

    var suma = 0.0 // Inicializa la suma de las notas del alumno.

    for nota in notas { // Recorre cada nota del alumno.

        suma += nota // Acumula la nota en la suma.

        if nota > notaMasAlta { // Verifica si la nota actual es la más alta.

            notaMasAlta = nota // Actualiza la nota más alta.
        }

        if nota < notaMasBaja { // Verifica si la nota actual es la más baja.

            notaMasBaja = nota // Actualiza la nota más baja.
        }
    }

    let promedio = suma / Double(notas.count) // Calcula el promedio del alumno.

    promedios[nombre] = promedio // Guarda el promedio del alumno.

    sumaGeneral += promedio // Acumula el promedio para calcular el promedio general.

    var clasificacion = "" // Crea una variable para guardar la clasificación.

    switch promedio { // Clasifica al alumno según su promedio.

    case 18...20: // Evalúa promedios de 18 a 20.

        clasificacion = "Excelente" // Asigna la clasificación Excelente.

    case 15..<18: // Evalúa promedios de 15 hasta menos de 18.

        clasificacion = "Bueno" // Asigna la clasificación Bueno.

    case 13..<15: // Evalúa promedios de 13 hasta menos de 15.

        clasificacion = "Aprobado" // Asigna la clasificación Aprobado.

    default: // Evalúa los promedios menores de 13.

        clasificacion = "Desaprobado" // Asigna la clasificación Desaprobado.
    }

    if promedio >= 13 { // Verifica si el promedio es aprobatorio.

        aprobados += 1 // Incrementa el contador de aprobados.
    }

    print("\(nombre): Promedio = \(promedio) → \(clasificacion)") // Muestra el resultado del alumno.
}

var promedioGeneral = 0.0 // Inicializa el promedio general.

if cantidadAlumnos > 0 { // Verifica que existan alumnos registrados.

    promedioGeneral = sumaGeneral / Double(cantidadAlumnos) // Calcula el promedio general.
}

var porcentajeAprobados = 0.0 // Inicializa el porcentaje de aprobados.

if cantidadAlumnos > 0 { // Verifica que existan alumnos registrados.

    porcentajeAprobados = Double(aprobados) / Double(cantidadAlumnos) * 100 // Calcula el porcentaje de aprobados.
}

print("\n===== ESTADÍSTICAS =====") // Muestra el título de estadísticas.

print("Promedio general: \(promedioGeneral)") // Muestra el promedio general.

print("Nota más alta: \(notaMasAlta)") // Muestra la nota más alta.

print("Nota más baja: \(notaMasBaja)") // Muestra la nota más baja.

print("Porcentaje de aprobados: \(porcentajeAprobados)%") // Muestra el porcentaje de aprobados.

let ranking = promedios.sorted { $0.value > $1.value } // Ordena los alumnos de mayor a menor promedio.

print("\n===== RANKING =====") // Muestra el título del ranking.

for (nombre, promedio) in ranking { // Recorre los alumnos ya ordenados.

    print("\(nombre): \(promedio)") // Muestra el nombre y promedio de cada alumno.
}
