# Requerimientos Funcionales
## Sistema de Orientación del Metro de Lima y Callao

---

## 1. Descripción general

El proyecto consiste en una aplicación de consola desarrollada en Swift que permite orientar al usuario dentro de una simulación del Metro de Lima y Callao.

El sistema permite consultar líneas, estaciones, conexiones, rutas y lugares de referencia asociados a diferentes estaciones.

Además, cuenta con validaciones para que el usuario pueda corregir una entrada incorrecta sin que el programa se cierre o regrese automáticamente al menú principal.

> **Nota:** Para fines académicos, el sistema trabaja con una simulación de las 6 líneas registradas en el proyecto. Los datos utilizados pueden estar identificados como confirmados, proyectados o tentativos.

---

## 2. Objetivo funcional

Permitir que el usuario consulte información del Metro de Lima y Callao de manera sencilla, interactiva y comprensible, utilizando estaciones, conexiones, rutas y referencias cercanas para facilitar su orientación.

---

# 3. Requerimientos funcionales

| Código | Requerimiento funcional | Descripción | Evidencia en el programa |
|---|---|---|---|
| **RF01** | Consultar líneas del Metro | El sistema permite visualizar las 6 líneas registradas, mostrando código, nombre, recorrido, cantidad de estaciones cargadas y tipo de dato. | Opción **1. Ver todas las líneas** |
| **RF02** | Consultar estaciones de una línea | El usuario puede ingresar una línea, por ejemplo `L1`, y visualizar todas las estaciones registradas de dicha línea. | Opción **2. Ver estaciones de una línea** |
| **RF03** | Buscar una estación | El usuario puede buscar una estación por nombre y visualizar su línea o líneas, distrito o zona, referencia principal, lugares cercanos y conexiones relacionadas. | Opción **3. Buscar una estación** |
| **RF04** | Consultar conexiones entre líneas | El usuario puede ingresar dos líneas y consultar los puntos de conexión registrados entre ambas. Si existe más de una conexión, el sistema muestra todas. | Opción **4. Consultar conexión entre líneas** |
| **RF05** | Buscar una ruta entre estaciones | El usuario puede ingresar una estación de origen y una de destino. El sistema puede resolver rutas en una misma línea, mediante una conexión directa o utilizando una línea intermedia. | Opción **5. Buscar ruta entre estaciones** |
| **RF06** | Buscar un lugar o referencia | El usuario puede buscar un lugar por nombre o categoría, por ejemplo `hospital`, `universidad`, `centro comercial`, `mall`, `mercado`, `parque` o `aeropuerto`. | Opción **6. Buscar un lugar o referencia** |
| **RF07** | Seleccionar una referencia encontrada | Cuando una búsqueda devuelve varios resultados, el sistema los muestra enumerados para que el usuario pueda seleccionar uno y consultar su información o calcular una ruta hacia dicho lugar. | Dentro de la opción **6** |
| **RF08** | Ir desde una estación hasta un lugar | El usuario puede ingresar una estación de origen y un lugar como destino. El sistema identifica la estación relacionada con el lugar y calcula la ruta hasta dicha estación. | Opción **7. Ir desde una estación hasta un lugar** |
| **RF09** | Mostrar referencias cercanas | El sistema muestra referencias útiles asociadas a determinadas estaciones, como hospitales, universidades, centros comerciales, mercados, avenidas, parques, bibliotecas, aeropuertos y lugares turísticos. | Opciones **3, 6 y 7** |
| **RF10** | Validar datos y permitir reintentos | Si el usuario ingresa una línea, estación, lugar u opción incorrecta, el sistema muestra un mensaje de error y permite intentar nuevamente sin cerrar la consulta. | Aplicado en los flujos interactivos |
| **RF11** | Permitir regresar con la opción 0 | El usuario puede ingresar `0` dentro de las consultas para cancelar una operación o regresar al menú correspondiente. | Opciones **2, 3, 4, 5, 6 y 7** |
| **RF12** | Mostrar resultados enumerados | Cuando una búsqueda devuelve varios resultados, estos se muestran mediante una lista numerada para facilitar la selección del usuario. | Opciones **6 y 7** |
| **RF13** | Ignorar diferencias de escritura | Las búsquedas ignoran diferencias entre mayúsculas, minúsculas, espacios adicionales y tildes para facilitar el ingreso de datos. | Función `normalizarTexto()` |

---

# 4. Detalle de los requerimientos funcionales

## RF01. Consultar líneas del Metro

El sistema permite visualizar las seis líneas registradas:

- Línea 1
- Línea 2
- Línea 3
- Línea 4
- Línea 5
- Línea 6

Para cada línea se muestra:

- Código.
- Nombre.
- Recorrido.
- Cantidad de estaciones cargadas.
- Tipo de dato.

