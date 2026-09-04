/*

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

*/




// Ejercicio 7: Inventario — con IA

var inventario: [String: (precio: Double, stock: Int)] = [:] // Crea un diccionario para guardar nombre, precio y stock de cada producto.

print("\n¿Cuántos productos desea registrar?") // Solicita la cantidad de productos a registrar.

let cantidadProductos = Int(readLine() ?? "") ?? 0 // Lee y convierte la cantidad de productos a Int.

if cantidadProductos > 0 { // Verifica que la cantidad de productos sea mayor que cero.

    for i in 1...cantidadProductos { // Repite el registro según la cantidad indicada.

        print("\nProducto \(i) - Nombre:") // Solicita el nombre del producto.

        let nombreProducto = readLine() ?? "" // Lee y guarda el nombre del producto.

        print("Precio:") // Solicita el precio del producto.

        let precioProducto = Double(readLine() ?? "") ?? 0 // Lee y convierte el precio a Double.

        print("Stock:") // Solicita la cantidad disponible del producto.

        let stockProducto = Int(readLine() ?? "") ?? 0 // Lee y convierte el stock a Int.

        inventario[nombreProducto] = (precio: precioProducto, stock: stockProducto) // Guarda el producto con su precio y stock en el diccionario.
    }
}

var opcion = 0 // Guarda la opción seleccionada en el menú.

while opcion != 5 { // Mantiene el menú activo hasta que el usuario seleccione salir.

    print("\n===== MENÚ DE INVENTARIO =====") // Muestra el título del menú.

    print("1. Ver inventario") // Muestra la opción para listar todos los productos.

    print("2. Buscar producto") // Muestra la opción para buscar un producto.

    print("3. Mostrar stock bajo") // Muestra la opción para consultar productos con poco stock.

    print("4. Calcular valor total") // Muestra la opción para calcular el valor total del inventario.

    print("5. Salir") // Muestra la opción para finalizar el programa.

    print("Seleccione una opción:") // Solicita una opción al usuario.

    opcion = Int(readLine() ?? "") ?? 0 // Lee y convierte la opción seleccionada a Int.

    switch opcion { // Evalúa la opción seleccionada por el usuario.

    case 1: // Ejecuta la opción de mostrar todo el inventario.

        print("\n===== INVENTARIO =====") // Muestra el título del reporte de inventario.

        if inventario.isEmpty { // Verifica si el inventario está vacío.

            print("No hay productos registrados.") // Informa que no existen productos registrados.

        } else { // Se ejecuta cuando existen productos registrados.

            for (nombre, datos) in inventario.sorted(by: { $0.key < $1.key }) { // Recorre los productos ordenados alfabéticamente.

                print("Producto: \(nombre) | Precio: S/ \(datos.precio) | Stock: \(datos.stock)") // Muestra el nombre, precio y stock del producto.
            }
        }

    case 2: // Ejecuta la opción de buscar un producto.

        print("\nIngrese el nombre del producto a buscar:") // Solicita el nombre del producto.

        let productoBuscado = readLine() ?? "" // Lee y guarda el nombre ingresado.

        if let datosProducto = inventario[productoBuscado] { // Busca el producto en el diccionario.

            print("\n===== PRODUCTO ENCONTRADO =====") // Muestra el encabezado del resultado.

            print("Nombre: \(productoBuscado)") // Muestra el nombre del producto encontrado.

            print("Precio: S/ \(datosProducto.precio)") // Muestra el precio del producto encontrado.

            print("Stock: \(datosProducto.stock)") // Muestra el stock del producto encontrado.

        } else { // Se ejecuta cuando el producto no existe.

            print("Producto no encontrado.") // Informa que no se encontró el producto.
        }

    case 3: // Ejecuta la opción para mostrar productos con stock bajo.

        print("\n===== PRODUCTOS CON STOCK BAJO =====") // Muestra el título del reporte.

        var existeStockBajo = false // Indica si se encontró al menos un producto con stock bajo.

        for (nombre, datos) in inventario.sorted(by: { $0.key < $1.key }) { // Recorre todos los productos ordenados.

            if datos.stock < 5 { // Verifica si el producto tiene menos de cinco unidades.

                print("Producto: \(nombre) | Stock: \(datos.stock)") // Muestra el producto que tiene stock bajo.

                existeStockBajo = true // Indica que se encontró un producto con stock bajo.
            }
        }

        if !existeStockBajo { // Verifica si ningún producto tuvo stock bajo.

            print("No hay productos con stock bajo.") // Informa que todos los productos tienen stock suficiente.
        }

    case 4: // Ejecuta la opción para calcular el valor total del inventario.

        var valorTotalInventario = 0.0 // Inicializa el valor total del inventario.

        for (_, datos) in inventario { // Recorre todos los productos registrados.

            valorTotalInventario += datos.precio * Double(datos.stock) // Multiplica precio por stock y acumula el resultado.
        }

        print("\n===== VALOR TOTAL DEL INVENTARIO =====") // Muestra el título del reporte.

        print("Valor total: S/ \(valorTotalInventario)") // Muestra el valor económico total del inventario.

    case 5: // Ejecuta la opción para salir del programa.

        print("\nPrograma finalizado.") // Informa que el programa terminó.

    default: // Se ejecuta cuando se ingresa una opción diferente de 1 a 5.

        print("Opción inválida. Intente nuevamente.") // Informa que la opción seleccionada no es válida.
    }
}
