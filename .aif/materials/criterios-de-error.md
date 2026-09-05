# Criterios de error

Como se comporta la agenda cuando algo va mal. Vale para la herramienta de linea
de comandos y para la vista.

## Un error tiene tres trabajos

Decir **que** fallo, **donde**, y **que hacer**. Un mensaje que solo cumple el
primero obliga a quien lo lee a investigar, y esa investigacion es exactamente el
trabajo que el mensaje tenia que ahorrarle.

    MAL   Error: fecha no valida
    BIEN  La cita del 2026-02-30 no se anadio: febrero de 2026 tiene 28 dias.
          Corrige la fecha y vuelve a intentarlo.

## Codigos de salida

| Codigo | Significa | Ejemplo |
|---|---|---|
| `0` | La operacion se hizo | La cita se anadio |
| `1` | La entrada no vale | Fecha inexistente, titulo vacio |
| `2` | El estado no permite la operacion | Borrar un id que no existe |
| `3` | Los datos estan corruptos o no se pueden leer | JSON invalido |

Un codigo distinto por causa distinta. Devolver `1` para todo obliga a leer el
texto para saber que paso, y eso impide automatizar.

## Lo que un error NUNCA hace

**No revela rutas absolutas de la maquina.** `C:\Users\ana\agenda\datos` en un
mensaje es una fuga: di `datos/citas.json`, relativo al proyecto.

**No deja los datos a medias.** Una operacion que falla no toca el fichero. Si
hay que escribir, se escribe entero o no se escribe.

**No culpa al usuario.** "Entrada invalida" no es informacion; "el titulo esta
vacio y una cita sin titulo no se puede encontrar despues" si lo es.

**No traga el fallo en silencio.** Una operacion que no se puede completar lo
dice. Un `catch` vacio es un fallo que nadie va a ver hasta que sea caro.

## Casos que hay que cubrir siempre

Fecha que no existe en el calendario. Hora fuera de rango. Titulo vacio o solo
espacios. Id que no existe al borrar. Fichero de datos que no esta. Fichero de
datos con JSON invalido. Fichero de datos con una cita a la que le falta un
campo. Dos citas a la misma hora — que NO es un error: se permiten y se muestran
las dos.