### Ejemplo

```text
L1 - Línea 1
Recorrido: Villa El Salvador - Bayóvar
Estaciones cargadas: 26
Datos: Confirmado
```

---

## RF02. Consultar estaciones de una línea

El usuario puede ingresar el código de una línea.

### Ejemplo

```text
L1
```

El sistema muestra todas las estaciones registradas de dicha línea.

Si el usuario escribe una línea inexistente:

```text
L9
```

el sistema muestra un mensaje de error y vuelve a preguntar.

### Ejemplo

```text
La línea ingresada no existe.
Intenta nuevamente.
```

El usuario puede escribir:

```text
0
```

para regresar al menú principal.

---

## RF03. Buscar una estación

El usuario puede buscar una estación por nombre.

### Ejemplos

```text
Gamarra
Evitamiento
La Cultura
Cabitos
San Marcos
```

El sistema muestra:

- Nombre de la estación.
- Línea o líneas relacionadas.
- Distrito o zona.
- Referencia principal.
- Lugares cercanos.
- Categoría de cada referencia.
- Conexiones registradas.

### Ejemplo

```text
========================================
ESTACIÓN: EVITAMIENTO
========================================

Línea(s): L2
Zona / distrito: El Agustino / Ate
Referencia principal:
Av. Nicolás Ayllón con Vía de Evitamiento
```

También puede mostrar referencias como:

```text
- Puente Santa Anita
- Mall Aventura Santa Anita
- Av. Nicolás Ayllón
- Vía de Evitamiento
```

Después de consultar una estación, el sistema permite:

```text
1. Buscar otra estación
2. Calcular ruta hacia esta estación
0. Volver al menú
```

---

## RF04. Consultar conexiones entre líneas

El usuario puede ingresar dos líneas.

### Ejemplo

```text
Primera línea: L2
Segunda línea: L4
```

El sistema muestra todos los puntos de conexión registrados entre ellas.

### Ejemplo de salida

```text
========================================
CONEXIONES ENTRE L2 Y L4
========================================

Se encontraron 2 conexión(es):

1. Carmen de la Legua
   L2 ↔ L4

2. Mercado Santa Anita
   L2 ↔ L4
```

Si no existe una conexión registrada, el sistema informa al usuario.

---

## RF05. Buscar una ruta entre estaciones

El usuario puede ingresar:

- Una estación de origen.
- Una estación de destino.

### Ejemplo

```text
Origen: Gamarra
Destino: Evitamiento
```

El sistema puede resolver tres tipos de recorrido.

### Caso 1: misma línea

Cuando el origen y el destino pertenecen a la misma línea, se muestran las estaciones del recorrido.

### Caso 2: conexión directa

Cuando el origen y el destino pertenecen a líneas diferentes que tienen una conexión registrada.

```text
Línea de origen
↓
Punto de conexión
↓
Línea de destino
```

### Caso 3: una línea intermedia

Cuando es necesario utilizar una tercera línea.

```text
Línea de origen
↓
Primera conexión
↓
Línea intermedia
↓
Segunda conexión
↓
Línea de destino
```

Al finalizar el recorrido, el sistema puede mostrar referencias útiles de la estación de llegada.

---

## RF06. Buscar un lugar o referencia

El usuario puede buscar un lugar por nombre o por categoría.

### Ejemplos

```text
hospital
universidad
centro comercial
mall
mercado
parque
aeropuerto
Javier Prado
Gamarra
```

### Ejemplo de salida

```text
========================================
RESULTADOS PARA: HOSPITAL
========================================

1. Hospital María Auxiliadora
   Tipo: Hospital
   Estación: María Auxiliadora
   Línea: L1

2. Hospital Nacional Dos de Mayo
   Tipo: Hospital
   Estación: Miguel Grau
   Línea: L1

3. Hospital Hermilio Valdizán
   Tipo: Hospital
   Estación: Hermilio Valdizán
   Línea: L2
```

---

## RF07. Seleccionar una referencia encontrada

Cuando una búsqueda devuelve varios resultados, estos se muestran enumerados.

### Ejemplo

```text
1. Hospital María Auxiliadora
2. Hospital Nacional Dos de Mayo
3. Hospital Hermilio Valdizán
0. Volver
```

El usuario selecciona un resultado mediante su número.

Después de seleccionar una referencia, el sistema muestra:

- Nombre.
- Tipo.
- Estación relacionada.
- Línea.
- Información de orientación.

Luego permite:

```text
1. Ver información de la estación
2. Calcular ruta hacia este lugar
0. Volver
```

---

## RF08. Ir desde una estación hasta un lugar

El usuario puede ingresar directamente una estación de origen y un lugar como destino.

### Ejemplo

```text
Origen:
Gamarra

Lugar:
Mall Aventura
```

