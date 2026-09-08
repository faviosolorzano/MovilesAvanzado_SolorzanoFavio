import Foundation

// MARK: - Modelos

enum TipoDato: String {
    case confirmado = "Confirmado"
    case proyectado = "Proyectado"
    case tentativo = "Tentativo - simulación"
}

struct LineaMetro {
    let codigo: String
    let nombre: String
    let recorrido: String
    let tipoDato: TipoDato
}

struct Estacion {
    let nombre: String
    let distrito: String
    let referenciaPrincipal: String
    let tipoDato: TipoDato
}

struct Conexion {
    let lineaA: String
    let estacionA: String
    let lineaB: String
    let estacionB: String
    let descripcion: String
}

struct Referencia {
    let nombre: String
    let categoria: String
    let estacion: String
    let linea: String
    let orientacion: String
}
