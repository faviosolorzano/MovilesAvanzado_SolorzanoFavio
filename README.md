# Actividad Propuesta 02 - Herencia: Cliente Natural y Cliente Jurídico

## Descripción

Esta actividad implementa el uso de herencia en Swift mediante una clase base llamada `Cliente` y dos clases derivadas: `ClienteNatural` y `ClienteJuridico`.

Los datos utilizados para demostrar el funcionamiento del programa se encuentran definidos directamente en el código.

## Requerimientos funcionales

### RF01 - Definir los datos generales de un cliente
El sistema debe representar los datos generales de un cliente mediante la clase `Cliente`.

Datos considerados:
- Código
- Dirección
- Fecha de registro
- Número de cuenta
- Monto mínimo de apertura

### RF02 - Representar un cliente natural
El sistema debe representar un cliente natural utilizando los datos generales heredados de `Cliente`.

Además, debe considerar:
- Nombre completo
- DNI

### RF03 - Representar un cliente jurídico
El sistema debe representar un cliente jurídico utilizando los datos generales heredados de `Cliente`.

Además, debe considerar:
- Razón social
- RUC
- Representante legal

### RF04 - Mostrar los datos generales del cliente
El sistema debe mostrar en consola los datos generales correspondientes a un cliente.

### RF05 - Mostrar la información de un cliente natural
El sistema debe mostrar los datos generales heredados y los datos específicos correspondientes al cliente natural.

### RF06 - Mostrar la información de un cliente jurídico
El sistema debe mostrar los datos generales heredados y los datos específicos correspondientes al cliente jurídico.

## Consideraciones

- Los datos de los clientes son constantes definidas directamente en el código.
- No se realiza ingreso de datos mediante teclado.
- `ClienteNatural` y `ClienteJuridico` heredan de la clase `Cliente`.
- Las clases derivadas sobrescriben el método `mostrarDatos()` para mostrar la información correspondiente a cada tipo de cliente.
