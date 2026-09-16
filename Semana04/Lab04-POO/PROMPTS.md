# Prompts utilizados — Laboratorio 04

## Herramienta de IA utilizada

ChatGPT

## Caso 2B — Biblioteca

### Prompt 1:

Soy estudiante de Programación en Móviles Avanzado y estoy trabajando Swift en la semana 4 mediante un Xcode Playground.

Necesito implementar un sistema sencillo de biblioteca utilizando un enum EstadoLibro, un struct Libro y una class Biblioteca.

EstadoLibro debe tener los estados disponible y prestado. Libro debe tener titulo String, autor String y estado EstadoLibro, iniciando como disponible.

Biblioteca debe contener un arreglo de Libro inicialmente vacío y los métodos agregar(libro:), prestar(titulo:) -> Bool, devolver(titulo:) -> Bool e inventario().

Para buscar libros en prestar y devolver utiliza específicamente un recorrido por índices con `for i in 0..<libros.count`. Si el libro está disponible se debe poder prestar y cambiar su estado a prestado. Si ya está prestado debe mostrar un error. devolver debe realizar el proceso inverso. inventario debe utilizar switch para mostrar el estado de cada libro.

Utiliza solamente struct, class, inheritance, protocols, enums, arrays, loops y funciones vistos en clase. No utilices optionals, guard let, firstIndex(where:), didSet, computed properties ni generics.

Devuelve únicamente código Swift y comenta cada línea de manera específica y fácil de entender.

La simulación debe producir exactamente esta salida:

Préstamo aprobado: La ciudad y los perros  
Error: La ciudad y los perros ya está prestado  
Devolución registrada: La ciudad y los perros  
Préstamo aprobado: El Quijote  
Error: no existe El Principito  
===== INVENTARIO =====  
Cien años de soledad (Gabriel García Márquez) - disponible  
La ciudad y los perros (Mario Vargas Llosa) - disponible  
El Quijote (Miguel de Cervantes) - prestado

### Respuesta de la IA:

La IA generó una solución en Swift utilizando `enum EstadoLibro`, `struct Libro` y `class Biblioteca`. También implementó los métodos para agregar, prestar y devolver libros, además de mostrar el inventario. La búsqueda de los libros se realizó mediante índices y se respetaron las restricciones indicadas.

### ¿Funcionó a la primera?

Sí. El código compiló y produjo la salida esperada.

### ¿Usó algo que no hemos visto en clase?

No. La solución utilizó estructuras y conceptos trabajados en clase, como enums, structs, clases, arreglos, ciclos, funciones, condicionales y switch. No utilizó `firstIndex(where:)`, `guard let`, optionals, `didSet`, propiedades calculadas ni genéricos.

## Mi versión (Parte A) vs. la versión de la IA (Parte B)

### ¿Qué hizo distinto la IA respecto a mi solución?

La lógica principal fue muy parecida porque ambas versiones tenían que cumplir los mismos requisitos. La diferencia que más noté fue que la versión de la IA tenía comentarios más detallados explicando prácticamente cada parte del código.

### ¿Hay alguna línea de la IA que no entiendo del todo? ¿Cuál?

No. Pude entender las líneas utilizadas porque la solución se mantuvo dentro de los temas que hemos trabajado en clase.

### ¿Qué me pareció mejor de MI versión?

Mi versión me pareció más directa y sencilla de leer. Al desarrollarla pude entender mejor cómo cambiar el estado de cada libro recorriendo el arreglo mediante sus índices.

### ¿Qué me pareció mejor de la versión de la IA?

Me pareció mejor la forma en que explicó el código mediante comentarios. Esto hizo que fuera más fácil identificar para qué servía cada parte y comparar la solución con la que realicé manualmente.
