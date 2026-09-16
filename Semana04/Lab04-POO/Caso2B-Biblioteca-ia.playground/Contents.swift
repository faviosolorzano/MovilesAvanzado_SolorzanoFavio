// Declara los posibles estados que puede tener un libro.
enum EstadoLibro {

    // Indica que el libro puede ser prestado.
    case disponible

    // Indica que el libro ya fue prestado.
    case prestado
}

// Define la estructura que representa un libro.
struct Libro {

    // Guarda el título del libro.
    let titulo: String

    // Guarda el nombre del autor.
    let autor: String

    // Guarda el estado actual del libro.
    var estado: EstadoLibro = .disponible
}

// Define la clase encargada de administrar la biblioteca.
class Biblioteca {

    // Crea un arreglo vacío donde se almacenarán los libros.
    var libros: [Libro] = []

    // Agrega un nuevo libro al arreglo.
    func agregar(libro: Libro) {

        // Inserta el libro recibido al final del arreglo.
        libros.append(libro)
    }

    // Intenta prestar un libro buscando su título.
    func prestar(titulo: String) -> Bool {

        // Recorre el arreglo utilizando sus índices.
        for i in 0..<libros.count {

            // Comprueba si el título actual coincide con el buscado.
            if libros[i].titulo == titulo {

                // Comprueba si el libro se encuentra disponible.
                if libros[i].estado == .disponible {

                    // Cambia el estado del libro a prestado.
                    libros[i].estado = .prestado

                    // Informa que el préstamo fue realizado.
                    print("Préstamo aprobado: \(titulo)")

                    // Indica que la operación fue exitosa.
                    return true

                } else {

                    // Informa que el libro ya se encuentra prestado.
                    print("Error: \(titulo) ya está prestado")

                    // Indica que el préstamo no pudo realizarse.
                    return false
                }
            }
        }

        // Informa que no se encontró un libro con ese título.
        print("Error: no existe \(titulo)")

        // Indica que la operación no pudo realizarse.
        return false
    }

    // Intenta devolver un libro buscando su título.
    func devolver(titulo: String) -> Bool {

        // Recorre el arreglo utilizando sus índices.
        for i in 0..<libros.count {

            // Comprueba si el título actual coincide con el buscado.
            if libros[i].titulo == titulo {

                // Comprueba si el libro está prestado.
                if libros[i].estado == .prestado {

                    // Cambia nuevamente el estado a disponible.
                    libros[i].estado = .disponible

                    // Informa que la devolución fue registrada.
                    print("Devolución registrada: \(titulo)")

                    // Indica que la operación fue exitosa.
                    return true

                } else {

                    // Informa que no puede devolverse porque no está prestado.
                    print("Error: \(titulo) no está prestado")

                    // Indica que la operación no pudo realizarse.
                    return false
                }
            }
        }

        // Informa que el libro solicitado no existe.
        print("Error: no existe \(titulo)")

        // Indica que la operación no pudo realizarse.
        return false
    }

    // Muestra todos los libros y su estado actual.
    func inventario() {

        // Imprime el encabezado del inventario.
        print("===== INVENTARIO =====")

        // Recorre todos los libros almacenados.
        for libro in libros {

            // Evalúa el estado del libro.
            switch libro.estado {

            // Se ejecuta cuando el libro está disponible.
            case .disponible:

                // Muestra título, autor y estado.
                print("\(libro.titulo) (\(libro.autor)) - disponible")

            // Se ejecuta cuando el libro está prestado.
            case .prestado:

                // Muestra título, autor y estado.
                print("\(libro.titulo) (\(libro.autor)) - prestado")
            }
        }
    }
}

// Crea la biblioteca que utilizaremos en la prueba.
let biblioteca = Biblioteca()

// Agrega el primer libro solicitado.
biblioteca.agregar(
    libro: Libro(
        titulo: "Cien años de soledad",
        autor: "Gabriel García Márquez"
    )
)

// Agrega el segundo libro solicitado.
biblioteca.agregar(
    libro: Libro(
        titulo: "La ciudad y los perros",
        autor: "Mario Vargas Llosa"
    )
)

// Agrega el tercer libro solicitado.
biblioteca.agregar(
    libro: Libro(
        titulo: "El Quijote",
        autor: "Miguel de Cervantes"
    )
)

// Realiza el primer préstamo.
_ = biblioteca.prestar(titulo: "La ciudad y los perros")

// Intenta prestar nuevamente el mismo libro.
_ = biblioteca.prestar(titulo: "La ciudad y los perros")

// Devuelve el libro prestado.
_ = biblioteca.devolver(titulo: "La ciudad y los perros")

// Realiza el préstamo de El Quijote.
_ = biblioteca.prestar(titulo: "El Quijote")

// Intenta prestar un libro que no existe.
_ = biblioteca.prestar(titulo: "El Principito")

// Muestra el estado final de todos los libros.
biblioteca.inventario()
