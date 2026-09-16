// ===== CASO 1.5: HERENCIA Y POLIMORFISMO — LA CADENA DE SUCURSALES =====
// Docente: Juan León

enum CategoriaElectro {
    case lineaBlanca, tecnologia, pequenos
}

struct Electrodomestico {
    let nombre: String
    let marca: String
    let precioLista: Double
    let categoria: CategoriaElectro
}

class Sucursal {
    let nombre: String
    let ciudad: String

    init(nombre: String, ciudad: String) {
        self.nombre = nombre
        self.ciudad = ciudad
    }

    func descuento() -> Double {
        return 0.05
    }

    func costoEnvio(monto: Double) -> Double {
        return 30.0
    }

    // REGLA 2: este método NO se sobreescribe en las subclases
    func cotizar(item: Electrodomestico) {
        let precioConDescuento = item.precioLista * (1 - descuento())
        let envio = costoEnvio(monto: precioConDescuento)
        let total = precioConDescuento + envio

        print("\(nombre): \(item.nombre) -> S/ \(precioConDescuento) + envio S/ \(envio) = S/ \(total)")
    }
}

// ===== TODO 14: SUCURSAL LIMA =====

class SucursalLima: Sucursal {

    override func descuento() -> Double {
        return 0.10
    }

    override func costoEnvio(monto: Double) -> Double {
        if monto >= 1500 {
            return 0.0
        } else {
            return 30.0
        }
    }
}

// ===== TODO 15: SUCURSAL PROVINCIA =====

class SucursalProvincia: Sucursal {

    // No se sobreescribe descuento().
    // Se hereda el descuento de 5% de Sucursal.

    override func costoEnvio(monto: Double) -> Double {
        let envio = monto * 0.08

        if envio < 50 {
            return 50.0
        } else {
            return envio
        }
    }
}

// ===== TODO 16: SUCURSAL OUTLET =====

class SucursalOutlet: Sucursal {

    override func descuento() -> Double {
        return 0.25
    }

    override func costoEnvio(monto: Double) -> Double {
        return 0.0
    }
}

// ===== TODO 18: SUCURSAL ONLINE =====

class SucursalOnline: Sucursal {

    override func costoEnvio(monto: Double) -> Double {
        return 15.0
    }
}

// ===== TODO 17: PRODUCTOS =====

let refrigeradora = Electrodomestico(
    nombre: "Refrigeradora",
    marca: "LG",
    precioLista: 2000.0,
    categoria: .lineaBlanca
)

let licuadora = Electrodomestico(
    nombre: "Licuadora",
    marca: "Oster",
    precioLista: 250.0,
    categoria: .pequenos
)

// ===== TODO 17 Y TODO 18: SUCURSALES =====

let sucursales: [Sucursal] = [
    SucursalLima(nombre: "Lima Centro", ciudad: "Lima"),
    SucursalProvincia(nombre: "Provincia Cusco", ciudad: "Cusco"),
    SucursalOutlet(nombre: "Outlet Ate", ciudad: "Lima"),
    SucursalOnline(nombre: "Sucursal Online", ciudad: "Online")
]

// Para agregar SucursalOnline fueron necesarias 6 líneas nuevas:
// 5 líneas para declarar la nueva clase
// y 1 línea para agregarla al arreglo.
// No fue necesario modificar cotizar() ni los for-in.

// ===== COTIZACIÓN REFRIGERADORA =====

print("===== Refrigeradora (S/ 2000.0) =====")

for sucursal in sucursales {
    sucursal.cotizar(item: refrigeradora)
}

// ===== COTIZACIÓN LICUADORA =====

print("===== Licuadora (S/ 250.0) =====")

for sucursal in sucursales {
    sucursal.cotizar(item: licuadora)
}

// ===== FIX 7 =====

class SucursalMall: Sucursal {

    // FIX 7:
    // Falta la palabra override porque descuento()
    // ya existe en la clase padre Sucursal.
    override func descuento() -> Double {
        return 0.12
    }
}

// ===== FIX 8 =====

class SucursalExpress: Sucursal {

    let radioKm: Int

    init(nombre: String, ciudad: String, radioKm: Int) {
        self.radioKm = radioKm

        // FIX 8:
        // Falta llamar al inicializador de la clase padre.
        super.init(nombre: nombre, ciudad: ciudad)
    }
}

// ===== PREDICT =====

let misteriosa: Sucursal = SucursalLima(
    nombre: "Lima Centro",
    ciudad: "Lima"
)

// Resultado: 0.1
// Aunque la variable está declarada como Sucursal,
// el objeto real es SucursalLima.
// Por polimorfismo se ejecuta descuento() de SucursalLima.
print(misteriosa.descuento())

let monto = 2000.0 * (1 - misteriosa.descuento())

// Resultado: 0.0
// El monto después del descuento es 1800.
// SucursalLima devuelve envío 0 cuando el monto es >= 1500.
print(misteriosa.costoEnvio(monto: monto))
