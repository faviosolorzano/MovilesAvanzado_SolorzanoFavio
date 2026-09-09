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


// MARK: - Referencias

let referencias: [Referencia] = [

    Referencia(
        nombre: "Emporio Comercial de Gamarra",
        categoria: "Zona comercial",
        estacion: "Gamarra",
        linea: "L1",
        orientacion: "Referencia principal para acceder al emporio comercial y a la Av. Aviación."
    ),

    Referencia(
        nombre: "Av. Aviación",
        categoria: "Avenida",
        estacion: "Gamarra",
        linea: "L1",
        orientacion: "La estación se encuentra sobre el eje de la Av. Aviación."
    ),

    Referencia(
        nombre: "Hospital María Auxiliadora",
        categoria: "Hospital",
        estacion: "María Auxiliadora",
        linea: "L1",
        orientacion: "Referencia útil para llegar al hospital y al sector de San Juan de Miraflores."
    ),

    Referencia(
        nombre: "Óvalo Higuereta",
        categoria: "Vía principal",
        estacion: "Cabitos",
        linea: "L1",
        orientacion: "Punto vial conocido de la zona de Surco."
    ),

    Referencia(
        nombre: "Gran Teatro Nacional",
        categoria: "Cultura",
        estacion: "La Cultura",
        linea: "L1",
        orientacion: "Referencia cultural importante del sector de San Borja."
    ),

    Referencia(
        nombre: "Biblioteca Nacional del Perú",
        categoria: "Biblioteca",
        estacion: "La Cultura",
        linea: "L1",
        orientacion: "Referencia cultural ubicada en el sector de San Borja."
    ),

    Referencia(
        nombre: "La Rambla San Borja",
        categoria: "Centro comercial",
        estacion: "La Cultura",
        linea: "L1",
        orientacion: "Centro comercial usado como referencia del sector."
    ),

    Referencia(
        nombre: "Hospital Nacional Dos de Mayo",
        categoria: "Hospital",
        estacion: "Miguel Grau",
        linea: "L1",
        orientacion: "Referencia hospitalaria del eje de Av. Grau."
    ),

    Referencia(
        nombre: "Cementerio Presbítero Maestro",
        categoria: "Cementerio / patrimonio",
        estacion: "Presbítero Maestro",
        linea: "L1",
        orientacion: "Referencia histórica y cultural de la zona."
    ),

    Referencia(
        nombre: "Mall del Sur",
        categoria: "Centro comercial",
        estacion: "Atocongo",
        linea: "L1",
        orientacion: "Centro comercial del sector de San Juan de Miraflores."
    ),

    Referencia(
        nombre: "Puerto del Callao",
        categoria: "Puerto",
        estacion: "Puerto del Callao",
        linea: "L2",
        orientacion: "Referencia principal de la zona portuaria."
    ),

    Referencia(
        nombre: "Universidad Nacional Mayor de San Marcos",
        categoria: "Universidad",
        estacion: "San Marcos",
        linea: "L2",
        orientacion: "Referencia educativa importante de la zona."
    ),

    Referencia(
        nombre: "Plaza Bolognesi",
        categoria: "Plaza",
        estacion: "Plaza Bolognesi",
        linea: "L2",
        orientacion: "Punto conocido del Cercado de Lima."
    ),

    Referencia(
        nombre: "Real Plaza Centro Cívico",
        categoria: "Centro comercial",
        estacion: "Estación Central",
        linea: "L2",
        orientacion: "Referencia comercial importante del Centro de Lima."
    ),

    Referencia(
        nombre: "Centro de Lima",
        categoria: "Zona urbana",
        estacion: "Estación Central",
        linea: "L2",
        orientacion: "Referencia para llegar a zonas del centro histórico."
    ),

    Referencia(
        nombre: "Puente Santa Anita",
        categoria: "Puente / vía",
        estacion: "Evitamiento",
        linea: "L2",
        orientacion: "Referencia vial cercana al cruce de Nicolás Ayllón con Vía de Evitamiento."
    ),

    Referencia(
        nombre: "Mall Aventura Santa Anita",
        categoria: "Centro comercial",
        estacion: "Evitamiento",
        linea: "L2",
        orientacion: "Centro comercial usado como referencia del sector de Santa Anita."
    ),

    Referencia(
        nombre: "Av. Nicolás Ayllón",
        categoria: "Avenida",
        estacion: "Evitamiento",
        linea: "L2",
        orientacion: "La estación se encuentra en este eje vial."
    ),

    Referencia(
        nombre: "Vía de Evitamiento",
        categoria: "Vía principal",
        estacion: "Evitamiento",
        linea: "L2",
        orientacion: "Referencia vial principal para reconocer la zona."
    ),

    Referencia(
        nombre: "Óvalo Santa Anita",
        categoria: "Óvalo",
        estacion: "Óvalo Santa Anita",
        linea: "L2",
        orientacion: "Referencia principal de la zona."
    ),

    Referencia(
        nombre: "Hospital Hermilio Valdizán",
        categoria: "Hospital",
        estacion: "Hermilio Valdizán",
        linea: "L2",
        orientacion: "Referencia de salud asociada a la estación."
    ),

    Referencia(
        nombre: "Mercado Mayorista de Santa Anita",
        categoria: "Mercado",
        estacion: "Mercado Santa Anita",
        linea: "L2",
        orientacion: "Referencia comercial importante de Lima Este."
    ),

    Referencia(
        nombre: "Av. Javier Prado",
        categoria: "Avenida",
        estacion: "Prolongación Javier Prado",
        linea: "L2",
        orientacion: "Eje vial importante para orientarse en Lima Este."
    ),

    Referencia(
        nombre: "Circuito Mágico del Agua",
        categoria: "Parque / turismo",
        estacion: "Parque de la Reserva",
        linea: "L3",
        orientacion: "Referencia turística del Parque de la Reserva."
    ),

    Referencia(
        nombre: "Av. Javier Prado",
        categoria: "Avenida",
        estacion: "Conde de San Isidro",
        linea: "L3",
        orientacion: "Cruce importante con Av. Arequipa."
    ),

    Referencia(
        nombre: "Aeropuerto Internacional Jorge Chávez",
        categoria: "Aeropuerto",
        estacion: "Aeropuerto",
        linea: "L4",
        orientacion: "Principal referencia del ramal aeroportuario."
    ),

    Referencia(
        nombre: "Huaca Pucllana",
        categoria: "Sitio arqueológico",
        estacion: "Huaca Pucllana",
        linea: "L5",
        orientacion: "Referencia turística usada dentro de la simulación."
    ),

    Referencia(
        nombre: "Parque Central de Miraflores",
        categoria: "Parque",
        estacion: "Parque Central",
        linea: "L5",
        orientacion: "Referencia céntrica de Miraflores dentro de la simulación."
    ),

    Referencia(
        nombre: "Centro de Barranco",
        categoria: "Zona urbana",
        estacion: "Barranco",
        linea: "L5",
        orientacion: "Referencia cultural y turística dentro de la simulación."
    ),

    Referencia(
        nombre: "Universidad de Lima",
        categoria: "Universidad",
        estacion: "Universidad de Lima",
        linea: "L6",
        orientacion: "Referencia educativa dentro de la simulación."
    ),

    Referencia(
        nombre: "Camacho",
        categoria: "Zona comercial",
        estacion: "Camacho",
        linea: "L6",
        orientacion: "Referencia comercial dentro de la simulación."
    )
]


