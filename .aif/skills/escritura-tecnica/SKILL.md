# Escritura tecnica

Como se escribe en este proyecto. Aplica a documentos, comentarios de codigo y
mensajes de error.

## Di por que, no solo que

Lo que hace el codigo se lee en el codigo. Lo que no se puede recuperar leyendolo
es por que se hizo asi y que se descarto. Eso es lo que va escrito.

    MAL   // Valida la fecha.
    BIEN  // Se valida contra el calendario real y no con una expresion regular:
          // 2026-02-30 encaja en el patron y no existe.

## Nombra lo que NO cubres

Toda promesa tiene un limite. Escribirlo no debilita el documento: lo hace
utilizable. Quien conoce el limite decide; quien no lo conoce supone de mas.

    Esto detecta un fichero corrupto al leerlo. NO detecta uno que se corrompa
    mientras se lee: para eso haria falta un checksum, y no lo hay.

## Los errores explican

Tres trabajos: decir que fallo, donde, y que hacer.

    MAL   Error: fecha no valida
    BIEN  La cita del 2026-02-30 no se anadio: febrero de 2026 tiene 28 dias.
          Corrige la fecha y vuelve a intentarlo.

Nunca reveles rutas absolutas de la maquina ni estructura interna en un mensaje
que ve el usuario.

## Frases cortas, sin relleno

Espanol claro. Nada de "es importante destacar que", "cabe mencionar", "en el
contexto de". Si una frase se puede borrar sin perder informacion, se borra.

## Cuando algo se midio, dilo

"Es mas rapido" no es informacion. "Tarda 40 ms con 500 citas, medido en la
prueba listar-500" si lo es. Y si no se midio, se dice que no se midio en vez de
escribir un adjetivo.
