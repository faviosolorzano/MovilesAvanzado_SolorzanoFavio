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


// MARK: - Líneas

let lineas: [String: LineaMetro] = [

    "L1": LineaMetro(
        codigo: "L1",
        nombre: "Línea 1",
        recorrido: "Villa El Salvador - Bayóvar",
        tipoDato: .confirmado
    ),

    "L2": LineaMetro(
        codigo: "L2",
        nombre: "Línea 2",
        recorrido: "Puerto del Callao - Municipalidad de Ate",
        tipoDato: .confirmado
    ),

    "L3": LineaMetro(
        codigo: "L3",
        nombre: "Línea 3",
        recorrido: "Comas - San Juan de Miraflores",
        tipoDato: .proyectado
    ),

    "L4": LineaMetro(
        codigo: "L4",
        nombre: "Línea 4",
        recorrido: "Callao - Santa Anita / ramal aeropuerto",
        tipoDato: .proyectado
    ),

    "L5": LineaMetro(
        codigo: "L5",
        nombre: "Línea 5",
        recorrido: "Surquillo - Villa El Salvador",
        tipoDato: .tentativo
    ),

    "L6": LineaMetro(
        codigo: "L6",
        nombre: "Línea 6",
        recorrido: "Independencia / SMP / Comas - La Molina / Surco",
        tipoDato: .tentativo
    )
]


// MARK: - Estaciones