// MARK: - Funciones auxiliares

func normalizarTexto(_ texto: String) -> String {
    return texto
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .folding(
            options: [.diacriticInsensitive, .caseInsensitive],
            locale: Locale(identifier: "es_PE")
        )
        .lowercased()
}

func normalizarLinea(_ texto: String) -> String {
    return normalizarTexto(texto).uppercased()
}

func estacionesDeLinea(_ codigo: String) -> [Estacion] {
    return estacionesPorLinea[normalizarLinea(codigo)] ?? []
}

func buscarEstaciones(
    _ nombre: String
) -> [(linea: String, estacion: Estacion)] {

    let buscado = normalizarTexto(nombre)

    var resultados:
        [(linea: String, estacion: Estacion)] = []

    for (codigo, estaciones) in estacionesPorLinea {

        for estacion in estaciones {

            if normalizarTexto(estacion.nombre) == buscado {

                resultados.append(
                    (
                        linea: codigo,
                        estacion: estacion
                    )
                )
            }
        }
    }

    return resultados.sorted {
        $0.linea < $1.linea
    }
}

func referenciasDeEstacion(
    _ nombre: String
) -> [Referencia] {

    let buscado = normalizarTexto(nombre)

    return referencias.filter {
        normalizarTexto($0.estacion) == buscado
    }
}