El sistema realiza los siguientes pasos:

1. Busca el lugar ingresado.
2. Identifica la estación relacionada.
3. Muestra la línea correspondiente.
4. Calcula la ruta desde la estación de origen.
5. Muestra una orientación final.

### Ejemplo

```text
Lugar:
Mall Aventura Santa Anita

Estación relacionada:
Evitamiento

Línea:
L2
```

Después el programa calcula la ruta desde Gamarra hasta Evitamiento.

---

## RF09. Mostrar referencias cercanas

El sistema almacena referencias útiles relacionadas con determinadas estaciones.

Entre las categorías utilizadas se encuentran:

- Hospital.
- Universidad.
- Centro comercial.
- Mercado.
- Avenida.
- Parque.
- Plaza.
- Aeropuerto.
- Biblioteca.
- Cultura.
- Zona comercial.
- Lugar turístico.
- Vía principal.
- Sitio arqueológico.

### Ejemplos registrados

| Referencia | Estación relacionada | Línea |
|---|---|---|
| Emporio Comercial de Gamarra | Gamarra | L1 |
| Hospital María Auxiliadora | María Auxiliadora | L1 |
| Óvalo Higuereta | Cabitos | L1 |
| Gran Teatro Nacional | La Cultura | L1 |
| Biblioteca Nacional del Perú | La Cultura | L1 |
| La Rambla San Borja | La Cultura | L1 |
| Hospital Nacional Dos de Mayo | Miguel Grau | L1 |
| Cementerio Presbítero Maestro | Presbítero Maestro | L1 |
| Mall del Sur | Atocongo | L1 |
| Universidad Nacional Mayor de San Marcos | San Marcos | L2 |
| Real Plaza Centro Cívico | Estación Central | L2 |
| Mall Aventura Santa Anita | Evitamiento | L2 |
| Puente Santa Anita | Evitamiento | L2 |
| Hospital Hermilio Valdizán | Hermilio Valdizán | L2 |
| Mercado Mayorista de Santa Anita | Mercado Santa Anita | L2 |
| Aeropuerto Internacional Jorge Chávez | Aeropuerto | L4 |
| Huaca Pucllana | Huaca Pucllana | L5 |
| Universidad de Lima | Universidad de Lima | L6 |

---

## RF10. Validar datos y permitir reintentos

El sistema controla errores de entrada.

Entre ellos:

- Línea inexistente.
- Estación inexistente.
- Lugar no encontrado.
- Opción incorrecta.
- Selección fuera del rango.
- Estación de origen inexistente.
- Estación de destino inexistente.

### Ejemplo

```text
Estación:
gamarraa

No se encontró esa estación.
Verifica el nombre e intenta nuevamente.
```

El programa permanece dentro de la misma opción y permite realizar otro intento.

---

## RF11. Permitir regresar con la opción 0

Dentro de las consultas interactivas, el usuario puede escribir:

```text
0
```

para:

- Cancelar una búsqueda.
- Cancelar una ruta.
- Volver a una pantalla anterior.
- Regresar al menú principal.

Esto evita tener que cerrar y ejecutar nuevamente el programa.

---

## RF12. Mostrar resultados enumerados

Cuando una búsqueda devuelve varios resultados, estos aparecen numerados.

### Ejemplo

```text
1. Universidad Nacional Mayor de San Marcos
   Estación: San Marcos
   Línea: L2

2. Universidad de Lima
   Estación: Universidad de Lima
   Línea: L6

0. Volver
```

El usuario selecciona un resultado escribiendo su número.

---

## RF13. Ignorar diferencias de escritura

El sistema utiliza la función:

```swift
normalizarTexto()
```

para facilitar las búsquedas.

Por ejemplo:

```text
Gamarra
gamarra
GAMARRA
  Gamarra
```

son interpretados de la misma manera.

También se ignoran las diferencias producidas por tildes.

Ejemplo:

```text
Bayovar
Bayóvar
```

permiten encontrar la misma estación.

---

# 5. Menú principal del sistema

```text
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
```

---

# 6. Relación entre el menú y los requerimientos funcionales

| Opción | Funcionalidad | Requerimientos relacionados |
|---|---|---|
| **1** | Ver todas las líneas | RF01 |
| **2** | Ver estaciones de una línea | RF02, RF10, RF11, RF13 |
| **3** | Buscar una estación | RF03, RF09, RF10, RF11, RF13 |
| **4** | Consultar conexión entre líneas | RF04, RF10, RF11 |
| **5** | Buscar ruta entre estaciones | RF05, RF10, RF11, RF13 |
| **6** | Buscar un lugar o referencia | RF06, RF07, RF09, RF10, RF11, RF12, RF13 |
| **7** | Ir desde una estación hasta un lugar | RF08, RF09, RF10, RF11, RF12, RF13 |
| **8** | Ver todas las conexiones registradas | RF04 |
| **0** | Salir del programa | Finalización del sistema |

