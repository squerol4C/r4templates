@echo off
setlocal

@rem ���ʊ��ϐ��̓ǂݍ���
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
    echo �R���e�i�͑��݂��܂��B container id = %CONTAINER_ID%
) else (
    echo �R���e�i�����݂��܂���B
    endlocal
    pause
    exit /B 0
)

echo %CONTAINER_STATUS% | findstr /b "Up*" > nul 2>&1

if %ERRORLEVEL% == 0 (
    echo �R���e�i�͋N������Ă��܂��B
) else (
    echo �R���e�i�͒�~����Ă��܂��B
    endlocal
    pause
    exit /B 0
)


@rem �R���e�i���~���܂��B
docker container stop %CONTAINER_ID% > nul 2>&1

if %ERRORLEVEL% == 0 (
    echo �R���e�i�̒�~�ɐ������܂���
) else (
    echo �R���e�i�̒�~�Ɏ��s���܂����B(�G���[�R�[�h: %ERRORLEVEL%)
)

endlocal
pause