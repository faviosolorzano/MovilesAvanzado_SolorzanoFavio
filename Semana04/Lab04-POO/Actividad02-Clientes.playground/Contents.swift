// ===== ACTIVIDAD PROPUESTA 02 =====
// Herencia - Cliente Natural y Cliente Jurídico
// Programación en Móviles Avanzado

// Clase base CLIENTE
class Cliente {

    let codigo: String
    let direccion: String
    let fechaDeRegistro: String
    let numeroCuenta: String
    let montoMinimoApertura: Double

    init(
        codigo: String,
        direccion: String,
        fechaDeRegistro: String,
        numeroCuenta: String,
        montoMinimoApertura: Double
    ) {
        self.codigo = codigo
        self.direccion = direccion
        self.fechaDeRegistro = fechaDeRegistro
        self.numeroCuenta = numeroCuenta
        self.montoMinimoApertura = montoMinimoApertura
    }

    func mostrarDatos() {
        print("Código: \(codigo)")
        print("Dirección: \(direccion)")
        print("Fecha de registro: \(fechaDeRegistro)")
        print("Número de cuenta: \(numeroCuenta)")
        print("Monto mínimo de apertura: S/ \(montoMinimoApertura)")
    }
}


// ===== CLIENTE NATURAL =====

class ClienteNatural: Cliente {

    let nombreCompleto: String
    let dni: String

    init(
        codigo: String,
        direccion: String,
        fechaDeRegistro: String,
        numeroCuenta: String,
        montoMinimoApertura: Double,
        nombreCompleto: String,
        dni: String
    ) {
        self.nombreCompleto = nombreCompleto
        self.dni = dni

        super.init(
            codigo: codigo,
            direccion: direccion,
            fechaDeRegistro: fechaDeRegistro,
            numeroCuenta: numeroCuenta,
            montoMinimoApertura: montoMinimoApertura
        )
    }

    override func mostrarDatos() {

        print("===== CLIENTE NATURAL =====")

        super.mostrarDatos()

        print("Nombre completo: \(nombreCompleto)")
        print("DNI: \(dni)")
    }
}


// ===== CLIENTE JURÍDICO =====

class ClienteJuridico: Cliente {

    let razonSocial: String
    let ruc: String
    let representanteLegal: String

    init(
        codigo: String,
        direccion: String,
        fechaDeRegistro: String,
        numeroCuenta: String,
        montoMinimoApertura: Double,
        razonSocial: String,
        ruc: String,
        representanteLegal: String
    ) {
        self.razonSocial = razonSocial
        self.ruc = ruc
        self.representanteLegal = representanteLegal

        super.init(
            codigo: codigo,
            direccion: direccion,
            fechaDeRegistro: fechaDeRegistro,
            numeroCuenta: numeroCuenta,
            montoMinimoApertura: montoMinimoApertura
        )
    }

    override func mostrarDatos() {

        print("===== CLIENTE JURÍDICO =====")

        super.mostrarDatos()

        print("Razón social: \(razonSocial)")
        print("RUC: \(ruc)")
        print("Representante legal: \(representanteLegal)")
    }
}


// ===== PRUEBA CLIENTE NATURAL =====

let clienteNatural = ClienteNatural(
    codigo: "C001",
    direccion: "Lima",
    fechaDeRegistro: "15/09/2026",
    numeroCuenta: "001-001",
    montoMinimoApertura: 500.0,
    nombreCompleto: "Favio Solorzano",
    dni: "12345678"
)

clienteNatural.mostrarDatos()


print("")


// ===== PRUEBA CLIENTE JURÍDICO =====

let clienteJuridico = ClienteJuridico(
    codigo: "C002",
    direccion: "Lima",
    fechaDeRegistro: "15/09/2026",
    numeroCuenta: "002-002",
    montoMinimoApertura: 1000.0,
    razonSocial: "Empresa Tech S.A.C.",
    ruc: "20123456789",
    representanteLegal: "Juan Pérez"
)

clienteJuridico.mostrarDatos()
