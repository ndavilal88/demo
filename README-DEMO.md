# Demo AIF — Agenda Personal con Doc-as-Code

Proyecto de demostración listo para ejecutar con `aif`. El encargo está en
[`OBJETIVO.md`](OBJETIVO.md) y el método en [`aif.workflow.yaml`](aif.workflow.yaml).

---

## Qué hay aquí

```
OBJETIVO.md            El encargo: descripción, requerimientos, constrains,
                       asunciones y reglas. Lo leen todas las fases, ninguna lo toca.
aif.workflow.yaml      18 fases: 9 de trabajo + 9 de revisión.
aif.exe                Binario recién compilado del repositorio de AIF.

.aif/skills/           6 skills — cómo se trabaja
.aif/validators/       11 validators — qué se comprueba
.aif/materials/        3 materiales gobernados — qué se pone delante del agente
.aif/contexts/         2 contextos reusables — cómo se compone lo anterior
.aif/.gitignore        Ignora el estado, versiona el catálogo.
```

### Las 18 fases

| # | Trabajo | Revisión | Produce |
|---|---|---|---|
| 1 | `requisitos` | `revision-requisitos` | RF/RNF trazables, casos feos, huecos |
| 2 | `prototipo` | `revision-prototipo` | **HTML5 navegable** que se abre con doble clic |
| 3 | `amenazas` | `revision-amenazas` | **Seguridad sobre el diseño**: frontera de confianza, SEC-n |
| 4 | `arquitectura` | `revision-arquitectura` | C4 en mermaid + ADRs |
| 5 | `sdd` | `revision-sdd` | **SDD ejecutable**: datos, CLI, vista |
| 6 | `construccion` | `revision-construccion` | Código + `test/unidad` + `test/integracion` |
| 7 | `verificacion` | `revision-verificacion` | **`test/e2e`** + cobertura por nivel |
| 8 | `endurecimiento` | `revision-endurecimiento` | **Seguridad sobre el código**: cada SEC-n con fichero y línea |
| 9 | `entrega` | `revision-entrega` | Runbook, notas, pendientes |

**El revisor no tiene `Edit`.** Puede leer todo y escribir un fichero: su informe.
No corrige lo que encuentra. Lo hace cumplir el validator `revision-solo-anade`,
que comprueba contra git que la fase solo **añadió** ficheros.

---

## Cómo se ejecuta

> **Casi todo esto necesita un terminal de verdad.** Firmar no se automatiza: el
> canal exige TTY. Ejecuta los comandos tú, en tu consola, desde `C:\demo`.

### 1. Preparar el proyecto

```bat
aif init
```

Crea `.aif/state`, aplica las migraciones y valida el workflow. Ya está hecho:
dice `workflow "agenda-doc-as-code" con 18 fases`.

### 2. Registrar el catálogo

Cada objeto gobernado es un acto humano firmado. Son **20 firmas** antes de poder
adoptar — no es fricción accidental, es el producto: nada entra al contexto de un
agente sin que una persona lo haya avalado por su digest.

```bat
aif skill register --id doc-as-code
aif skill register --id doble-check
aif skill register --id escritura-tecnica
aif skill register --id prototipo-html5
aif skill register --id seguridad-por-diseno
aif skill register --id trazabilidad

aif validator register --id docs-estructura
aif validator register --id enlaces-vivos
aif validator register --id trazabilidad-ids
aif validator register --id hay-revision
aif validator register --id revision-solo-anade
aif validator register --id hay-amenazas
aif validator register --id hay-prototipo
aif validator register --id sin-secretos
aif validator register --id sin-dependencias
aif validator register --id pruebas-por-nivel
aif validator register --id pasan-pruebas

aif material register --id plantilla-adr      --version 1.0.0
aif material register --id glosario-agenda    --version 1.0.0
aif material register --id criterios-de-error --version 1.0.0
```

### 3. Proponer y adoptar el workflow

