# Marlin Firmware para Kingroon KP3S 3.0 (GD32F303 / STM32F103)

Este repositorio contiene la versión actualizada de **Marlin 2.1.x (bugfix)** optimizada para la impresora 3D **Kingroon KP3S 3.0** (placa Kingroon v1.3 / MKS Robin Nano v1.2-v1.3 con procesador GD32F303/STM32F103).

---

## 1. Archivos Ya Compilados y Listos para Usar

En la carpeta [`firmware_compilado/`](./firmware_compilado/) tienes los dos binarios generados:

| Carpeta | Descripción | Modo de Nivelación | Archivo a copiar a la SD |
| :--- | :--- | :--- | :--- |
| `firmware_compilado/Sin_BLTouch/` | **Kingroon KP3S 3.0 Stock de fábrica** | Manual Mesh Bed Leveling (4x4 = 16 puntos) | `Robin_nano.bin` |
| `firmware_compilado/Con_BLTouch/` | **Kingroon KP3S con sensor BLTouch / 3D-Touch** | Auto Bed Leveling Bilinear (4x4 = 16 puntos) + Z Probe Wizard | `Robin_nano.bin` |

---

## 2. Cómo Flashear la Impresora

1. Toma una tarjeta **MicroSD** (preferiblemente de 8 GB o 16 GB).
2. Formateala en **FAT32** con tamaño de unidad de asignación de **32 KB** (4096 o 32768 bytes).
3. Copia el archivo `Robin_nano.bin` de la versión que desees a la **raíz** de la tarjeta MicroSD.
4. **Con la impresora apagada**, inserta la tarjeta MicroSD en la ranura de la KP3S.
5. Enciende la impresora. En la pantalla verás una barra de progreso que carga hasta el 100%.
6. Una vez completado y mostrado el menú principal, **apaga la impresora y retira la tarjeta MicroSD** (o borra el archivo `Robin_nano.bin` de la tarjeta para evitar que vuelva a flashear en cada encendido).
7. En el menú de la impresora:
   * **Sin BLTouch:** Ve a *Movimiento > Nivelación de cama* y realiza la calibración manual de los 16 puntos. Guarda en EEPROM (`M500`).
   * **Con BLTouch:** Ve a *Configuración > Calibración de Sonda Z* (Z-Probe Wizard), ajusta la distancia boquilla-cama con una hoja de papel y guarda en EEPROM (`M500`).
8. En tu laminador (Cura / PrusaSlicer / OrcaSlicer), agrega después de `G28` en el G-code inicial:
   ```gcode
   M420 S1 ; Carga la malla de nivelacion guardada en la EEPROM
   ```

---

## 3. Cómo Cambiar de Perfil y Recompilar

Puedes cambiar entre los perfiles en cualquier momento usando el script incluido:

```powershell
# Para aplicar la versión Stock (Sin BLTouch):
.\apply_profile.ps1 -Profile stock_mbl

# Para aplicar la versión Con BLTouch:
.\apply_profile.ps1 -Profile bltouch_abl
```

Para compilar en la terminal:
```powershell
& "C:\Users\erick\.platformio\penv\Scripts\platformio.exe" run -e mks_robin_nano_v1v2
```
O simplemente abriendo la carpeta en **Visual Studio Code** con la extensión **PlatformIO IDE** y haciendo clic en **Build** (✓).

El firmware compilado y encriptado se genera automáticamente en:
`.pio/build/mks_robin_nano_v1v2/Robin_nano.bin`

---

## 4. Cómo Subir este Proyecto a Tu Propio GitHub

1. Entra a [GitHub](https://github.com/new) y crea un nuevo repositorio (por ejemplo: `Kingroon_KP3S_Marlin`). Déjalo vacío (sin README ni .gitignore inicial).
2. En la terminal de esta carpeta, ejecuta:
   ```bash
   git remote add origin https://github.com/TU_USUARIO/TU_REPOSITORIO.git
   git add .
   git commit -m "feat: marlin actualizado para Kingroon KP3S 3.0 (MBL y ABL)"
   git branch -M main
   git push -u origin main
   ```

---

## 5. Cómo Mantener tu Marlin Actualizado en el Futuro

Este repositorio ya tiene configurado el remote `upstream` apuntando al repositorio oficial de Marlin:

```bash
# 1. Traer los cambios más recientes del repositorio oficial de Marlin
git fetch upstream

# 2. Mezclar las últimas correcciones en tu rama principal
git merge upstream/bugfix-2.1.x

# 3. Compilar con PlatformIO para verificar que no haya conflictos
& "C:\Users\erick\.platformio\penv\Scripts\platformio.exe" run -e mks_robin_nano_v1v2

# 4. Subir tus actualizaciones a tu GitHub
git push origin main
```

---

## 6. Compilación Automática en la Nube (GitHub Actions)

Este repositorio incluye un flujo de automatización en [`.github/workflows/build-kp3s-firmware.yml`](./.github/workflows/build-kp3s-firmware.yml):

* Cada vez que hagas `git push` a tu rama `main` en GitHub, GitHub Actions compilará automáticamente en la nube tanto la versión **Sin BLTouch** como la versión **Con BLTouch**.
* Podrás descargar los archivos `Robin_nano.bin` directamente desde la pestaña **Actions** de tu repositorio en GitHub sin necesidad de tener PlatformIO instalado en la computadora donde estés trabajando.


