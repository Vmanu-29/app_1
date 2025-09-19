# Taller 1 - Flutter

Este proyecto corresponde al **Taller 1** del curso. Es una aplicación en Flutter que integra:

- Cambio de título en la AppBar.  
- Cambio aleatorio del color de fondo.  
- Generación de un número aleatorio.  
- Uso de imágenes tanto desde internet como locales (assets).  
- Interacción mediante botones y ListTiles.  
- Notificaciones mediante SnackBars.  

---

## Autor
- **Nombre:** Víctor Manuelle Sánchez Lozano  
- **Código:** 230232040  

---

## Funcionalidades

1. **Cambiar título**  
   - Al presionar el botón "Cambiar título", el texto de la AppBar cambia entre *hola* y *¡Título cambiado!*.

2. **Cambiar color de fondo**  
   - Selecciona un color aleatorio (RGB) y cambia el fondo de la pantalla.

3. **Generar número aleatorio**  
   - Genera un número entre `0` y `10.000` y lo muestra tanto en pantalla como en un SnackBar.

4. **Visualización de imágenes**  
   - Una imagen cargada desde la web (Wikipedia).  
   - Una imagen local (`assets/flutter_logo.png`).

---

## Estructura del proyecto

```
lib/
 └── main.dart   # Código principal de la aplicación
assets/
 └── flutter_logo.png   # Imagen local
```

---

## Ejecución

1. Clona este repositorio:  
   ```bash
   git clone <url_del_repositorio>
   ```

2. Entra al proyecto:  
   ```bash
   cd taller1
   ```

3. Ejecuta la aplicación:  
   ```bash
   flutter run

