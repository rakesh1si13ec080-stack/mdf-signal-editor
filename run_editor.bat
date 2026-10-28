@echo off
REM Starts MDF Signal Editor. First run installs the needed Python packages.
cd /d "%~dp0"
python -c "import asammdf, matplotlib" 2>nul || (
    echo Installing required packages - first run only...
    python -m pip install --user -r requirements.txt || (
        echo.
        echo Could not install packages. Check that Python 3.9+ is installed and on PATH,
        echo or use build_exe.bat on a PC with internet to make a standalone .exe.
        pause
        exit /b 1
    )
)
start "" pythonw mdf_signal_editor.py