func buscarLugar(
    _ texto: String
) -> [Referencia] {

    let buscado = normalizarTexto(texto)

    return referencias.filter {

        normalizarTexto($0.nombre).contains(buscado)

        ||

        normalizarTexto($0.categoria).contains(buscado)

        ||

        normalizarTexto($0.orientacion).contains(buscado)
    }
}


// MARK: - Funciones de conexiones

func conexionesEntre(
    _ lineaA: String,
    _ lineaB: String
) -> [Conexion] {

    let a = normalizarLinea(lineaA)
    let b = normalizarLinea(lineaB)

    return conexiones.filter {

        (
            $0.lineaA == a &&
            $0.lineaB == b
        )

        ||

        (
            $0.lineaA == b &&
            $0.lineaB == a
        )
    }
}

func conexionesDeLinea(
    _ linea: String
) -> [Conexion] {

    let codigo = normalizarLinea(linea)

    return conexiones.filter {
        $0.lineaA == codigo ||
        $0.lineaB == codigo
    }
}

func estacionConexion(
    _ conexion: Conexion,
    para linea: String
) -> String {

    return conexion.lineaA == normalizarLinea(linea)
        ? conexion.estacionA
        : conexion.estacionB
}

func otraLinea(
    _ conexion: Conexion,
    desde linea: String
) -> String {

    return conexion.lineaA == normalizarLinea(linea)
        ? conexion.lineaB
        : conexion.lineaA
}


// MARK: - Rutas

func recorridoEntre(
    _ origen: String,
    _ destino: String,
    en linea: String
) -> [String]? {

    let estaciones = estacionesDeLinea(linea)

    let origenClave = normalizarTexto(origen)
    let destinoClave = normalizarTexto(destino)

    guard
        let inicio = estaciones.firstIndex(
            where: {
                normalizarTexto($0.nombre) == origenClave
            }
        ),

        let fin = estaciones.firstIndex(
            where: {
                normalizarTexto($0.nombre) == destinoClave
            }
        )
    else {
        return nil
    }

    if inicio <= fin {

        return estaciones[
            inicio...fin
        ]
        .map {
            $0.nombre
        }

    } else {

        return estaciones[
            fin...inicio
        ]
        .reversed()
        .map {
            $0.nombre
        }
    }
}

func imprimirTramo(
    desde origen: String,
    hasta destino: String,
    linea: String
) {

    if let recorrido = recorridoEntre(
        origen,
        destino,
        en: linea
    ) {

        print(
            "\(linea): \(recorrido.joined(separator: " → "))"
        )

    } else {

        print(
            "\(linea): \(origen) → ... → \(destino)"
        )
    }
}

func mostrarReferenciasLlegada(
    _ estacion: String
) {

    let refs = referenciasDeEstacion(estacion)

    guard !refs.isEmpty else {
        return
    }

    print("\nAl llegar puedes ubicarte con:")

    for ref in refs.prefix(4) {
        print("- \(ref.nombre)")
    }
}

