@echo off

@rem 共通環境変数の読み込み
@call common-env.bat

set CONTAINER_ID=
set CONTAINER_STATUS=

for /F "delims=, tokens=1,2,3" %%c in ('docker ps -a --format "{{ .ID }},{{ .Names }},{{ .Status }}"') do (
    if "%%d" == "%CONTAINER_NAME%" (
        set CONTAINER_ID=%%c
        set CONTAINER_STATUS=%%e
    )
)

if not defined CONTAINER_ID (
    echo コンテナが存在しません。
    endlocal
    pause
    exit /B 0
)

echo %CONTAINER_STATUS% | findstr /b "Up*" > nul 2>&1

if not %ERRORLEVEL% == 0 (
    echo コンテナは停止されています。
    endlocal
    pause
    exit /B 0
)

docker logs -f --tail 50 %CONTAINER_ID%