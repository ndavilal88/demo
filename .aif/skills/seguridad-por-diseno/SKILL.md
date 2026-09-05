# Seguridad por diseno

Que una aplicacion sea local, pequena y de un solo usuario no la deja sin
superficie. Hay un fichero que se lee y se escribe, texto que alguien teclea y
una vista que lo pinta. Con eso ya hay algo que modelar.

## Primero, la frontera de confianza

Antes de listar amenazas hay que decir **quien esta dentro y quien fuera**. Sin
eso, "seguro" no significa nada y el modelo se llena de amenazas contra las que
no se puede ni se quiere defender.

En una herramienta local el usuario del sistema esta DENTRO: con su identidad ya
puede borrar el fichero de datos entero, y prometer defensa frente a el seria
prometer otro producto. Lo que esta FUERA es el contenido: un fichero de datos
manipulado, un titulo con HTML dentro, una ruta que intenta salirse.

Escribir esa linea es la mitad del trabajo.

## Categorias, con vector concreto

No sirve "manipulacion: alguien podria manipular datos". Sirve:

    Manipulacion - datos/citas.json editado a mano con un campo fecha que no es
    una fecha. La herramienta lo lee y lo trata como valido.

Recorre las seis: suplantacion, manipulacion, repudio, fuga, denegacion,
elevacion. Una categoria sin amenazas es una respuesta legitima, pero hay que
escribirla como respuesta: "no aplica porque no hay identidades".

## Mitigaciones que son mecanismos

"Se validara la entrada" es un deseo. Un mecanismo es:

    SEC-3 - Toda fecha se valida contra el calendario real antes de escribir, y
    una fecha invalida aborta la operacion sin tocar el fichero.

Y lleva identificador, porque despues alguien tiene que encontrarla en el codigo
con @trace SEC-3.

## El apartado mas valioso

**"Lo que NO se mitiga y por que".** Un riesgo aceptado y escrito es una decision;
uno no mencionado es un descuido. Cada uno con su motivo y con quien tendria que
decidirlo si cambiara de opinion.

## En la segunda pasada, sobre codigo

Cambia la pregunta: ya no es "que podria pasar" sino **"donde esta puesto lo que
prometimos"**. Recorre cada SEC- y busca su sitio con fichero y linea. Una
mitigacion afirmada y no implementada es peor que una ausente: la ausente se ve,
la afirmada tranquiliza y nadie la vuelve a mirar.

Sospechosos habituales en una herramienta como esta: texto del fichero de datos
pintado en HTML sin escapar, rutas construidas con entrada del usuario,
escrituras que dejan el JSON a medias, lecturas sin tope de tamano, y mensajes de
error que revelan rutas absolutas de la maquina.