func buscarRuta(
    origen: String,
    destino: String
) {

    let origenes = buscarEstaciones(origen)
    let destinos = buscarEstaciones(destino)

    guard !origenes.isEmpty else {
        print("No se encontró la estación de origen.")
        return
    }

    guard !destinos.isEmpty else {
        print("No se encontró la estación de destino.")
        return
    }

    let lineasOrigen = Set(
        origenes.map {
            $0.linea
        }
    )

    let lineasDestino = Set(
        destinos.map {
            $0.linea
        }
    )

    let compartidas = lineasOrigen
        .intersection(lineasDestino)
        .sorted()

    print("\n========================================")
    print("RUTA SUGERIDA")
    print("========================================")

    print(
        "Origen: \(origenes[0].estacion.nombre)"
    )

    print(
        "Destino: \(destinos[0].estacion.nombre)\n"
    )

    // Caso 1: misma línea

    for linea in compartidas {

        if let recorrido = recorridoEntre(
            origen,
            destino,
            en: linea
        ) {

            print("Usa \(linea).\n")

            print(
                recorrido.joined(
                    separator: " → "
                )
            )

            print(
                "\nEstaciones del recorrido: \(recorrido.count)"
            )

            mostrarReferenciasLlegada(
                destinos[0].estacion.nombre
            )

            return
        }
    }

    // Caso 2: conexión directa

    for lineaOrigen in lineasOrigen.sorted() {

        for lineaDestino in lineasDestino.sorted() {

            if let conexion = conexionesEntre(
                lineaOrigen,
                lineaDestino
            ).first {

                let puntoA = estacionConexion(
                    conexion,
                    para: lineaOrigen
                )

                let puntoB = estacionConexion(
                    conexion,
                    para: lineaDestino
                )

                print("1. Toma \(lineaOrigen).")

                imprimirTramo(
                    desde: origen,
                    hasta: puntoA,
                    linea: lineaOrigen
                )

                print(
                    "2. Realiza la conexión: \(puntoA) → \(puntoB)."
                )

                print(
                    "3. Continúa por \(lineaDestino)."
                )

                imprimirTramo(
                    desde: puntoB,
                    hasta: destino,
                    linea: lineaDestino
                )

                print(
                    "\nRuta de líneas: \(lineaOrigen) → \(lineaDestino)"
                )

                mostrarReferenciasLlegada(
                    destinos[0].estacion.nombre
                )

                return
            }
        }
    }

    // Caso 3: una línea intermedia

    for lineaOrigen in lineasOrigen.sorted() {

        for primera in conexionesDeLinea(lineaOrigen) {

            let intermedia = otraLinea(
                primera,
                desde: lineaOrigen
            )

            for lineaDestino in lineasDestino.sorted() {

                guard intermedia != lineaDestino else {
                    continue
                }

                if let segunda = conexionesEntre(
                    intermedia,
                    lineaDestino
                ).first {

                    let p1A = estacionConexion(
                        primera,
                        para: lineaOrigen
                    )

                    let p1B = estacionConexion(
                        primera,
                        para: intermedia
                    )

                    let p2A = estacionConexion(
                        segunda,
                        para: intermedia
                    )

                    let p2B = estacionConexion(
                        segunda,
                        para: lineaDestino
                    )

                    print("1. Toma \(lineaOrigen).")

                    imprimirTramo(
                        desde: origen,
                        hasta: p1A,
                        linea: lineaOrigen
                    )

                    print(
                        "2. Conecta con \(intermedia): \(p1A) → \(p1B)."
                    )

                    imprimirTramo(
                        desde: p1B,
                        hasta: p2A,
                        linea: intermedia
                    )

                    print(
                        "3. Conecta con \(lineaDestino): \(p2A) → \(p2B)."
                    )

                    imprimirTramo(
                        desde: p2B,
                        hasta: destino,
                        linea: lineaDestino
                    )

                    print(
                        "\nRuta de líneas: \(lineaOrigen) → \(intermedia) → \(lineaDestino)"
                    )

                    mostrarReferenciasLlegada(
                        destinos[0].estacion.nombre
                    )

                    return
                }
            }
        }
    }

    print(
        "No se encontró una ruta con las conexiones registradas."
    )
}


// MARK: - Funciones de presentación

func titulo(_ texto: String) {
    print("\n========================================")
    print(texto)
    print("========================================")
}

func pedir(_ mensaje: String) -> String {
    print(mensaje, terminator: " ")
    return readLine() ?? ""
}

