@echo off
timeout /t 10 /nobreak >nul
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0volume.ps1"