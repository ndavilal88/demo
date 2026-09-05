# Prototipo HTML5 que se ve como el producto

Un prototipo sirve para decidir, y solo se puede decidir sobre algo que se
parece a lo que se va a construir. Un wireframe gris con cajas y "Lorem ipsum"
no provoca las preguntas que importan.

## Reglas

**Es un fichero que se abre con doble clic.** `prototipo/index.html`, HTML5
completo, sin servidor, sin empaquetador, sin instalacion. Si hay que montar
algo para verlo, la mitad de la gente no lo va a ver.

**Autocontenido y sin red.** Nada de CDN, ni fuentes remotas, ni imagenes de
fuera. El CSS y el JS van dentro del propio fichero o al lado. Se tiene que ver
igual con la conexion cortada — y ese es tambien un Constrain del proyecto.

**Con datos realistas, nunca de relleno.** Citas con titulos que alguien
escribiria de verdad, en fechas y horas plausibles, incluyendo los casos
incomodos: dos citas a la misma hora, un titulo largo que no cabe, un dia vacio.
Los datos falsos bonitos esconden justo los problemas de diseno.

**Navegable de verdad.** Los estados reales se pueden alcanzar pulsando: el dia
con citas, el dia vacio, el error de fecha invalida. Un prototipo de una sola
pantalla estatica no deja decidir nada sobre el recorrido.

**Los estados que no son "todo bien" tambien se prototipan.** Vacio, error, y
carga si la hubiera. Suelen ser la mitad del tiempo de uso real y se dejan
siempre para el final, cuando ya no hay tiempo.

## Lo que hay que dejar escrito al lado

`docs/02-prototipo/decisiones-ux.md` con:

1. **Que se decide con este prototipo.** Las preguntas concretas que responde.
2. **Que se descarto y por que.** Si no hay alternativas, no hubo diseno.
3. **Lo que el prototipo NO resuelve.** Lo que queda abierto, escrito, para que
   nadie lo de por decidido al verlo pintado.

Un prototipo sin ese documento no se puede revisar: solo se puede opinar sobre
el, y la opinion no deja rastro.

## El error mas caro

Que el prototipo prometa algo que el producto no va a poder hacer. Si una
pantalla ensena datos que no existen, o una accion que los Constrains no
permiten, alguien va a firmarlo pensando que eso esta acordado. Cuando el
prototipo y las restricciones se contradigan, mandan las restricciones — y la
contradiccion se escribe.
