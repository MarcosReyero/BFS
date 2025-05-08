#!/bin/bash

# Datos del servidor
USUARIO="marcos"
SERVIDOR="192.168.8.193"
RUTA_LOCAL="/Volumes/SanDisk"              # Ruta en tu Mac
RUTA_REMOTA="/home/marcos/backup"           # Directorio en el servidor que se quiere respaldar

# Nombre del archivo (basado en fecha)
FECHA=$(date +%Y-%m-%d_%H-%M-%S)
ARCHIVO_IMAGEN="backup_$FECHA.img.gz"
ARCHIVO_TEMPORAL="/home/marcos/$ARCHIVO_IMAGEN"  # Ruta temporal en el servidor

# Mensaje de inicio
echo "📦 Comenzando a comprimir el directorio en el servidor..."

# Paso 1: Crear un archivo comprimido del directorio en el servidor
ssh "$USUARIO@$SERVIDOR" "tar -cf - -C /home/marcos backup | gzip > $ARCHIVO_TEMPORAL"

if [ $? -ne 0 ]; then
    echo "❌ Error al comprimir el directorio remoto"
    exit 1
fi

# Paso 2: Descargar el archivo comprimido a tu máquina local
scp "$USUARIO@$SERVIDOR:$ARCHIVO_TEMPORAL" "$RUTA_LOCAL/"

if [ $? -eq 0 ]; then
    echo "✅ Backup descargado correctamente en $RUTA_LOCAL/$ARCHIVO_IMAGEN"

    # Paso 3: Eliminar el archivo temporal en el servidor
    ssh "$USUARIO@$SERVIDOR" "rm $ARCHIVO_TEMPORAL"
else
    echo "❌ Error al descargar el backup"
    exit 1
fi

# Mensaje final
echo "🏁 El proceso de backup se ha completado exitosamente."
