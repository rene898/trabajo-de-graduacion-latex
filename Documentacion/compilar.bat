@echo off
echo ==========================================
echo      Compilando Proyecto LaTeX (Limpio)
echo ==========================================

REM Crear carpeta log si no existe
if not exist log mkdir log

REM Configurar variable de entorno para encontrar archivos en subdirectorios
set TEXINPUTS=.;./NoModificar//;

REM Limpiar archivos temporales antiguos en la raiz si existen
if exist *.aux del *.aux
if exist *.log del *.log
if exist *.toc del *.toc
if exist *.lof del *.lof
if exist *.lot del *.lot
if exist *.bcf del *.bcf
if exist *.run.xml del *.run.xml
if exist *.out del *.out

echo.
echo [1/4] Ejecutando pdflatex (Primera pasada)...
pdflatex -output-directory=log NoModificar/main.tex

echo.
echo [2/4] Ejecutando biber (Procesando bibliografia)...
REM Biber busca el archivo .bcf en la carpeta log y escribe en log
biber --input-directory=log --output-directory=log main

echo.
echo [3/4] Ejecutando pdflatex (Segunda pasada)...
pdflatex -output-directory=log NoModificar/main.tex

echo.
echo [4/4] Ejecutando pdflatex (Tercera pasada)...
pdflatex -output-directory=log NoModificar/main.tex

echo.
echo [Final] Moviendo PDF a la raiz...
copy log\main.pdf main.pdf > nul

echo.
echo ==========================================
echo      Compilacion Finalizada
echo ==========================================
echo.
echo Los archivos temporales estan en la carpeta 'log'.
echo El archivo final es: main.pdf
echo.
pause
