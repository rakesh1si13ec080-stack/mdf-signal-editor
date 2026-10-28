@echo off
REM Builds a standalone MDF_Signal_Editor.exe (no Python needed on the target PC).
REM Run once on a PC with Python + internet, then copy dist\MDF_Signal_Editor.exe anywhere.
cd /d "%~dp0"
python -m pip install --user -r requirements.txt pyinstaller || goto :err
python -m PyInstaller --noconfirm --onefile --windowed --name MDF_Signal_Editor ^
    --collect-all asammdf mdf_signal_editor.py || goto :err
echo.
echo Done: dist\MDF_Signal_Editor.exe
pause
exit /b 0
:err
echo Build failed.
pause
exit /b 1
