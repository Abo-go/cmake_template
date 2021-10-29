set PRJ_PATH=%~dp0

xcopy %ALICE_PATH%\build\Release\xmlbus.dll			%PRJ_PATH%\build\Release\						/s /y
xcopy %ALICE_PATH%\thirdparty\KTraceNet\*.dll			%PRJ_PATH%\build\Release\						/s /y

xcopy %OpenCV_Dir%\..\bin\*.dll                            %PRJ_PATH%\build\Release\						/s /y

@echo ********************************************************************************
@echo * Qt��                                                                         *
@echo ********************************************************************************
xcopy %QT_PATH%\plugins\platforms\qminimal.dll      %PRJ_PATH%\build\Release\plugins\platforms\      /s /y
xcopy %QT_PATH%\plugins\platforms\qoffscreen.dll    %PRJ_PATH%\build\Release\plugins\platforms\      /s /y
xcopy %QT_PATH%\plugins\platforms\qwindows.dll      %PRJ_PATH%\build\Release\plugins\platforms\      /s /y
xcopy %QT_PATH%\plugins\imageformats\qdds.dll       %PRJ_PATH%\build\Release\plugins\imageformats\   /s /y
xcopy %QT_PATH%\plugins\imageformats\qgif.dll       %PRJ_PATH%\build\Release\plugins\imageformats\   /s /y
xcopy %QT_PATH%\plugins\imageformats\qicns.dll      %PRJ_PATH%\build\Release\plugins\imageformats\   /s /y
xcopy %QT_PATH%\plugins\imageformats\qico.dll       %PRJ_PATH%\build\Release\plugins\imageformats\   /s /y
xcopy %QT_PATH%\plugins\imageformats\qjpeg.dll      %PRJ_PATH%\build\Release\plugins\imageformats\   /s /y
xcopy %QT_PATH%\plugins\imageformats\qsvg.dll       %PRJ_PATH%\build\Release\plugins\imageformats\   /s /y
xcopy %QT_PATH%\plugins\imageformats\qtga.dll       %PRJ_PATH%\build\Release\plugins\imageformats\   /s /y
xcopy %QT_PATH%\plugins\imageformats\qtiff.dll      %PRJ_PATH%\build\Release\plugins\imageformats\   /s /y
xcopy %QT_PATH%\plugins\imageformats\qwbmp.dll      %PRJ_PATH%\build\Release\plugins\imageformats\   /s /y
xcopy %QT_PATH%\plugins\imageformats\qwebp.dll      %PRJ_PATH%\build\Release\plugins\imageformats\   /s /y
xcopy %QT_PATH%\bin\Qt5Core.dll                     %PRJ_PATH%\build\Release\                        /s /y
xcopy %QT_PATH%\bin\Qt5Gui.dll                      %PRJ_PATH%\build\Release\                        /s /y
xcopy %QT_PATH%\bin\Qt5Network.dll                  %PRJ_PATH%\build\Release\                        /s /y
xcopy %QT_PATH%\bin\Qt5Widgets.dll                  %PRJ_PATH%\build\Release\                        /s /y
xcopy %QT_PATH%\bin\Qt5PrintSupport.dll             %PRJ_PATH%\build\Release\                        /s /y

