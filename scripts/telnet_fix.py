#!/usr/bin/env python3

import tkinter as tk
from tkinter import messagebox
import os
import subprocess
import shutil

def proceed():
    src_file = "/home/pi/sBITX-toolbox/scripts/sbitx/remote.c"
    dest_dir = "/home/pi/sbitx/"
    dest_file = os.path.join(dest_dir, "remote.c")
    build_command = "./build sbitx"

    try:
        # Copy the file
        shutil.copy(src_file, dest_file)
        messagebox.showinfo("Success", "File copied successfully.")

        # Change directory and build
        os.chdir(dest_dir)
        result = subprocess.run(build_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        if result.returncode == 0:
            messagebox.showinfo("Success", "Build completed successfully. You can restart the sbitx application.")
        else:
            messagebox.showerror("Error", f"Build failed. Please check for errors.\n{result.stderr.decode()}")

    except Exception as e:
        messagebox.showerror("Error", str(e))

def confirm():
    if messagebox.askyesno("Confirm", "Do you want to proceed with the update? This will overwrite /home/pi/sbitx/remote.c and then recompile the sbitx application."):
        proceed()

# GUI setup
root = tk.Tk()
root.title("sbitx Telnet Fix by W9JES")

frame = tk.Frame(root)
frame.pack(padx=10, pady=10)

info_text = """Telnet Fix by W9JES: This update fixes a known bug in the sbitx application.

It involves the 'remote.c' file, which is responsible for managing connections and converting commands for the interface.

The updated file addresses an issue where sbitx would incorrectly close telnet connections.

With this fix, it is no longer necessary to restart the sbitx application each time a telnet connection is established.

This fix applies to sbitx v3.0 to v3.2

This action will overwrite /home/pi/sbitx/remote.c and then recompile the sbitx application.
"""
info_label = tk.Label(frame, text=info_text, justify=tk.LEFT)
info_label.pack()

proceed_button = tk.Button(frame, text="Proceed", command=confirm)
proceed_button.pack(pady=5)

exit_button = tk.Button(frame, text="Exit", command=root.destroy)
exit_button.pack(pady=5)

root.mainloop()