func mostrarLineas() {

    titulo("LÍNEAS DEL METRO DE LIMA Y CALLAO")

    print("Total de líneas: \(lineas.count)\n")

    for codigo in lineas.keys.sorted() {

        guard let linea = lineas[codigo] else {
            continue
        }

        print("\(codigo) - \(linea.nombre)")
        print("Recorrido: \(linea.recorrido)")
        print("Estaciones cargadas: \(estacionesDeLinea(codigo).count)")
        print("Datos: \(linea.tipoDato.rawValue)\n")
    }
}

func mostrarEstacionesDeLinea(_ codigo: String) {

    let clave = normalizarLinea(codigo)

    guard let linea = lineas[clave] else {
        print("La línea ingresada no existe.")
        return
    }

    let estaciones = estacionesDeLinea(clave)

    titulo("\(linea.nombre.uppercased()) - ESTACIONES")

    print("Recorrido: \(linea.recorrido)")
    print("Cantidad: \(estaciones.count)\n")

    for (indice, estacion) in estaciones.enumerated() {
        print("\(indice + 1). \(estacion.nombre)")
    }
}

func mostrarInformacionEstacion(_ nombre: String) {

    let resultados = buscarEstaciones(nombre)

    guard !resultados.isEmpty else {
        print("No se encontró la estación ingresada.")
        return
    }

    let estacionPrincipal = resultados[0].estacion

    titulo("ESTACIÓN: \(estacionPrincipal.nombre.uppercased())")

    let lineasEncontradas = Set(
        resultados.map {
            $0.linea
        }
    ).sorted()

    print(
        "Línea(s): \(lineasEncontradas.joined(separator: ", "))"
    )

    print(
        "Zona / distrito: \(estacionPrincipal.distrito)"
    )

    print(
        "Referencia principal: \(estacionPrincipal.referenciaPrincipal)"
    )

    let refs = referenciasDeEstacion(
        estacionPrincipal.nombre
    )

    print("\n¿QUÉ HAY CERCA?")

    if refs.isEmpty {

        print("- No hay referencias adicionales registradas.")

    } else {

        for ref in refs {
            print("- \(ref.nombre)")
            print("  Tipo: \(ref.categoria)")
            print("  \(ref.orientacion)")
        }
    }

    let clave = normalizarTexto(
        estacionPrincipal.nombre
    )

    let conexionesRelacionadas = conexiones.filter {

        normalizarTexto($0.estacionA) == clave
        ||
        normalizarTexto($0.estacionB) == clave
    }

    print("\nCONEXIONES")

    if conexionesRelacionadas.isEmpty {

        print("- No tiene conexiones registradas con otras líneas.")

    } else {

        for conexion in conexionesRelacionadas {

            print(
                "- \(conexion.lineaA) [\(conexion.estacionA)] ↔ \(conexion.lineaB) [\(conexion.estacionB)]"
            )
        }
    }
}

func mostrarConexion(
    _ lineaA: String,
    _ lineaB: String
) {

    let a = normalizarLinea(lineaA)
    let b = normalizarLinea(lineaB)

    guard
        lineas[a] != nil,
        lineas[b] != nil
    else {
        print("Una de las líneas ingresadas no existe.")
        return
    }

    guard a != b else {
        print("Debes ingresar dos líneas diferentes.")
        return
    }

    let lista = conexionesEntre(a, b)

    guard !lista.isEmpty else {
        print("No hay conexiones registradas entre \(a) y \(b).")
        return
    }

    titulo("CONEXIONES ENTRE \(a) Y \(b)")

    print(
        "Se encontraron \(lista.count) conexión(es):\n"
    )

    for (indice, conexion) in lista.enumerated() {

        print("\(indice + 1). \(conexion.estacionA)")

        if conexion.estacionA == conexion.estacionB {

            print(
                "   \(conexion.lineaA) ↔ \(conexion.lineaB)"
            )

        } else {

            print(
                "   \(conexion.lineaA): \(conexion.estacionA)"
            )

            print(
                "   \(conexion.lineaB): \(conexion.estacionB)"
            )
        }

        print(
            "   \(conexion.descripcion)\n"
        )
    }
}

