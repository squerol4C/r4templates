@echo off

@setlocal

@rem �N�����̃R���e�i�����ׂĒ�~�����܂��B
for /F "delims=, tokens=1,2,3" %%c in ('docker ps --format "{{ .ID }},{{ .Names }},{{ .Status }}"') do (
    echo docker container stop %%c
)

pause

@endlocal