---

# 7. Pruebas de verificación

| N.° | Requerimiento | Entrada de prueba | Resultado esperado |
|---|---|---|---|
| 1 | RF01 | Opción `1` | Mostrar las 6 líneas |
| 2 | RF02 | `L1` | Mostrar las estaciones de la Línea 1 |
| 3 | RF03 | `Gamarra` | Mostrar información, referencias y conexiones |
| 4 | RF04 | `L2` y `L4` | Mostrar Carmen de la Legua y Mercado Santa Anita |
| 5 | RF05 | `Gamarra` → `Evitamiento` | Mostrar ruta utilizando las conexiones registradas |
| 6 | RF06 | `hospital` | Mostrar hospitales registrados |
| 7 | RF07 | Seleccionar uno de los hospitales | Mostrar información del lugar y acciones disponibles |
| 8 | RF08 | `Gamarra` → `Mall Aventura` | Identificar Evitamiento y calcular la ruta |
| 9 | RF09 | Buscar `Evitamiento` | Mostrar referencias cercanas |
| 10 | RF10 | Escribir `L9` | Mostrar error y volver a preguntar |
| 11 | RF11 | Escribir `0` | Cancelar o regresar |
| 12 | RF12 | Buscar `hospital` | Mostrar resultados numerados |
| 13 | RF13 | Escribir `GAMARRA` | Encontrar Gamarra correctamente |

---

# 8. Estructuras utilizadas

## Array

Se utiliza para almacenar listas ordenadas como:

- Estaciones.
- Conexiones.
- Referencias.

## Dictionary

Se utiliza para relacionar cada línea con sus estaciones.

Ejemplo conceptual:

```text
L1 → estaciones de Línea 1
L2 → estaciones de Línea 2
L3 → estaciones de Línea 3
```

## Set

Se utiliza durante el cálculo de rutas para:

- Evitar líneas repetidas.
- Identificar líneas en común entre origen y destino.

## Struct

Se utilizan las siguientes estructuras:

- `LineaMetro`
- `Estacion`
- `Conexion`
- `Referencia`

## Enum

Se utiliza `TipoDato` para clasificar la información:

```text
Confirmado
Proyectado
Tentativo - simulación
```

---

# 9. Validaciones implementadas

El programa cuenta con:

- Validación de líneas.
- Validación de estaciones.
- Validación de lugares.
- Validación de opciones.
- Validación de selecciones numéricas.
- Validación de origen.
- Validación de destino.
- Reintentos mediante `while`.
- Uso de `guard`.
- Uso de `0` para cancelar o regresar.

---

# 10. Tecnologías utilizadas

- Swift.
- Xcode Playground.
- Terminal de macOS.
- Git.
- GitHub.

Conceptos de Swift utilizados:

- Array.
- Dictionary.
- Set.
- Struct.
- Enum.
- Funciones.
- `if`.
- `else`.
- `switch`.
- `for`.
- `while`.
- Opcionales.
- `guard`.
- `readLine()`.
- Manejo de cadenas de texto.

---

# 11. Ubicación del código

El archivo principal se encuentra en:

```text
Semana03/MetroLima/MetroLima.playground/Contents.swift
```

El archivo de requerimientos funcionales se encuentra en:

```text
Semana03/MetroLima/REQUERIMIENTOS_FUNCIONALES.md
```

---

# 12. Ejecución del programa

Desde la raíz del repositorio:

```bash
swift Semana03/MetroLima/MetroLima.playground/Contents.swift
```

---

# 13. Alcance del proyecto

El proyecto corresponde a una simulación académica desarrollada para aplicar conceptos de programación en Swift.

El programa no reemplaza aplicaciones oficiales de transporte ni sistemas de navegación en tiempo real.

Su finalidad es demostrar el uso de colecciones, estructuras, funciones, validaciones, búsquedas, conexiones y lógica de rutas de manera práctica.

---

# 14. Resultado esperado

El sistema debe permitir:

- Consultar las seis líneas.
- Consultar estaciones de una línea.
- Buscar estaciones.
- Consultar conexiones.
- Calcular rutas entre estaciones.
- Buscar lugares por nombre o categoría.
- Seleccionar resultados.
- Calcular rutas hacia lugares.
- Mostrar referencias cercanas.
- Validar errores.
- Permitir reintentos.
- Regresar mediante `0`.
- Realizar búsquedas sin importar mayúsculas, minúsculas o tildes.

El resultado final es una aplicación de consola interactiva desarrollada en Swift que permite orientar al usuario utilizando líneas, estaciones, conexiones, rutas y lugares de referencia.
