@echo off
cd ..\.

mkdir ..\..\SAMSUNG-Drivers-Release
del ..\..\SAMSUNG-Drivers-Release\r9q-Drivers-Desktop.7z

echo @echo off > ..\OnlineUpdater.cmd
echo ^(NET FILE^|^|^(powershell -command Start-Process '%%0' -Verb runAs -ArgumentList '%%* '^&EXIT /B^)^)^>NUL 2^>^&1 >> ..\OnlineUpdater.cmd
echo pushd "%%~dp0" ^&^& cd %%~dp0 >> ..\OnlineUpdater.cmd
echo .\tools\DriverUpdater\%%PROCESSOR_ARCHITECTURE%%\DriverUpdater.exe -r . -d .\definitions\Desktop\ARM64\Internal\r9q.xml >> ..\OnlineUpdater.cmd
echo pause >> ..\OnlineUpdater.cmd

echo @echo off > ..\OfflineUpdater.cmd
echo ^(NET FILE^|^|^(powershell -command Start-Process '%%0' -Verb runAs -ArgumentList '%%* '^&EXIT /B^)^)^>NUL 2^>^&1 >> ..\OfflineUpdater.cmd
echo pushd "%%~dp0" ^&^& cd %%~dp0 >> ..\OfflineUpdater.cmd
echo for /f %%%%a in ('wmic logicaldisk where "VolumeName='WINR9Q'" get deviceid^^^|find ":"')do set "DrivePath=%%%%a" >> ..\OfflineUpdater.cmd
echo if not [%%DrivePath%%]==[] goto start >> ..\OfflineUpdater.cmd
echo if [%%DrivePath%%]==[] echo Automatic WINR9Q detection failed! Enter Drive Letter manually. >> ..\OfflineUpdater.cmd
echo :sdisk >> ..\OfflineUpdater.cmd
echo set /P DrivePath=Enter Drive letter of WINR9Q ^^^(should be X:^^^): >> ..\OfflineUpdater.cmd
echo if [%%DrivePath%%]==[] goto sdisk >> ..\OfflineUpdater.cmd
echo if not "%%DrivePath:~1,1%%"==":" set DrivePath=%%DrivePath%%:>> ..\OfflineUpdater.cmd
echo :start >> ..\OfflineUpdater.cmd
echo if not exist "%%DrivePath%%\Windows\" echo Error! Selected Disk "%%DrivePath%%" doesn't have any Windows installation. ^& pause ^& exit >> ..\OfflineUpdater.cmd
echo .\tools\DriverUpdater\%%PROCESSOR_ARCHITECTURE%%\DriverUpdater.exe -r . -d .\definitions\Desktop\ARM64\Internal\r9q.xml -p %%DrivePath%% >> ..\OfflineUpdater.cmd
echo pause >> ..\OfflineUpdater.cmd

REM echo apps\IPA > filelist_r9q.txt
echo CODE_OF_CONDUCT.md >> filelist_r9q.txt
REM echo components\ANYSOC\Changelog >> filelist_r9q.txt
echo components\ANYSOC\Support\Desktop\SUPPORT.DESKTOP.BASE >> filelist_r9q.txt
echo components\ANYSOC\Support\Desktop\SUPPORT.DESKTOP.MOBILE_BRIDGE >> filelist_r9q.txt
echo components\ANYSOC\Support\Desktop\SUPPORT.DESKTOP.MOBILE_COMPONENTS >> filelist_r9q.txt
echo components\ANYSOC\Support\Desktop\SUPPORT.DESKTOP.MOBILE_RIL >> filelist_r9q.txt
echo components\ANYSOC\Support\Desktop\SUPPORT.DESKTOP.MOBILE_RIL_EXTRAS >> filelist_r9q.txt
echo components\QC8350\Device\DEVICE.SOC_QC8350.R9Q >> filelist_r9q.txt
echo components\QC8350\Device\DEVICE.SOC_QC8350.R9Q_MINIMAL >> filelist_r9q.txt
REM echo components\QC8350\Graphics\GRAPHICS.SOC_QC8350.R9Q_DESKTOP >> filelist_r9q.txt
echo components\QC8350\Platform\PLATFORM.SOC_QC8350.BASE >> filelist_r9q.txt
echo components\QC8350\Platform\PLATFORM.SOC_QC8350.BASE_MINIMAL >> filelist_r9q.txt
echo definitions\Desktop\ARM64\Internal\r9q.xml >> filelist_r9q.txt
echo tools\DriverUpdater >> filelist_r9q.txt
echo LICENSE.md >> filelist_r9q.txt
echo OfflineUpdater.cmd >> filelist_r9q.txt
echo OnlineUpdater.cmd >> filelist_r9q.txt
echo README.md >> filelist_r9q.txt

cd ..
"%ProgramFiles%\7-Zip\7z.exe" a -t7z ..\SAMSUNG-Drivers-Release\r9q-Drivers-Desktop.7z @tools\filelist_r9q.txt -scsWIN
cd tools

del ..\OfflineUpdater.cmd
del ..\OnlineUpdater.cmd
del filelist_r9q.txt