func mostrarTodasLasConexiones() {

    titulo("TODAS LAS CONEXIONES")

    for (indice, conexion) in conexiones.enumerated() {

        print(
            "\(indice + 1). \(conexion.lineaA) [\(conexion.estacionA)] ↔ \(conexion.lineaB) [\(conexion.estacionB)]"
        )

        print(
            "   \(conexion.descripcion)"
        )
    }
}



// MARK: - Flujos interactivos

func flujoEstacionesPorLinea() {

    while true {

        titulo("ESTACIONES POR LÍNEA")

        print("""
        Líneas disponibles:
        L1 - L2 - L3 - L4 - L5 - L6

        Escribe 0 para volver.
        """)

        let codigo = pedir("Ingrese una línea:")

        if normalizarTexto(codigo) == "0" {
            return
        }

        let linea = normalizarLinea(codigo)

        guard lineas[linea] != nil else {

            print(
                "\nLa línea ingresada no existe. Intenta nuevamente."
            )

            continue
        }

        mostrarEstacionesDeLinea(linea)

        print("""
        
        1. Consultar otra línea
        0. Volver al menú
        """)

        while true {

            let opcion = pedir("Seleccione una opción:")

            if opcion == "1" {
                break
            }

            if opcion == "0" {
                return
            }

            print(
                "Opción no válida. Intenta nuevamente."
            )
        }
    }
}

func flujoBuscarEstacion() {

    while true {

        titulo("BUSCAR ESTACIÓN")

        print("""
        Ejemplos:
        - Gamarra
        - Evitamiento
        - La Cultura
        - Cabitos
        - San Marcos

        Escribe 0 para volver.
        """)

        let entrada = pedir("Estación:")

        if normalizarTexto(entrada) == "0" {
            return
        }

        let resultados = buscarEstaciones(entrada)

        if resultados.isEmpty {

            print(
                "\nNo se encontró esa estación."
            )

            print(
                "Verifica el nombre e intenta nuevamente."
            )

            continue
        }

        mostrarInformacionEstacion(entrada)

        while true {

            print("""
            
            ¿Qué deseas hacer?

            1. Buscar otra estación
            2. Calcular ruta hacia esta estación
            0. Volver al menú
            """)

            let opcion = pedir("Seleccione una opción:")

            switch opcion {

            case "1":
                break

            case "2":

                while true {

                    let origen = pedir(
                        "¿Desde qué estación partes? (0 para cancelar):"
                    )

                    if normalizarTexto(origen) == "0" {
                        break
                    }

                    if buscarEstaciones(origen).isEmpty {

                        print(
                            "No encontramos esa estación de origen."
                        )

                        continue
                    }

                    buscarRuta(
                        origen: origen,
                        destino: resultados[0]
                            .estacion
                            .nombre
                    )

                    break
                }

            case "0":
                return

            default:

                print(
                    "Opción no válida."
                )

                continue
            }

            break
        }
    }
}

func flujoConsultarConexion() {

    while true {

        titulo("CONSULTAR CONEXIÓN")

        print("""
        Ejemplo:
        Primera línea: L2
        Segunda línea: L4

        Escribe 0 para volver.
        """)

        let lineaA = pedir("Primera línea:")

        if normalizarTexto(lineaA) == "0" {
            return
        }

        guard
            lineas[
                normalizarLinea(lineaA)
            ] != nil
        else {

            print(
                "La primera línea no existe."
            )

            continue
        }

        let lineaB = pedir("Segunda línea:")

        if normalizarTexto(lineaB) == "0" {
            return
        }

        guard
            lineas[
                normalizarLinea(lineaB)
            ] != nil
        else {

            print(
                "La segunda línea no existe."
            )

            continue
        }

        mostrarConexion(
            lineaA,
            lineaB
        )

        while true {

            print("""
            
            1. Consultar otra conexión
            0. Volver al menú
            """)

            let opcion = pedir("Seleccione una opción:")

            if opcion == "1" {
                break
            }

            if opcion == "0" {
                return
            }

            print(
                "Opción no válida."
            )
        }
    }
}