let estacionesPorLinea: [String: [Estacion]] = [

    "L1": [
        Estacion(nombre: "Villa El Salvador", distrito: "Villa El Salvador", referenciaPrincipal: "Av. Separadora Industrial", tipoDato: .confirmado),
        Estacion(nombre: "Parque Industrial", distrito: "Villa El Salvador", referenciaPrincipal: "Av. Separadora Industrial", tipoDato: .confirmado),
        Estacion(nombre: "Pumacahua", distrito: "Villa María del Triunfo", referenciaPrincipal: "Av. Separadora Industrial", tipoDato: .confirmado),
        Estacion(nombre: "Villa María", distrito: "Villa María del Triunfo", referenciaPrincipal: "Av. Separadora Industrial", tipoDato: .confirmado),
        Estacion(nombre: "María Auxiliadora", distrito: "San Juan de Miraflores", referenciaPrincipal: "Hospital María Auxiliadora", tipoDato: .confirmado),
        Estacion(nombre: "San Juan", distrito: "San Juan de Miraflores", referenciaPrincipal: "Av. Los Héroes", tipoDato: .confirmado),
        Estacion(nombre: "Atocongo", distrito: "San Juan de Miraflores", referenciaPrincipal: "Av. Tomás Marsano", tipoDato: .confirmado),
        Estacion(nombre: "Jorge Chávez", distrito: "Santiago de Surco", referenciaPrincipal: "Av. Tomás Marsano", tipoDato: .confirmado),
        Estacion(nombre: "Ayacucho", distrito: "Santiago de Surco", referenciaPrincipal: "Av. Tomás Marsano", tipoDato: .confirmado),
        Estacion(nombre: "Cabitos", distrito: "Santiago de Surco", referenciaPrincipal: "Óvalo Higuereta", tipoDato: .confirmado),
        Estacion(nombre: "Angamos", distrito: "Surquillo / San Borja", referenciaPrincipal: "Av. Aviación", tipoDato: .confirmado),
        Estacion(nombre: "San Borja Sur", distrito: "San Borja", referenciaPrincipal: "Av. Aviación", tipoDato: .confirmado),
        Estacion(nombre: "La Cultura", distrito: "San Borja", referenciaPrincipal: "Av. Aviación", tipoDato: .confirmado),
        Estacion(nombre: "Arriola", distrito: "La Victoria", referenciaPrincipal: "Av. Aviación", tipoDato: .confirmado),
        Estacion(nombre: "Gamarra", distrito: "La Victoria", referenciaPrincipal: "Emporio Comercial de Gamarra", tipoDato: .confirmado),
        Estacion(nombre: "Miguel Grau", distrito: "Lima", referenciaPrincipal: "Av. Grau", tipoDato: .confirmado),
        Estacion(nombre: "El Ángel", distrito: "Lima", referenciaPrincipal: "Cementerio El Ángel", tipoDato: .confirmado),
        Estacion(nombre: "Presbítero Maestro", distrito: "Lima", referenciaPrincipal: "Cementerio Presbítero Maestro", tipoDato: .confirmado),
        Estacion(nombre: "Caja de Agua", distrito: "San Juan de Lurigancho", referenciaPrincipal: "Av. Próceres de la Independencia", tipoDato: .confirmado),
        Estacion(nombre: "Pirámide del Sol", distrito: "San Juan de Lurigancho", referenciaPrincipal: "Av. Próceres de la Independencia", tipoDato: .confirmado),
        Estacion(nombre: "Los Jardines", distrito: "San Juan de Lurigancho", referenciaPrincipal: "Av. Próceres de la Independencia", tipoDato: .confirmado),
        Estacion(nombre: "Los Postes", distrito: "San Juan de Lurigancho", referenciaPrincipal: "Av. Próceres de la Independencia", tipoDato: .confirmado),
        Estacion(nombre: "San Carlos", distrito: "San Juan de Lurigancho", referenciaPrincipal: "Av. Próceres de la Independencia", tipoDato: .confirmado),
        Estacion(nombre: "San Martín", distrito: "San Juan de Lurigancho", referenciaPrincipal: "Av. Próceres de la Independencia", tipoDato: .confirmado),
        Estacion(nombre: "Santa Rosa", distrito: "San Juan de Lurigancho", referenciaPrincipal: "Av. Próceres de la Independencia", tipoDato: .confirmado),
        Estacion(nombre: "Bayóvar", distrito: "San Juan de Lurigancho", referenciaPrincipal: "Av. Próceres de la Independencia", tipoDato: .confirmado)
    ],

    "L2": [
        Estacion(nombre: "Puerto del Callao", distrito: "Callao", referenciaPrincipal: "Puerto del Callao", tipoDato: .confirmado),
        Estacion(nombre: "Buenos Aires", distrito: "Callao", referenciaPrincipal: "Zona urbana del Callao", tipoDato: .confirmado),
        Estacion(nombre: "Juan Pablo II", distrito: "Callao", referenciaPrincipal: "Av. Juan Pablo II", tipoDato: .confirmado),
        Estacion(nombre: "Insurgentes", distrito: "Callao", referenciaPrincipal: "Av. Insurgentes", tipoDato: .confirmado),
        Estacion(nombre: "Carmen de la Legua", distrito: "Carmen de la Legua Reynoso", referenciaPrincipal: "Av. Elmer Faucett", tipoDato: .confirmado),
        Estacion(nombre: "Óscar R. Benavides", distrito: "Bellavista", referenciaPrincipal: "Av. Óscar R. Benavides", tipoDato: .confirmado),
        Estacion(nombre: "San Marcos", distrito: "Lima", referenciaPrincipal: "Universidad Nacional Mayor de San Marcos", tipoDato: .confirmado),
        Estacion(nombre: "Elio", distrito: "Lima", referenciaPrincipal: "Av. Elio", tipoDato: .confirmado),
        Estacion(nombre: "La Alborada", distrito: "Lima", referenciaPrincipal: "Urb. La Alborada", tipoDato: .confirmado),
        Estacion(nombre: "Tingo María", distrito: "Breña", referenciaPrincipal: "Av. Tingo María", tipoDato: .confirmado),
        Estacion(nombre: "Parque Murillo", distrito: "Breña", referenciaPrincipal: "Parque Murillo", tipoDato: .confirmado),
        Estacion(nombre: "Plaza Bolognesi", distrito: "Lima", referenciaPrincipal: "Plaza Bolognesi", tipoDato: .confirmado),
        Estacion(nombre: "Estación Central", distrito: "Lima", referenciaPrincipal: "Paseo Colón / Centro de Lima", tipoDato: .confirmado),
        Estacion(nombre: "Manco Cápac", distrito: "La Victoria", referenciaPrincipal: "Plaza Manco Cápac", tipoDato: .confirmado),
        Estacion(nombre: "Cangallo", distrito: "La Victoria", referenciaPrincipal: "Jr. Cangallo", tipoDato: .confirmado),
        Estacion(nombre: "28 de Julio", distrito: "La Victoria", referenciaPrincipal: "Av. 28 de Julio", tipoDato: .confirmado),
        Estacion(nombre: "Nicolás Ayllón", distrito: "El Agustino", referenciaPrincipal: "Av. Nicolás Ayllón", tipoDato: .confirmado),
        Estacion(nombre: "Circunvalación", distrito: "El Agustino", referenciaPrincipal: "Av. Circunvalación", tipoDato: .confirmado),
        Estacion(nombre: "San Juan de Dios", distrito: "El Agustino", referenciaPrincipal: "Zona San Juan de Dios", tipoDato: .confirmado),
        Estacion(nombre: "Evitamiento", distrito: "El Agustino / Ate", referenciaPrincipal: "Av. Nicolás Ayllón con Vía de Evitamiento", tipoDato: .confirmado),
        Estacion(nombre: "Óvalo Santa Anita", distrito: "Santa Anita / Ate", referenciaPrincipal: "Óvalo Santa Anita", tipoDato: .confirmado),
        Estacion(nombre: "Colectora Industrial", distrito: "Santa Anita / Ate", referenciaPrincipal: "Av. Colectora Industrial", tipoDato: .confirmado),
        Estacion(nombre: "Hermilio Valdizán", distrito: "Ate", referenciaPrincipal: "Hospital Hermilio Valdizán", tipoDato: .confirmado),
        Estacion(nombre: "Mercado Santa Anita", distrito: "Santa Anita", referenciaPrincipal: "Mercado Mayorista de Santa Anita", tipoDato: .confirmado),
        Estacion(nombre: "Vista Alegre", distrito: "Ate", referenciaPrincipal: "Zona Vista Alegre", tipoDato: .confirmado),
        Estacion(nombre: "Prolongación Javier Prado", distrito: "Ate", referenciaPrincipal: "Av. Javier Prado", tipoDato: .confirmado),
        Estacion(nombre: "Municipalidad de Ate", distrito: "Ate", referenciaPrincipal: "Municipalidad de Ate", tipoDato: .confirmado)
    ],

    "L3": [
        Estacion(nombre: "Comas", distrito: "Comas", referenciaPrincipal: "Zona norte de Lima", tipoDato: .proyectado),
        Estacion(nombre: "Naranjal", distrito: "Independencia", referenciaPrincipal: "Av. Túpac Amaru", tipoDato: .proyectado),
        Estacion(nombre: "Estación Central", distrito: "Lima", referenciaPrincipal: "Paseo Colón / Centro de Lima", tipoDato: .proyectado),
        Estacion(nombre: "Parque de la Reserva", distrito: "Lima", referenciaPrincipal: "Circuito Mágico del Agua", tipoDato: .proyectado),
        Estacion(nombre: "Conde de San Isidro", distrito: "San Isidro", referenciaPrincipal: "Av. Arequipa / Av. Javier Prado", tipoDato: .proyectado),
        Estacion(nombre: "Miraflores", distrito: "Miraflores", referenciaPrincipal: "Centro de Miraflores", tipoDato: .proyectado),
        Estacion(nombre: "Cabitos", distrito: "Santiago de Surco", referenciaPrincipal: "Óvalo Higuereta", tipoDato: .proyectado),
        Estacion(nombre: "Los Héroes", distrito: "San Juan de Miraflores", referenciaPrincipal: "Av. Los Héroes", tipoDato: .proyectado)
    ],

    "L4": [
        Estacion(nombre: "Carmen de la Legua", distrito: "Carmen de la Legua Reynoso", referenciaPrincipal: "Conexión con L2", tipoDato: .proyectado),
        Estacion(nombre: "Aeropuerto", distrito: "Callao", referenciaPrincipal: "Aeropuerto Internacional Jorge Chávez", tipoDato: .proyectado),
        Estacion(nombre: "Conde de San Isidro", distrito: "San Isidro", referenciaPrincipal: "Av. Arequipa / Av. Javier Prado", tipoDato: .proyectado),
        Estacion(nombre: "La Cultura", distrito: "San Borja", referenciaPrincipal: "Av. Aviación", tipoDato: .proyectado),
        Estacion(nombre: "Mercado Santa Anita", distrito: "Santa Anita", referenciaPrincipal: "Mercado Mayorista de Santa Anita", tipoDato: .proyectado)
    ],

    "L5": [
        Estacion(nombre: "Surquillo", distrito: "Surquillo", referenciaPrincipal: "Av. Arequipa", tipoDato: .tentativo),
        Estacion(nombre: "Parque Reducto 2", distrito: "Miraflores", referenciaPrincipal: "Parque Reducto N.° 2", tipoDato: .tentativo),
        Estacion(nombre: "Huaca Pucllana", distrito: "Miraflores", referenciaPrincipal: "Huaca Pucllana", tipoDato: .tentativo),
        Estacion(nombre: "Parque Central", distrito: "Miraflores", referenciaPrincipal: "Parque Central de Miraflores", tipoDato: .tentativo),
        Estacion(nombre: "Municipalidad de Miraflores", distrito: "Miraflores", referenciaPrincipal: "Centro de Miraflores", tipoDato: .tentativo),
        Estacion(nombre: "Barranco", distrito: "Barranco", referenciaPrincipal: "Centro de Barranco", tipoDato: .tentativo),
        Estacion(nombre: "Chorrillos", distrito: "Chorrillos", referenciaPrincipal: "Centro de Chorrillos", tipoDato: .tentativo),
        Estacion(nombre: "Villa El Salvador", distrito: "Villa El Salvador", referenciaPrincipal: "Conexión con L1", tipoDato: .tentativo)
    ],

    "L6": [
        Estacion(nombre: "Túpac Amaru", distrito: "Independencia", referenciaPrincipal: "Av. Túpac Amaru", tipoDato: .tentativo),
        Estacion(nombre: "Naranjal", distrito: "Independencia / SMP", referenciaPrincipal: "Zona Naranjal", tipoDato: .tentativo),
        Estacion(nombre: "Canto Grande", distrito: "San Juan de Lurigancho", referenciaPrincipal: "Zona comercial", tipoDato: .tentativo),
        Estacion(nombre: "Huarangal", distrito: "San Juan de Lurigancho", referenciaPrincipal: "Sector Huarangal", tipoDato: .tentativo),
        Estacion(nombre: "Las Flores", distrito: "San Juan de Lurigancho", referenciaPrincipal: "Av. Las Flores", tipoDato: .tentativo),
        Estacion(nombre: "La Molina", distrito: "La Molina", referenciaPrincipal: "Centro de La Molina", tipoDato: .tentativo),
        Estacion(nombre: "Camacho", distrito: "La Molina", referenciaPrincipal: "Zona comercial de Camacho", tipoDato: .tentativo),
        Estacion(nombre: "Universidad de Lima", distrito: "Santiago de Surco", referenciaPrincipal: "Universidad de Lima", tipoDato: .tentativo),
        Estacion(nombre: "Atocongo", distrito: "San Juan de Miraflores", referenciaPrincipal: "Conexión con L1", tipoDato: .tentativo)
    ]
]


