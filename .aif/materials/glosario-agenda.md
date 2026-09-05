# Glosario de la agenda

Vocabulario del dominio. Se usa igual en documentos, codigo, mensajes de error e
interfaz. Un mismo concepto con dos nombres es la forma mas barata de que dos
partes del proyecto dejen de entenderse.

**Cita** — una entrada de la agenda. Tiene fecha, hora, titulo y opcionalmente
notas. Es la unica entidad del dominio.

**Id de cita** — identificador estable de una cita, generado al crearla. No se
reutiliza aunque la cita se borre.

**Fecha** — dia del calendario en formato `AAAA-MM-DD`. Siempre local, sin
desplazamiento horario ni conversion a UTC.

**Hora** — momento del dia en formato `HH:MM`, 24 horas. Sin segundos.

**Titulo** — texto corto que describe la cita. Obligatorio y no puede estar
vacio ni ser solo espacios.

**Notas** — texto libre opcional asociado a una cita.

**Dia** — el conjunto de citas que comparten fecha. Es la unidad de consulta
natural de la agenda: se mira un dia, no un rango.

**Fichero de datos** — `datos/citas.json`, la unica fuente de verdad. Legible y
editable a mano.

**Vista** — `web/index.html`, el fichero estatico que muestra las citas de un
dia en el navegador. Lee el fichero de datos y no escribe nunca.

**Herramienta** — la linea de comandos en `src/`. Es lo unico que escribe en el
fichero de datos.

---

## Palabras que NO se usan

**Evento** — se dice cita. **Tarea** — no existe en este producto: una agenda
guarda citas, no pendientes. **Usuario** — hay una sola persona y no hay
cuentas; si hace falta nombrarla, es "quien usa la agenda". **Base de datos** —
es un fichero JSON, y llamarlo base de datos sugiere garantias que no tiene.
