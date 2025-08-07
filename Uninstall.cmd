@echo off
chcp 1252 >nul
title Désinstallation du pilote RNDIS et du certificat

set CERT_NAME=TestRNDISCert
set CERT_CER=testcert.cer
set INF_NAME=VST_RNDIS.inf

echo.
echo [1/4] Suppression du certificat du magasin "Personnel" (Ordinateur local)...
certutil -delstore -enterprise -user My "%CERT_NAME%" >nul 2>&1
certutil -delstore -enterprise My "%CERT_NAME%" >nul 2>&1
certutil -delstore My "%CERT_NAME%" >nul 2>&1
echo -> OK

echo.
echo [2/4] Suppression du certificat du magasin "Racines de confiance" (Ordinateur local)...
certutil -delstore Root "%CERT_NAME%" >nul 2>&1
echo -> OK

echo.
echo [3/4] Suppression du pilote installé...
for /f "tokens=1" %%i in ('pnputil /enum-drivers ^| findstr /i "%INF_NAME%"') do (
    echo -> Suppression de %%i ...
    pnputil /delete-driver %%i /uninstall /force >nul 2>&1
    echo -> %%i supprimé
)

echo.
echo [4/4] Nettoyage des fichiers temporaires...
if exist "%CERT_CER%" (
    del /f /q "%CERT_CER%"
    echo -> %CERT_CER% supprimé
)

echo.
echo Désinstallation terminée.
pause
