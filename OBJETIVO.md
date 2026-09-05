# Objetivo — Agenda Personal

> Fichero de encargo. Es la **entrada** del workflow: todas las fases lo leen y
> ninguna lo modifica. Si algo de aquí resulta imposible o equivocado durante la
> ejecución, no se corrige en silencio — se anota como hallazgo en la revisión de
> la fase y una persona decide.

---

# Descripcion

Una **agenda personal de escritorio**: una aplicación pequeña para apuntar citas
—fecha, hora, título y notas— y consultarlas por día, sin cuenta de usuario, sin
servidor y sin conexión.

El uso real que tiene que resolver: alguien abre la agenda por la mañana, ve lo
que tiene hoy, añade una cita que le acaban de confirmar, y la cierra. Todo en
menos de un minuto y sin instalar nada.

Se compone de dos piezas que se pueden usar por separado:

- una **herramienta de línea de comandos** en Node.js para añadir, listar,
  buscar y borrar citas;
- una **vista en el navegador**, un fichero HTML estático que se abre con doble
  clic y muestra las citas del día.

Las dos leen y escriben el mismo fichero de datos. No hay proceso servidor entre
ellas.

---

# Requerimientos

## Funcionales

| Id | Requisito | Criterio de aceptación |
|---|---|---|
| **RF-1** | Añadir una cita con fecha, hora, título y notas opcionales | Dado un fichero de datos válido, cuando se añade una cita con fecha `2026-09-10`, hora `09:30` y título `Dentista`, entonces queda persistida y `listar` la devuelve |
| **RF-2** | Listar las citas de un día concreto | Dadas tres citas en dos días distintos, cuando se listan las de uno, entonces salen solo las de ese día y ordenadas por hora ascendente |
| **RF-3** | Buscar citas por texto en título o notas | Dada una cita con título `Dentista`, cuando se busca `dent`, entonces aparece; la búsqueda no distingue mayúsculas ni acentos |
| **RF-4** | Borrar una cita por su identificador | Dada una cita existente, cuando se borra por su id, entonces desaparece del fichero y el resto queda intacto |
| **RF-5** | Ver las citas de un día en el navegador | Dado el fichero de datos con citas de hoy, cuando se abre la vista HTML, entonces se muestran ordenadas por hora, con su título y sus notas |
| **RF-6** | Rechazar entradas inválidas con un error que diga qué falla y dónde | Cuando se añade una cita con fecha `2026-02-30`, entonces se rechaza indicando que el día no existe en ese mes, y el fichero de datos no se toca |

## No funcionales

| Id | Requisito | Criterio de aceptación |
|---|---|---|
| **RNF-1** | Cero dependencias externas | `package.json` sin `dependencies` ni `devDependencies`; el proyecto arranca sin `npm install` |
| **RNF-2** | Funciona sin red | Con la conexión cortada, las cuatro operaciones y la vista funcionan igual |
| **RNF-3** | Los datos son legibles y editables a mano | El fichero de datos es JSON con sangría; una persona puede abrirlo y entenderlo sin herramientas |
| **RNF-4** | Una escritura interrumpida no corrompe los datos | Si el proceso muere a mitad de una escritura, el fichero anterior sigue siendo válido y legible |
| **RNF-5** | Los errores son accionables | Todo mensaje de error dice qué falló, dónde y qué hacer; ninguno dice solo «error» o «no válido» |
| **RNF-6** | Las pruebas corren con el ejecutor de Node | `node --test` pasa en verde sin instalar nada |

---

# Constrains

Restricciones duras. No se negocian durante la ejecución: una fase que necesite
saltarse una de estas tiene que parar y decirlo.

1. **Solo la biblioteca estándar de Node.js.** Cero paquetes de npm, ni de
   producción ni de desarrollo. Node 22 o superior.
2. **Sin servidor y sin red.** La vista es un fichero HTML estático que se abre
   con `file://`. Nada de `http.createServer`, nada de `fetch` a terceros.
