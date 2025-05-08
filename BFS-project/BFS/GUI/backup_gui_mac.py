import tkinter as tk
from tkinter import messagebox
import subprocess
import datetime

def hacer_backup():
    status_label.config(text="⏳ Ejecutando backup...", fg="blue")
    ventana.update_idletasks()

    # Configuración de rutas
    usuario = "marcos"
    servidor = "192.168.8.193"
    ruta_local = "/Volumes/BackupDisk"  # Reemplazar por el nombre del volumen en Mac
    archivo_fecha = datetime.datetime.now().strftime("%Y
