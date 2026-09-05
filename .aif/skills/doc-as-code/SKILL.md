# Documentacion como codigo

La documentacion de este proyecto es un artefacto de ingenieria, no un anexo.
Vive junto al codigo, se versiona con el, y se rompe igual que el codigo cuando
esta mal.

## Reglas que se comprueban

**Todo documento va en `docs/` y es markdown.** Nada de formatos binarios: un
documento que no se puede leer en un diff no participa del metodo.

**Todo documento abre con front-matter YAML**, entre lineas de tres guiones:

    ---
    id: 01-requisitos
    fase: requisitos
    estado: borrador | revisado | vigente
    actualizado: 2026-09-05
    ---

**Los diagramas van dentro del markdown**, en bloques de codigo mermaid. Una
imagen exportada envejece sin que nadie se entere; un diagrama en texto cambia en
el mismo commit que lo que describe.

**Los enlaces son relativos** y apuntan a ficheros que existen. Un enlace roto en
el indice es un documento que nadie va a encontrar.

**`docs/README.md` es el mapa** y se actualiza en la misma fase que crea el
documento nuevo. Un documento que no esta en el indice esta perdido.

## Un apartado que no se puede completar no se rellena

Se deja escrito como pregunta abierta, con su nombre:

    ## Politica de retencion
    ABIERTO: no hay decision sobre cuanto tiempo se guardan las citas borradas.
    Hace falta que lo decida el dueno del producto.

Inventar un contenido plausible para que el documento parezca terminado es el
fallo mas caro de todos, porque nadie lo vuelve a mirar.

## Lo que no es doc-as-code

Un documento generado que nadie edita. Un diagrama en PNG. Una tabla que duplica
lo que dice el codigo y se queda atras. Si dos sitios dicen lo mismo, uno va a
mentir: decide cual manda y enlaza al otro.