3. **Los datos viven en un fichero JSON del proyecto** (`datos/citas.json`). Sin
   base de datos, sin almacenamiento del navegador como fuente de verdad.
4. **El proyecto tiene que poder usarse sin AIF.** Copiado el repositorio y
   retirado `.aif/`, la herramienta y las pruebas siguen funcionando. Ninguna
   dependencia de la herramienta que lo construyó.
5. **Sin `Bash` para el agente.** El techo `local-mvp` autoriza leer, escribir y
   buscar ficheros y nada más. Lo que haya que ejecutar lo ejecutan los
   validators, que son procesos de AIF.
6. **Todo el trabajo ocurre dentro del workspace**, con rutas relativas. Salir
   de él se deniega y tumba la fase.

---

# Asunciones

Lo que damos por cierto sin haberlo comprobado. Cada una es un riesgo: si
resulta falsa, cambia el encargo.

1. **Un solo usuario y una sola máquina.** No hay concurrencia entre personas ni
   sincronización entre dispositivos. Dos procesos a la vez sobre el mismo
   fichero es un caso que *sí* hay que manejar; dos personas, no.
2. **El volumen es pequeño**: del orden de cientos de citas, no de millones.
   Leer el fichero entero en memoria es aceptable y no hace falta índice.
3. **Zona horaria local, sin conversiones.** Las fechas y horas son las del
   reloj de la máquina. No se guardan desplazamientos ni se convierte a UTC.
4. **El navegador es moderno** (Chrome o Edge actuales) y admite módulos ES
   nativos, así que la vista no necesita ni empaquetador ni transpilador.
5. **No hay requisitos legales de retención ni de borrado.** Los datos son
   personales y locales, y su dueño es quien los tiene en el disco.
6. **El idioma es el español**, en la interfaz y en los mensajes de error.

---

# Reglas

Cómo se trabaja. Aplican a todas las fases y su cumplimiento se comprueba en la
revisión de cada una.

1. **Documentación como código.** Todo documento vive en `docs/`, en markdown,
   versionado junto al código y validado por el mismo pipeline. Los diagramas
   van en bloques `mermaid` dentro del propio markdown: un diagrama que no se
   puede diff-ear no cuenta.

2. **Nada sin trazar.** Cada requisito tiene un identificador estable
   (`RF-n`, `RNF-n`, `SEC-n`). El código que lo cubre lo cita con `@trace RF-n`.
   Un requisito sin código y un código sin requisito son las dos caras del mismo
   defecto, y se buscan en los dos sentidos.

3. **Doble check en toda fase.** Cada fase de trabajo tiene su fase de revisión,
   hecha con otro encargo y **sin permiso de edición**: el revisor encuentra, no
   arregla. Encontrar y arreglar son dos actos, y juntarlos es como se cuelan los
   arreglos que nadie revisó.

4. **Toda revisión declara lo que no miró.** Un informe termina siempre con «Lo
   que NO he comprobado». Una revisión sin límites declarados se lee como si lo
   hubiera cubierto todo, y eso es peor que no revisar.

5. **Los huecos se escriben, no se rellenan.** Un apartado que no se puede
   completar se deja como pregunta abierta con su nombre. Inventar un contenido
   plausible para que el documento parezca terminado es el fallo más caro de
   todos, porque nadie lo vuelve a mirar.

6. **La seguridad se piensa dos veces y en dos momentos.** Una sobre el diseño,
   antes de que exista código (`amenazas`); otra sobre el código que ya existe
   (`endurecimiento`). Cada mitigación declarada tiene que poder señalarse con
   fichero y línea; una mitigación afirmada y no implementada es peor que una
   ausente.

7. **Los errores explican.** Ningún mensaje dice solo qué falló: dice dónde y
   qué hacer. Esto vale para la herramienta, para los validators y para los
   informes de revisión.

8. **Una fase no cierra sin firma humana.** El agente prepara la evidencia y
   ejecuta las comprobaciones; la decisión de avanzar es de una persona, siempre.
