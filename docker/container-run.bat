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
    endlocal
    pause
    exit /B 0
) else (
    echo コンテナが存在しません。
)

echo %CONTAINER_STATUS% | findstr /b "Up*" > nul 2>&1

if %ERRORLEVEL% == 0 (
    echo コンテナは起動されています。
    endlocal
    pause
    exit /B 0
) else (
    echo コンテナは停止されています。
)


@rem コンテナを作成と起動をします。
docker container run -it -d --name %CONTAINER_NAME% %IMAGE_NAME% > nul 2>&1

if %ERRORLEVEL% == 0 (
    echo コンテナの作成と起動に成功しました
) else (
    echo コンテナの作成と起動に失敗しました。(エラーコード: %ERRORLEVEL%)
)

endlocal
pause