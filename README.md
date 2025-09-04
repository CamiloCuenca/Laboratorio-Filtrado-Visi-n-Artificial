# 📊 Análisis de Imágenes de un Romboide

Este trabajo consistió en aplicar diferentes transformaciones y filtros a la imagen de un romboide y luego medir dos cosas importantes: **el área** (qué tanto espacio ocupa la figura en la imagen) y **el perímetro** (qué tan largo es el borde que la rodea).

Al comparar los resultados, encontramos lo siguiente:

---

## 🔹 Transformaciones que no cambian mucho la figura

Imágenes como `romboide-and.jpg`, `romboide-binarizado.jpg`, `romboide-gris.jpg`, `romboide-multiplicacion.jpg`, `romboide-or.jpg` y `romboide_dilatado.jpg` dieron exactamente el mismo valor de área y perímetro.
Esto nos dice que la figura sigue siendo la misma, solo cambió la forma en la que se ve (color, contraste, etc.).

---

## 🔹 Transformaciones que hacen crecer la figura

Cuando la imagen se redimensiona o se interpola (`romboide-interpolacion-bilinear.jpg`, `romboide-interpolacion-vecino.jpg`, `romboide-redimensionada.jpg`) el área y el perímetro se disparan hacia arriba.
Esto ocurre porque la figura ocupa más píxeles al hacerse más grande.

---

## 🔹 Transformaciones que hacen más pequeña la figura

Al rotar (`romboide-rotado.jpg`) o aplicar ciertos efectos lógicos como NOT (`romboide-not1.jpg`, `romboide-not2.jpg`), la figura pierde parte de su tamaño.
Se debe a que los bordes se recortan o desaparecen algunos píxeles.

---

## 🔹 Transformaciones que borran la figura

Con operaciones como `romboide-division.jpg` y `romboide-resta.jpg`, el área y perímetro se van a **cero**.
En pocas palabras, la figura desaparece de la imagen.

---

## 🔹 Transformaciones que solo cambian un poco los bordes

Filtros como nitidez (`romboide-nitidez.jpg`), bordes (`romboide_bordes.jpg`) y relieve (`romboide_Relieve.jpg`) hacen que el área se mantenga casi igual, pero el perímetro varíe un poco.
Esto sucede porque los contornos se marcan o se suavizan.

---

## ✅ Conclusión General

Este análisis muestra que:

- El área y perímetro **son estables** si la figura no cambia de tamaño o forma.
- **Crecen mucho** si la figura se agranda.
- **Disminuyen** si se pierde información al rotar o invertir colores.
- Incluso puede pasar que la figura **desaparezca** si la operación borra todos sus píxeles.