```bat
aif propose
aif show --proposal wfp_... --revision 1
```

**`aif show` es el pre-vuelo**: no solo enseña la revisión, dice exactamente qué
impide adoptarla. Mientras falte algo, sale así:

```
NO SE PUEDE ADOPTAR: la fase "requisitos": el validator "docs-estructura" está en
el proyecto pero nadie lo ha aprobado — un fichero en disco no es autoridad
NO SE PUEDE ADOPTAR: el contexto "encargo-agenda": el material "criterios-de-error"
no está aprobado — existir en el catálogo no es estar aprobado
```

Cuando el pre-vuelo esté limpio, `show` imprime el **digest de los contextos
citados**, y ese digest hay que nombrarlo al firmar:

```bat
aif adopt --proposal wfp_... --revision 1 --contexto sha256:...
```

Dos exigencias, y las dos son la misma idea:

- **`--revision N` explícito.** Firmar «la última» sería firmar lo que haya en ese
  instante y no lo que has leído.
- **`--contexto <digest>`.** Un contexto gobernado se cita por slug en el
  workflow, pero lo que se firma son sus bytes. Nombrar el digest es lo que
  distingue firmar de firmar a ciegas.

### 4. Ejecutar

```bat
aif run
```

Avanza hasta la primera puerta humana y para. Entonces:

```bat
aif status                       :: dónde quedó y por qué
aif gate approve                 :: o
aif gate reject --motivo "..."   :: el motivo entra en el contexto del intento siguiente
aif run                          :: continúa
```

Y así 18 veces. Cuando un validator bloqueante salga en rojo, la fase queda en
`gate_blocked` y no se puede firmar: se arregla y se reintenta con
`aif run --reintentos 1`.

```bat
aif audit                        :: todo lo que quedó registrado
aif cancel --motivo "..."        :: parar el run
```

---

## Detalles que conviene saber

**El techo de capacidades.** `local-mvp v1` autoriza `Read`, `Write`, `Edit`,
`Glob`, `Grep`, `NotebookEdit` y `TodoWrite`. **No hay `Bash`**: una fase que lo
pidiera haría el workflow inadoptable. Por eso las fases de revisión piden solo
`Read, Write, Glob, Grep` — sin `Edit` no pueden tocar lo que revisan.

**Los validators no están bajo ese techo.** Corren como procesos de AIF, así que
sí usan git, PowerShell y `node --test`. `pasan-pruebas` ejecuta las pruebas de
verdad: un validator que solo comprueba que el fichero de test existe no
comprueba nada.

**Un validator que no se puede ejecutar no es una fase fallida.** `pasan-pruebas`
sale con código 3 si Node no está en el PATH — eso es una instalación incompleta,
no un veredicto sobre el trabajo, y AIF los distingue.

**El aviso del workspace está en las 18 fases.** El agente trabaja en un worktree
y las herramientas de fichero están confinadas a él. Sin decirlo, sale a explorar
la raíz del proyecto, se le deniega y la fase muere.

**`.aif/.gitignore` es nuestro, no de AIF.** El que AIF escribe ignora `.aif/`
entera con un `*`, lo cual es correcto para el estado pero se llevaría por delante
el catálogo gobernado. AIF solo crea el suyo si no hay ninguno, así que el nuestro
manda: ignora `state/`, `material/` y `workspaces/`, y versiona `skills/`,
`validators/`, `materials/` y `contexts/`.

**El proyecto tiene que sobrevivir sin AIF.** Es el Constrain 4 y la última
revisión lo comprueba: copiado el repositorio y retirado `.aif/`, la agenda y sus
pruebas siguen funcionando.

---

## Qué se quedó de la demo anterior

Las ramas `aif/run_*` de los runs previos siguen en git — AIF no las borra a
propósito: ahí está lo que el agente llegó a hacer. Si quieres empezar del todo
limpio:

```bat
git branch --list "aif/*"
git branch -D aif/run_...
```
