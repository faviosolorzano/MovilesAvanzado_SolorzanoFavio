// ===== ACTIVIDAD PROPUESTA 01 =====
// Cursos TECSUP
// Programación en Móviles Avanzado

class Estudiante {

    let nombre: String
    let esEstudianteTecsup: Bool
    var preciosCursos: [Double]

    init(nombre: String, esEstudianteTecsup: Bool, preciosCursos: [Double]) {
        self.nombre = nombre
        self.esEstudianteTecsup = esEstudianteTecsup
        self.preciosCursos = preciosCursos
    }

    func calcularSubtotal() -> Double {

        var subtotal = 0.0

        for precio in preciosCursos {
            subtotal = subtotal + precio
        }

        return subtotal
    }

    func calcularIGV() -> Double {

        let subtotal = calcularSubtotal()

        return subtotal * 0.18
    }

    func calcularTotalConIGV() -> Double {

        return calcularSubtotal() + calcularIGV()
    }

    func calcularDescuento10() -> Double {

        if preciosCursos.count >= 3 {
            return calcularTotalConIGV() * 0.10
        } else {
            return 0.0
        }
    }

    func calcularDescuentoTecsup() -> Double {

        if preciosCursos.count >= 3 && esEstudianteTecsup {
            return 400.0
        } else {
            return 0.0
        }
    }

    func calcularTotalPagar() -> Double {

        let totalConIGV = calcularTotalConIGV()
        let descuento10 = calcularDescuento10()
        let descuentoTecsup = calcularDescuentoTecsup()

        return totalConIGV - descuento10 - descuentoTecsup
    }

    func mostrarDetalle() {

        print("===== DETALLE DE COMPRA =====")
        print("Estudiante: \(nombre)")
        print("Cantidad de cursos: \(preciosCursos.count)")
        print("Subtotal: S/ \(calcularSubtotal())")
        print("IGV (18%): S/ \(calcularIGV())")
        print("Total con IGV: S/ \(calcularTotalConIGV())")
        print("Descuento 10%: S/ \(calcularDescuento10())")
        print("Descuento estudiante TECSUP: S/ \(calcularDescuentoTecsup())")
        print("TOTAL A PAGAR: S/ \(calcularTotalPagar())")
    }
}


// ===== PRUEBA =====

// Estudiante TECSUP que compra 3 cursos
let estudiante = Estudiante(
    nombre: "Favio",
    esEstudianteTecsup: true,
    preciosCursos: [
        500.0,
        600.0,
        700.0
    ]
)

// Mostrar el resultado final
estudiante.mostrarDetalle()
