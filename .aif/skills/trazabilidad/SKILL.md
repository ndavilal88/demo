# Trazabilidad

Un requisito que nadie implementa y un codigo que nadie pidio son las dos caras
del mismo defecto. La trazabilidad existe para poder hacer esa pregunta en los
dos sentidos y contestarla sin leerlo todo.

## Identificadores

Tres familias, estables desde que nacen:

- RF-n   requisito funcional
- RNF-n  requisito no funcional
- SEC-n  mitigacion de seguridad

Estables significa que **no se renumeran**. Si un requisito desaparece, su numero
desaparece con el y no se reutiliza: un hueco en la numeracion cuenta una
historia, y reutilizar el numero la borra.

## La marca en el codigo

Cada unidad que cubre un requisito lo cita en un comentario:

    // @trace RF-2  Listar las citas de un dia, ordenadas por hora.
    function listarDia(fecha) { ... }

Una linea, junto a lo que cubre. No en un fichero aparte: un mapa que vive lejos
del codigo se queda atras en el primer refactor.

## Las dos preguntas

**Hacia delante**: por cada RF-n hay al menos un @trace RF-n. Si no lo hay, el
requisito no esta implementado — o lo esta y nadie lo marco, que para la revision
es lo mismo.

**Hacia atras**: por cada @trace RF-n existe RF-n en los requisitos. Si no
existe, o el requisito se borro sin limpiar, o alguien invento el numero.

Las dos se comprueban. La segunda se olvida siempre, y es la que caza los
requisitos borrados a medias.

## La tabla de cobertura

En verificacion, tres columnas: requisito, prueba que lo cubre, y donde esta esa
prueba. Un requisito sin fila es un requisito sin verificar, y hay que decirlo
asi en el informe en vez de dejar la fila vacia.

La trampa: una fila rellena no demuestra nada si la prueba que cita no comprueba
lo que el requisito dice. Al revisar, sigue dos filas al azar hasta la asercion.
