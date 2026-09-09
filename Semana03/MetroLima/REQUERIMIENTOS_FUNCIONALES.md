# Requerimientos Funcionales
## Sistema de Orientación del Metro de Lima y Callao

---

## 1. Descripción general

El proyecto consiste en una aplicación de consola desarrollada en Swift para orientar al usuario dentro de una simulación del Metro de Lima y Callao.

El sistema permite consultar líneas, estaciones, conexiones, rutas y lugares de referencia asociados a distintas estaciones.

Además, se han agregado validaciones para que el usuario pueda volver a intentar una consulta si se equivoca, sin regresar automáticamente al menú principal.

> **Nota:** Para fines académicos, el sistema trabaja con una simulación de las 6 líneas registradas en el proyecto. Algunas líneas y estaciones son confirmadas, proyectadas o tentativas.

---

## 2. Objetivo funcional

Permitir que el usuario pueda consultar y utilizar información del Metro de Lima y Callao de manera sencilla, interactiva y comprensible, utilizando estaciones, conexiones y referencias cercanas para facilitar la orientación.

---

# 3. Requerimientos funcionales

| Código | Requerimiento | Descripción | Evidencia en el programa |
|---|---|---|---|
| **RF01** | Consultar líneas del Metro | El sistema debe permitir visualizar las 6 líneas registradas. Para cada línea se muestra su código, nombre, recorrido, cantidad de estaciones cargadas y tipo de dato. | Opción **1. Ver todas las líneas** |
| **RF02** | Consultar estaciones de una línea | El usuario debe poder ingresar una línea, por ejemplo `L1`, y visualizar todas las estaciones registradas en orden. Si ingresa una línea incorrecta, el sistema vuelve a preguntar. | Opción **2. Ver estaciones de una línea** |
| **RF03** | Buscar una estación | El usuario debe poder buscar una estación por nombre. El sistema muestra línea o líneas relacionadas, distrito o zona, referencia principal, lugares cercanos y conexiones registradas. | Opción **3. Buscar una estación** |
| **RF04** | Consultar conexiones entre líneas | El usuario debe poder ingresar dos líneas y consultar los puntos de conexión registrados entre ambas. Si existe más de una conexión, el sistema debe mostrar todas. | Opción **4. Consultar conexión entre líneas** |
| **RF05** | Buscar una ruta entre estaciones | El usuario debe ingresar una estación de origen y una de destino. El sistema debe mostrar una ruta utilizando una misma línea, una conexión directa o una línea intermedia. | Opción **5. Buscar ruta entre estaciones** |
| **RF06** | Buscar un lugar o referencia | El usuario debe poder buscar un lugar por nombre o categoría, por ejemplo `hospital`, `universidad`, `centro comercial`, `mall`, `mercado`, `parque` o `aeropuerto`. | Opción **6. Buscar un lugar o referencia** |
| **RF07** | Seleccionar una referencia encontrada | Cuando una búsqueda devuelve varios resultados, el sistema debe mostrarlos enumerados para que el usuario pueda seleccionar uno. Luego puede consultar la estación relacionada o calcular una ruta hacia ese lugar. | Dentro de la opción **6** |
| **RF08** | Ir desde una estación hasta un lugar | El usuario debe ingresar una estación de origen y un lugar como destino. El sistema identifica la estación relacionada con el lugar y calcula la ruta hasta dicha estación. | Opción **7. Ir desde una estación hasta un lugar** |
| **RF09** | Mostrar referencias cercanas | El sistema debe mostrar referencias útiles asociadas a determinadas estaciones, como hospitales, universidades, centros comerciales, avenidas, mercados, parques, bibliotecas, aeropuertos y zonas turísticas. | Opciones **3, 6 y 7** |
| **RF10** | Validar datos y permitir reintentos | Si el usuario ingresa una línea, estación, lugar u opción incorrecta, el sistema no debe cerrar la consulta. Debe mostrar un mensaje de error y volver a preguntar. | Aplicado en los flujos interactivos |
| **RF11** | Permitir regresar con la opción 0 | En las consultas interactivas, el usuario debe poder ingresar `0` para cancelar la operación o regresar al menú correspondiente. | Aplicado en opciones **2, 3, 4, 5, 6 y 7** |
| **RF12** | Mostrar resultados enumerados | Cuando una búsqueda devuelve varios resultados, estos deben mostrarse mediante una lista numerada para facilitar la selección del usuario. | Opciones **6 y 7** |
| **RF13** | Ignorar diferencias de escritura | Las búsquedas deben ignorar diferencias entre mayúsculas, minúsculas, espacios adicionales y tildes. | Función de normalización de texto |

---

# 4. Detalle de los requerimientos funcionales

## RF01. Consultar líneas del Metro

El sistema debe permitir visualizar las seis líneas registradas:

- Línea 1
- Línea 2
- Línea 3
- Línea 4
- Línea 5
- Línea 6

Para cada línea se debe mostrar:

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
