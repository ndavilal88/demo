# Plantilla de ADR

Un ADR registra una decision de arquitectura: que se decidio, por que, y que se
descarto. Una decision sin alternativas descartadas no es un ADR — es una
descripcion de lo que se hizo.

Copia esta forma, un fichero por decision, en `docs/adr/ADR-nnn-titulo.md`.

---

    ---
    id: ADR-003
    fase: arquitectura
    estado: aceptado | superado por ADR-nnn
    actualizado: 2026-09-05
    ---

    # ADR-003 - Escritura atomica del fichero de citas

    ## Contexto

    Que problema obliga a decidir algo, y que restricciones lo acotan. Se citan
    los RF- y SEC- implicados. Sin contexto, el lector de dentro de seis meses no
    puede juzgar si la decision sigue valiendo.

    ## Opciones consideradas

    ### A - Escribir directamente sobre citas.json
    Sencillo. Una interrupcion a mitad deja el fichero invalido y se pierden
    todas las citas.

    ### B - Escribir en un temporal y renombrar
    El renombrado es atomico en el sistema de ficheros. Deja un fichero temporal
    si el proceso muere entre medias.

    ### C - Fichero de diario y reconstruccion
    Resistente a todo. Complejidad muy por encima de lo que el problema pide.

    ## Decision

    B. El renombrado atomico cubre RNF-4 con el codigo mas simple de los tres, y
    el temporal huerfano es visible y no rompe nada.

    ## Consecuencias

    Lo que gana el proyecto y lo que cuesta. Incluye lo malo: aqui, que puede
    quedar un `.tmp` si el proceso muere en el peor instante, y que nadie lo
    limpia.

    ## Lo que esta decision NO resuelve

    No protege de dos procesos escribiendo a la vez. Eso es otra decision y no
    se ha tomado.
