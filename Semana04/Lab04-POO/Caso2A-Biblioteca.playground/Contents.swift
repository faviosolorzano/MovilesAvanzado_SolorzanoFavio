// ===== CASO 2A: BIBLIOTECA SIN IA =====
// Docente: Juan León

enum EstadoLibro {
    case disponible
    case prestado
}

struct Libro {
    let titulo: String
    let autor: String
    var estado: EstadoLibro = .disponible
}

class Biblioteca {

    var libros: [Libro] = []

    // Agrega un libro a la biblioteca
    func agregar(libro: Libro) {
        libros.append(libro)
    }

    // Busca un libro por título y realiza el préstamo
    func prestar(titulo: String) -> Bool {

        for i in 0..<libros.count {

            if libros[i].titulo == titulo {

                if libros[i].estado == .disponible {
                    libros[i].estado = .prestado
                    print("Préstamo aprobado: \(titulo)")
                    return true
                } else {
                    print("Error: \(titulo) ya está prestado")
                    return false
                }
            }
        }

        print("Error: no existe \(titulo)")
        return false
    }

    // Busca un libro por título y realiza la devolución
    func devolver(titulo: String) -> Bool {

        for i in 0..<libros.count {

            if libros[i].titulo == titulo {

                if libros[i].estado == .prestado {
                    libros[i].estado = .disponible
                    print("Devolución registrada: \(titulo)")
                    return true
                } else {
                    print("Error: \(titulo) no está prestado")
                    return false
                }
            }
        }

        print("Error: no existe \(titulo)")
        return false
    }

    // Muestra el inventario de libros
    func inventario() {

        print("===== INVENTARIO =====")

        for libro in libros {

            switch libro.estado {

            case .disponible:
                print("\(libro.titulo) (\(libro.autor)) - disponible")

            case .prestado:
                print("\(libro.titulo) (\(libro.autor)) - prestado")
            }
        }
    }
}


// ===== CREACIÓN DE LA BIBLIOTECA =====

let biblioteca = Biblioteca()


// ===== AGREGAR LOS 3 LIBROS =====

biblioteca.agregar(
    libro: Libro(
        titulo: "Cien años de soledad",
        autor: "Gabriel García Márquez"
    )
)

biblioteca.agregar(
    libro: Libro(
        titulo: "La ciudad y los perros",
        autor: "Mario Vargas Llosa"
    )
)

biblioteca.agregar(
    libro: Libro(
        titulo: "El Quijote",
        autor: "Miguel de Cervantes"
    )
)


// ===== SIMULACIÓN =====

// Prestar La ciudad y los perros
_ = biblioteca.prestar(
    titulo: "La ciudad y los perros"
)

// Intentar prestarlo nuevamente
_ = biblioteca.prestar(
    titulo: "La ciudad y los perros"
)

// Devolver La ciudad y los perros
_ = biblioteca.devolver(
    titulo: "La ciudad y los perros"
)

// Prestar El Quijote
_ = biblioteca.prestar(
    titulo: "El Quijote"
)

// Intentar prestar un libro que no existe
_ = biblioteca.prestar(
    titulo: "El Principito"
)

// Mostrar inventario final
biblioteca.inventario()
