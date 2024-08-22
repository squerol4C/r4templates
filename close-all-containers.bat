@echo off

@setlocal

@rem 起動中のコンテナをすべて停止させます。
for /F "delims=, tokens=1,2,3" %%c in ('docker ps --format "{{ .ID }},{{ .Names }},{{ .Status }}"') do (
    echo docker container stop %%c
)

pause

@endlocal