// MARK: - Conexiones

let conexiones: [Conexion] = [

    Conexion(
        lineaA: "L1",
        estacionA: "Gamarra",
        lineaB: "L2",
        estacionB: "28 de Julio",
        descripcion: "Conexión del eje Gamarra / 28 de Julio"
    ),

    Conexion(
        lineaA: "L1",
        estacionA: "Cabitos",
        lineaB: "L3",
        estacionB: "Cabitos",
        descripcion: "Conexión entre L1 y L3"
    ),

    Conexion(
        lineaA: "L1",
        estacionA: "La Cultura",
        lineaB: "L4",
        estacionB: "La Cultura",
        descripcion: "Conexión entre L1 y L4"
    ),

    Conexion(
        lineaA: "L2",
        estacionA: "Estación Central",
        lineaB: "L3",
        estacionB: "Estación Central",
        descripcion: "Conexión entre L2 y L3"
    ),

    Conexion(
        lineaA: "L2",
        estacionA: "Carmen de la Legua",
        lineaB: "L4",
        estacionB: "Carmen de la Legua",
        descripcion: "Conexión entre L2 y L4"
    ),

    Conexion(
        lineaA: "L2",
        estacionA: "Mercado Santa Anita",
        lineaB: "L4",
        estacionB: "Mercado Santa Anita",
        descripcion: "Conexión entre L2 y L4"
    ),

    Conexion(
        lineaA: "L3",
        estacionA: "Conde de San Isidro",
        lineaB: "L4",
        estacionB: "Conde de San Isidro",
        descripcion: "Conexión entre L3 y L4"
    ),

    Conexion(
        lineaA: "L1",
        estacionA: "Villa El Salvador",
        lineaB: "L5",
        estacionB: "Villa El Salvador",
        descripcion: "Conexión utilizada para la simulación L1 - L5"
    ),

    Conexion(
        lineaA: "L1",
        estacionA: "Atocongo",
        lineaB: "L6",
        estacionB: "Atocongo",
        descripcion: "Conexión utilizada para la simulación L1 - L6"
    )
]
