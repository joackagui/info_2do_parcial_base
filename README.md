# Crush Candy

Un juego tipo **match-3** inspirado en *Candy Crush*, desarrollado en **Godot Engine**.  
El objetivo es completar metas de puntuación en un límite de tiempo o con una cantidad determinada de movimientos.

---

## 🎮 Descripción General

Puzzle Crush sigue la clásica mecánica de *Candy Crush*:

- Mueve piezas adyacentes para formar combinaciones de **3 o más del mismo color**.  
- Cada combinación otorga puntos y puede generar **bloques especiales** con efectos únicos.  
- El tablero se colapsa automáticamente y se rellenan nuevas piezas después de cada combinación.

El juego incluye:  

- **Menú principal**  
- **Selector de niveles** con desbloqueo progresivo (pasa un nivel para habilitar el siguiente).  
- Dos modos de juego:  
  - **Modo Tiempo** ⏳ → Límite de segundos.  
  - **Modo Movimientos** 🎲 → Límite de intentos.  
- **Meta de puntuación** por nivel (incrementa con la dificultad).  
- **Pop-ups de victoria y derrota** al terminar la partida.

---

## 🕹️ Mecánicas de Juego

### Combinaciones básicas

- **3 en línea** → Se destruyen las piezas, otorgando puntos.  
- **4 en línea** → Crea un bloque especial que destruye **toda una fila o columna**.  
- **5 en línea** → Genera un bloque **estrella** que elimina tanto la fila como la columna de la pieza.  
- **Combinación con pieza arcoíris 🌈** → Elimina todas las piezas del color seleccionado en el tablero.  

### Objetivo

- Alcanzar la **meta de puntos** antes de que se acabe el tiempo o los movimientos.  

---

## 📂 Instalación y Ejecución

1. **Descargar el proyecto**  
   Clona o descarga este repositorio:

   ```bash
   git clone https://github.com/joackagui/info_2do_parcial_base.git


2. **Abrir en Godot**

   *Instala [Godot Engine](https://godotengine.org/download) (v4 recomendado).
   *Abre el proyecto desde el menú de inicio de Godot seleccionando la carpeta.

3. **Ejecutar el juego**

   *Haz clic en **Run Project** ▶️ desde el editor.
   *Se abrirá el **menú principal**.

---

## 📑 Flujo del Juego

1. Desde el **menú principal**, selecciona **Jugar**.
2. En el **selector de niveles**, elige un nivel y un modo:

   *Tiempo
   *Movimientos
3. Completa la **meta de puntos** para ganar.
4. Si ganas → aparece un **popup de victoria** y se desbloquea el siguiente nivel.
5. Si pierdes → aparece un **popup de derrota** y puedes reintentar.

---

## 🌟 Características

*Mecánica match-3 intuitiva.
*Animaciones y sonidos para cada acción.
*Dificultad progresiva en cada nivel.
*Bloques especiales** con efectos estratégicos.
*Modo tiempo y modo movimientos, para variedad de juego.
*Gestión de estados y señales en Godot bien organizada.

---

## 🛠️ Tecnologías

*Godot Engine 4.x
*GDScript para la lógica del juego
*Escenas y nodos de **Godot** para UI y niveles

---

## 👨‍💻 Autor

Juego desarrollado como práctica de desarrollo de videojuegos con Godot Engine.

- **Aguilera Joaquin**

- **Alba Diego**
