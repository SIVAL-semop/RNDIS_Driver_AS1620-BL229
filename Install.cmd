@echo off
chcp 1252 >nul
setlocal enabledelayedexpansion

REM === CONFIGURATION ===
set CERT_NAME=testcert.pfx
set CERT_PASS=Epmsbv,io1lb
set CERT_DIR=%~dp0
set INF_FILE=VST_RNDIS.inf
set TEMP_CER=%TEMP%\temp_cert.cer

echo.
echo [1/4] Import du certificat PFX dans le magasin "Personnel" (Ordinateur local)...
certutil -f -p "%CERT_PASS%" -importpfx "%CERT_DIR%%CERT_NAME%" NoExport

if %errorlevel% neq 0 (
    echo ERREUR : Import échoué.
    goto end
)

echo.
echo [2/4] Extraction du certificat public (.cer) depuis le .pfx...
powershell -command ^
 "$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2('%CERT_DIR%%CERT_NAME%', '%CERT_PASS%'); [System.IO.File]::WriteAllBytes('%TEMP_CER%', $cert.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Cert))"

if not exist "%TEMP_CER%" (
    echo ERREUR : Extraction du certificat .cer échouée.
    goto end
)

echo.
echo [3/4] Ajout du certificat dans les racines de confiance...
certutil -addstore -f Root "%TEMP_CER%"

if %errorlevel% neq 0 (
    echo ERREUR : Échec de l'ajout aux racines de confiance.
    goto end
)

echo.
echo [4/4] Installation du pilote signé...
pnputil /add-driver "%CERT_DIR%%INF_FILE%" /install

if %errorlevel% neq 0 (
    echo ERREUR : L'installation du pilote a échoué.
    goto end
)

echo.
echo Certificat ajouté et pilote installé avec succès.

:end
del /f /q "%TEMP_CER%" >nul 2>&1
pause
endlocal
