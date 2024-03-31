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
    endlocal
    pause
    exit /B 0
) else (
    echo �R���e�i�����݂��܂���B
)

echo %CONTAINER_STATUS% | findstr /b "Up*" > nul 2>&1

if %ERRORLEVEL% == 0 (
    echo �R���e�i�͋N������Ă��܂��B
    endlocal
    pause
    exit /B 0
) else (
    echo �R���e�i�͒�~����Ă��܂��B
)


@rem �R���e�i���쐬�ƋN�������܂��B
docker container run -it -d --name %CONTAINER_NAME% %IMAGE_NAME% > nul 2>&1

if %ERRORLEVEL% == 0 (
    echo �R���e�i�̍쐬�ƋN���ɐ������܂���
) else (
    echo �R���e�i�̍쐬�ƋN���Ɏ��s���܂����B(�G���[�R�[�h: %ERRORLEVEL%)
)

endlocal
pause