func flujoBuscarRuta() {

    while true {

        titulo("BUSCAR RUTA")

        print("""
        Ejemplo:
        Origen: Gamarra
        Destino: Evitamiento

        Escribe 0 para volver.
        """)

        var origenValido: String?

        while origenValido == nil {

            let origen = pedir("Estación de origen:")

            if normalizarTexto(origen) == "0" {
                return
            }

            if buscarEstaciones(origen).isEmpty {

                print(
                    "No se encontró esa estación de origen."
                )

            } else {

                origenValido = origen
            }
        }

        var destinoValido: String?

        while destinoValido == nil {

            let destino = pedir("Estación de destino:")

            if normalizarTexto(destino) == "0" {
                return
            }

            if buscarEstaciones(destino).isEmpty {

                print(
                    "No se encontró esa estación de destino."
                )

            } else {

                destinoValido = destino
            }
        }

        if let origen = origenValido,
           let destino = destinoValido {

            buscarRuta(
                origen: origen,
                destino: destino
            )
        }

        while true {

            print("""
            
            1. Buscar otra ruta
            0. Volver al menú
            """)

            let opcion = pedir("Seleccione una opción:")

            if opcion == "1" {
                break
            }

            if opcion == "0" {
                return
            }

            print(
                "Opción no válida."
            )
        }
    }
}

func flujoDetalleReferencia(
    _ referencia: Referencia
) {

    while true {

        titulo(
            referencia.nombre.uppercased()
        )

        print(
            "Tipo: \(referencia.categoria)"
        )

        print(
            "Estación relacionada: \(referencia.estacion)"
        )

        print(
            "Línea: \(referencia.linea)"
        )

        print(
            "Orientación: \(referencia.orientacion)"
        )

        print("""
        
        ¿Qué deseas hacer?

        1. Ver información de la estación
        2. Calcular ruta hacia este lugar
        0. Volver
        """)

        let opcion = pedir("Seleccione una opción:")

        switch opcion {

        case "1":

            mostrarInformacionEstacion(
                referencia.estacion
            )

        case "2":

            while true {

                let origen = pedir(
                    "¿Desde qué estación partes? (0 para cancelar):"
                )

                if normalizarTexto(origen) == "0" {
                    break
                }

                if buscarEstaciones(origen).isEmpty {

                    print(
                        "No encontramos esa estación."
                    )

                    continue
                }

                titulo(
                    "RUTA HACIA \(referencia.nombre.uppercased())"
                )

                buscarRuta(
                    origen: origen,
                    destino: referencia.estacion
                )

                print(
                    "\nAl llegar:"
                )

                print(
                    referencia.orientacion
                )

                break
            }

        case "0":
            return

        default:

            print(
                "Opción no válida."
            )
        }
    }
}

func flujoBuscarLugar() {

    while true {

        titulo("BUSCAR LUGAR O REFERENCIA")

        print("""
        Puedes buscar por nombre o por tipo.

        Ejemplos:
        - hospital
        - universidad
        - centro comercial
        - mall
        - mercado
        - parque
        - aeropuerto
        - Javier Prado
        - Gamarra

        Escribe 0 para volver.
        """)

        let texto = pedir("¿Qué estás buscando?:")

        if normalizarTexto(texto) == "0" {
            return
        }

        let resultados = buscarLugar(texto)

        if resultados.isEmpty {

            print(
                "\nNo encontramos resultados para '\(texto)'."
            )

            print(
                "Intenta con otra palabra."
            )

            continue
        }

        titulo(
            "RESULTADOS PARA: \(texto.uppercased())"
        )

        for (indice, referencia) in resultados.enumerated() {

            print(
                "\(indice + 1). \(referencia.nombre)"
            )

            print(
                "   Tipo: \(referencia.categoria)"
            )

            print(
                "   Estación: \(referencia.estacion)"
            )

            print(
                "   Línea: \(referencia.linea)\n"
            )
        }

        print(
            "0. Volver"
        )

        while true {

            let seleccion = pedir(
                "Selecciona un resultado:"
            )

            if seleccion == "0" {
                break
            }

            guard
                let numero = Int(seleccion),
                numero >= 1,
                numero <= resultados.count
            else {

                print(
                    "Selección no válida."
                )

                continue
            }

            flujoDetalleReferencia(
                resultados[
                    numero - 1
                ]
            )

            break
        }
    }
}



