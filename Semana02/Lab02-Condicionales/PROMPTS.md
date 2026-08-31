# Prompts utilizados — Laboratorio 02

## Herramienta de IA utilizada
Claude

## Ejercicio 6 — Carrito mejorado

### Prompt (estructura CTRFE):
CONTEXTO: Tengo un carrito de compras en Swift con 5 productos (nombre, precio, cantidad) para un Playground de Xcode.
TAREA: Mejora el carrito agregando: descuento del 5% extra por producto si se compran 3 o más unidades, un cupón "DESCUENTO20" que aplica 20% adicional al total, envío gratis si el total supera S/. 3000 (si no, S/. 25.00), puntos de fidelidad (1 punto por cada S/. 100 de compra), y validación de precios negativos o cantidades en cero.
RESTRICCIONES: Cada línea del código debe tener un comentario explicando específicamente qué hace esa línea, no comentarios genéricos.
FORMATO: Código Swift válido para Playground, usando print() para mostrar los resultados.
EJEMPLO: Mantener la misma estructura de variables (prod, precio, cant) que el carrito del Ejercicio 5.

### ¿Funcionó a la primera?
Sí, el código funcionó correctamente desde la primera versión.

### ¿La IA usó algo que no conocías?
Sí — el uso de una función (func) para reutilizar el cálculo del subtotal con descuento en cada producto, en vez de repetir el mismo cálculo 5 veces.

## Ejercicio 7 — Juego de adivinanza

### Prompt (estructura CTRFE):
CONTEXTO: Necesito un mini juego de adivinanza de números para un Playground de Xcode, sin usar arrays (tema de la semana 3).
TAREA: Genera un juego donde hay un número secreto fijo (42), se simulan 5 intentos con variables individuales, se recorre con un while, y en cada intento se muestra si el número ingresado es "Muy alto", "Muy bajo" o "¡Correcto!". Debe contar cuántos intentos usó y mostrar "Perdiste" si no acierta en 5 intentos.
RESTRICCIONES: No usar arrays. Comentar cada línea explicando la lógica de comparación.
FORMATO: Código Swift con bucle while y condicionales if/else if/else.
EJEMPLO: intento1 = 20, intento2 = 50, etc. (variables individuales, no arreglo).

### ¿Funcionó a la primera?
Sí, funcionó a la primera.

### ¿La IA usó algo que no conocías?
Sí — la combinación de una bandera booleana (adivinado) junto con el contador del while para poder terminar el bucle antes de llegar a los 5 intentos si el jugador acierta antes.
