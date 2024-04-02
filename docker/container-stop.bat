@echo off
setlocal

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

if defined CONTAINER_ID (
    echo コンテナは存在します。 container id = %CONTAINER_ID%
) else (
    echo コンテナが存在しません。
    endlocal
    pause
    exit /B 0
)

echo %CONTAINER_STATUS% | findstr /b "Up*" > nul 2>&1

if %ERRORLEVEL% == 0 (
    echo コンテナは起動されています。
) else (
    echo コンテナは停止されています。
    endlocal
    pause
    exit /B 0
)


@rem コンテナを停止します。
docker container stop %CONTAINER_ID% > nul 2>&1

if %ERRORLEVEL% == 0 (
    echo コンテナの停止に成功しました
) else (
    echo コンテナの停止に失敗しました。(エラーコード: %ERRORLEVEL%)
)

endlocal
pause