func flujoIrAUnLugar() {

    while true {

        titulo("IR DESDE UNA ESTACIÓN HASTA UN LUGAR")

        print("""
        Ejemplo:

        Origen:
        Gamarra

        Lugar:
        Mall Aventura

        Escribe 0 para volver.
        """)

        let origen = pedir(
            "¿Desde qué estación partes?:"
        )

        if normalizarTexto(origen) == "0" {
            return
        }

        guard !buscarEstaciones(origen).isEmpty else {

            print(
                "No encontramos esa estación."
            )

            continue
        }

        let lugar = pedir(
            "¿A qué lugar deseas llegar?:"
        )

        if normalizarTexto(lugar) == "0" {
            return
        }

        let resultados = buscarLugar(lugar)

        if resultados.isEmpty {

            print(
                "No encontramos ese lugar."
            )

            continue
        }

        var elegido: Referencia?

        if resultados.count == 1 {

            elegido = resultados[0]

        } else {

            titulo("VARIOS RESULTADOS")

            for (indice, ref) in resultados.enumerated() {

                print(
                    "\(indice + 1). \(ref.nombre)"
                )

                print(
                    "   Estación: \(ref.estacion)"
                )

                print(
                    "   Línea: \(ref.linea)\n"
                )
            }

            print(
                "0. Cancelar"
            )

            while elegido == nil {

                let seleccion = pedir(
                    "Selecciona el destino:"
                )

                if seleccion == "0" {
                    break
                }

                guard
                    let numero = Int(seleccion),
                    numero >= 1,
                    numero <= resultados.count
                else {

                    print(
                        "Opción no válida."
                    )

                    continue
                }

                elegido = resultados[
                    numero - 1
                ]
            }
        }

        guard let destino = elegido else {
            continue
        }

        titulo("CÓMO LLEGAR")

        print(
            "Lugar: \(destino.nombre)"
        )

        print(
            "Estación relacionada: \(destino.estacion)"
        )

        print(
            "Línea: \(destino.linea)\n"
        )

        buscarRuta(
            origen: origen,
            destino: destino.estacion
        )

        print(
            "\nOrientación final:"
        )

        print(
            destino.orientacion
        )

        while true {

            print("""
            
            1. Buscar otro lugar
            0. Volver al menú
            """)

            let opcion = pedir("Seleccione una opción:")

            if opcion == "1" {
                break
            }

            if opcion == "0" {
                return
            }

            print(
                "Opción no válida."
            )
        }
    }
}



// MARK: - Menú principal

func ejecutarMenu() {

    var continuar = true

    while continuar {

        print(
        """

        ========================================
             METRO DE LIMA Y CALLAO
        ========================================
          Sistema académico de orientación

        1. Ver todas las líneas
        2. Ver estaciones de una línea
        3. Buscar una estación
        4. Consultar conexión entre líneas
        5. Buscar ruta entre estaciones
        6. Buscar un lugar o referencia
        7. Ir desde una estación hasta un lugar
        8. Ver todas las conexiones
        0. Salir

        ========================================
        """
        )

        let opcion = pedir(
            "Seleccione una opción:"
        )

        switch normalizarTexto(opcion) {

        case "1":

            mostrarLineas()

            print(
                "\nPresiona Enter para volver al menú..."
            )

            _ = readLine()

        case "2":

            flujoEstacionesPorLinea()

        case "3":

            flujoBuscarEstacion()

        case "4":

            flujoConsultarConexion()

        case "5":

            flujoBuscarRuta()

        case "6":

            flujoBuscarLugar()

        case "7":

            flujoIrAUnLugar()

        case "8":

            mostrarTodasLasConexiones()

            print(
                "\nPresiona Enter para volver al menú..."
            )

            _ = readLine()

        case "0":

            continuar = false

            print(
                "\nGracias por utilizar el sistema."
            )

        default:

            print("""
            
            Opción no válida.
            Ingresa un número entre 0 y 8.
            """)
        }
    }
}


// MARK: - Inicio

ejecutarMenu()