xcopy %QT_PATH%\plugins\platforms\qminimald.dll     %PRJ_PATH%\build\Debug\plugins\platforms\        /s /y
xcopy %QT_PATH%\plugins\platforms\qoffscreend.dll   %PRJ_PATH%\build\Debug\plugins\platforms\        /s /y
xcopy %QT_PATH%\plugins\platforms\qwindowsd.dll     %PRJ_PATH%\build\Debug\plugins\platforms\        /s /y
xcopy %QT_PATH%\plugins\imageformats\qddsd.dll      %PRJ_PATH%\build\Debug\plugins\imageformats\     /s /y
xcopy %QT_PATH%\plugins\imageformats\qgifd.dll      %PRJ_PATH%\build\Debug\plugins\imageformats\     /s /y
xcopy %QT_PATH%\plugins\imageformats\qicnsd.dll     %PRJ_PATH%\build\Debug\plugins\imageformats\     /s /y
xcopy %QT_PATH%\plugins\imageformats\qicod.dll      %PRJ_PATH%\build\Debug\plugins\imageformats\     /s /y
xcopy %QT_PATH%\plugins\imageformats\qjpegd.dll     %PRJ_PATH%\build\Debug\plugins\imageformats\     /s /y
xcopy %QT_PATH%\plugins\imageformats\qsvgd.dll      %PRJ_PATH%\build\Debug\plugins\imageformats\     /s /y
xcopy %QT_PATH%\plugins\imageformats\qtgad.dll      %PRJ_PATH%\build\Debug\plugins\imageformats\     /s /y
xcopy %QT_PATH%\plugins\imageformats\qtiffd.dll     %PRJ_PATH%\build\Debug\plugins\imageformats\     /s /y
xcopy %QT_PATH%\plugins\imageformats\qwbmpd.dll     %PRJ_PATH%\build\Debug\plugins\imageformats\     /s /y
xcopy %QT_PATH%\plugins\imageformats\qwebpd.dll     %PRJ_PATH%\build\Debug\plugins\imageformats\     /s /y
xcopy %QT_PATH%\bin\Qt5Cored.dll                    %PRJ_PATH%\build\Debug\                          /s /y
xcopy %QT_PATH%\bin\Qt5Guid.dll                     %PRJ_PATH%\build\Debug\                          /s /y
xcopy %QT_PATH%\bin\Qt5Networkd.dll                 %PRJ_PATH%\build\Debug\                          /s /y
xcopy %QT_PATH%\bin\Qt5Widgetsd.dll                 %PRJ_PATH%\build\Debug\                          /s /y
xcopy %QT_PATH%\bin\Qt5PrintSupportd.dll            %PRJ_PATH%\build\Debug\                        /s /y

@echo ********************************************************************************
@echo * 8. laguage                                                                   *
@echo ********************************************************************************
xcopy %PRJ_PATH%\data\langs\mocapserver_en.qm    %PRJ_PATH%\build\Debug\plugins\langs\        /s /y
xcopy %PRJ_PATH%\data\langs\mocapserver_zh.qm    %PRJ_PATH%\build\Debug\plugins\langs\        /s /y
xcopy %PRJ_PATH%\data\langs\mocapclient_en.qm      %PRJ_PATH%\build\Debug\plugins\langs\      /s /y
xcopy %PRJ_PATH%\data\langs\mocapclient_zh.qm      %PRJ_PATH%\build\Debug\plugins\langs\      /s /y
xcopy %PRJ_PATH%\data\langs\migration_en.qm      %PRJ_PATH%\build\Debug\plugins\langs\        /s /y
xcopy %PRJ_PATH%\data\langs\migration_zh.qm      %PRJ_PATH%\build\Debug\plugins\langs\        /s /y

xcopy %PRJ_PATH%\data\langs\mocapserver_en.qm    %PRJ_PATH%\build\Release\plugins\langs\      /s /y
xcopy %PRJ_PATH%\data\langs\mocapserver_zh.qm    %PRJ_PATH%\build\Release\plugins\langs\      /s /y
xcopy %PRJ_PATH%\data\langs\mocapclient_en.qm      %PRJ_PATH%\build\Release\plugins\langs\    /s /y
xcopy %PRJ_PATH%\data\langs\mocapclient_zh.qm      %PRJ_PATH%\build\Release\plugins\langs\    /s /y
xcopy %PRJ_PATH%\data\langs\migration_en.qm      %PRJ_PATH%\build\Release\plugins\langs\      /s /y
xcopy %PRJ_PATH%\data\langs\migration_zh.qm      %PRJ_PATH%\build\Release\plugins\langs\      /s /y

@echo off
:Wait
set /a n+=1
if %n% gtr 6 goto End
ping -n 2 127.0.0.1>nul
echo .
goto Wait
:End