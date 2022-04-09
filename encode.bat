@echo off
set VideoPath="E:\tmp\"
:: ����t�@�C����ۑ�����f�B���N�g���ɍ��킹�Đݒ肷��B
%~d1 
cd %~dp1
set EXEPATH=%~dp0

::/* �N������ EDCB or D&D(�}�j���A���N��) �𔻕ʂ�EDCB����Ă΂�Ă�����p�����ݒ���X�L�b�v�B
if %EDCB%1==11 (
  ping localhost -n 5 >nul:
  goto START
) else set EDCB=0

::/* D&D ���[�h���̃p�����[�^��ݒ�
:MENU
cls
echo 
echo  ������I�����ĉ������B�i1�`8���̐����œ��́A�ȗ���������0���f�t�H���g�j
echo -----------------------------------------------------------------------------------------------
echo   ��1st digit ��2nd   ��3rd   ��4th         ��5th       ��6th        ��7th         ��8th
echo   ���s�N�Z��  ��aspect���掿  ���t�B���^    ��Audio���� �������J�b�g ��            ��
echo --------------------------------------------��-------------------------------------------------
echo  0��1280 x 720��16:9  ��crf 22��de-interlace��copy      ��Tssplit���s�����l�[�����{���ʏ�I��
echo  1�� 720 x 480�� 4:3  ��crf 20���C���^���ێ���neroAacEnc��Tssplit���������l�[��������Shutdown
echo  2�� 854 x 480��      ��crf 24��H265,de-int ��������MUX ��           ��_enc��t�^  ��
echo  3�� 640 x 480��      ��crf 26��nv264,deint ��AudioOnly ��           ��_old���쐬  ��
echo  4�� 960 x 540��      ��crf 28��nv265,deint ��          ��           ��            ��
echo  5�� 854 x 480��      ��crf 30��            ��          ��           ��            ��
echo  6�� 480 x 270��      ��      ��            ��          ��           ��            ��
echo  7��1920 x1080��      ��      ��            ��          ��           ��            ��
echo ------------------------------------------------------------------------------------------------
echo * Null-input(Enter only) is set to all 0.(12345678 digit)
set /p paramin=Please enter a number from 1�`8 digits. : 
set exeparam=0%paramin%00000000


:START
::/* �G���R�[�h�p�����[�^��ݒ�
set CONFIG= 
set prmchk=NG

set /a prm1=%exeparam:~1,1%
  if %prm1%==0 set prmchk=OK & set CONFIG=-s 1280x720
  if %prm1%==1 set prmchk=OK & set CONFIG=-s 720x480
  if %prm1%==2 set prmchk=OK & set CONFIG=-s 854x480
  if %prm1%==3 set prmchk=OK & set CONFIG=-s 640x480
  if %prm1%==4 set prmchk=OK & set CONFIG=-s 960x540
  if %prm1%==5 set prmchk=OK & set CONFIG=-s 854x480
  if %prm1%==6 set prmchk=OK & set CONFIG=-s 480x270
  if %prm1%==7 set prmchk=OK & set CONFIG=-s 1920x1080
  if %prmchk%==NG goto MENU else set prmchk=NG

set /a prm2=%exeparam:~2,1%
  if %prm2%==0 set prmchk=OK & set CONFIG=%CONFIG% -aspect 16:9
  if %prm2%==1 set prmchk=OK & set CONFIG=%CONFIG% -aspect 4:3
  if %prmchk%==NG goto MENU else set prmchk=NG

set /a prm3=%exeparam:~3,1%
  if %prm3%==0 set prmchk=OK & set CONFIG=-crf 22 %CONFIG%
  if %prm3%==1 set prmchk=OK & set CONFIG=-crf 20 %CONFIG%
  if %prm3%==2 set prmchk=OK & set CONFIG=-crf 24 %CONFIG%
  if %prm3%==3 set prmchk=OK & set CONFIG=-crf 26 %CONFIG%
  if %prm3%==4 set prmchk=OK & set CONFIG=-crf 28 %CONFIG%
  if %prm3%==5 set prmchk=OK & set CONFIG=-crf 30 %CONFIG%
  if %prmchk%==NG goto MENU else set prmchk=NG

set CONFIG=%CONFIG% -loglevel warning

set /a prm4=%exeparam:~4,1%
  if %prm4%==0 set prmchk=OK & set CONFIG=-vcodec libx264 -vf "yadif=0:-1,pp=dr/fq,hqdn3d" %CONFIG% -fpre %EXEPATH%libx264-64.ffpreset
  if %prm4%==1 set prmchk=OK & set CONFIG=-vcodec libx264 %CONFIG% -fpre %EXEPATH%libx264-64.ffpreset
  if %prm4%==2 set prmchk=OK & set CONFIG=-vcodec libx265 -vf "yadif=0:-1,pp=dr/fq,hqdn3d,unsharp" %CONFIG%
  if %prm4%==3 set prmchk=OK & set CONFIG=-vcodec nvenc_h264 -vf "yadif=0:-1,pp=dr/fq,hqdn3d" %CONFIG%
  if %prm4%==4 set prmchk=OK & set CONFIG=-vcodec nvenc_h265 -vf "yadif=0:-1,pp=dr/fq,hqdn3d" %CONFIG%
  if %prmchk%==NG goto MENU else set prmchk=NG



set /a prm5=%exeparam:~5,1%
set /a prm6=%exeparam:~6,1%
if not %~x1==.ts set /a prm6=1
set /a prm7=%exeparam:~7,1%

set /a prm8=%exeparam:~8,1%
  if %prm8%==0 set prmchk=OK & set SHUTD=no
  if %prm8%==1 set prmchk=OK & set SHUTD=yes
  if %prmchk%==NG goto MENU else set prmchk=NG


::�J�n���Ԏ擾
set tm=10%time: =%
set /a STTIME=1%tm:~-11,2%*3600 + 1%tm:~-8,2%*60 + 1%tm:~-5,2% - 366000


::�t�@�C���������߂�
for /f "usebackq tokens=* delims=" %%K in (`call cscript //nologo %EXEPATH%DelSpace.vbs %1`) DO set FileName=%%K
set FilePath=%1


cls
echo ******************************************************************************
echo �Ώ�  �F %FileName% 
if %EDCB%==1 set /p dmy=�yEDCB�o�b�`���[�h�z<nul 
if %prm4%==1 set /p dmy=�y�C���^���ێ��z<nul & if %prm4%==2 set /p dmy=�yH265�z<nul 
if %prm5%==0 set /p dmy=�yAudio�R�s�[�z<nul & if %prm5%==1 set /p dmy=�yneroAacEnc�z<nul & if %prm5%==2 set /p dmy=�y������MUX�z<nul & if %prm5%==3 set /p dmy=�ymp3�쐬���[�h�z<nul
if %prm6%==0 (set /p dmy=�ytssplit���{�z<nul) else set /p dmy=�ytssplit�Ȃ��z<nul
if %prm7%==0 set /p dmy=�ySCRename���{�z<nul & if %prm8%==1 (set /p dmy=�y�I����V���b�g�_�E���z<nul) else set /p dmy=�y�ʏ�I���z<nul
echo �ݒ�  �F %CONFIG% 
echo �ŃG���R�[�h���܂��B
echo ******************************************************************************
set UNQ=%RANDOM%
set EncTMP=%UNQ%_EncTMP

:CHKFILE
setlocal enabledelayedexpansion
set LOCKNAME=""
if exist %VideoPath%lock.txt (
  set /p LOCKNAME=<%VideoPath%lock.txt
  rem echo !LOCKNAME! ����ƒ��̂T���ԑ҂��܂��B
  echo ��ƒ��̃t�@�C���u!LOCKNAME!�v
  echo �Q���ԑ҂��܂��B�i%kaisu% ��ځj
  ping localhost -n 110 >nul:
) else goto ENCODE
endlocal
set /a kaisu=kaisu+1
ping localhost -n 10 >nul:
goto START


:ENCODE
if %prm5%==2 goto METHOD1-SUBMUX
if %prm5%==3 goto METHOD1-AudioOnly

:-------------------------------------------------------------------------------------------------------------
:METHOD1
echo METHOD1 �����g���b�N�R�s�[
echo %FileName%>%VideoPath%lock.txt
ren "%FileName%%~x1" %EncTMP%.in


if not %prm6%==0 goto JP1
  echo ��Tssplit���s...
  %EXEPATH%TsSplitter.exe -EIT -ECM -EMM -SD -1SEG -SEP2 -SEPA %EncTMP%.in
  FOR /f "DELIMS=" %%A IN ('dir /b /os %EncTMP%_*') DO SET TGTFILE=%%A
  if %TGTFILE%=="" set TGTFILE=%EncTMP%.in
:JP1

if %prm5%==0 (
  echo ��x264���k��mp4�R���e�i�i�[��...
  rem %EXEPATH%ffmpeg -y -analyzeduration 60M -probesize 60M -i "%EncTMP%.in" -acodec copy -absf aac_adtstoasc %CONFIG% "%EncTMP%.mp4"
  %EXEPATH%ffmpeg -y -i "%EncTMP%.in" -acodec copy -absf aac_adtstoasc %CONFIG% "%EncTMP%.mp4"
goto CLOSING
)

::/* Nero�G���R�[�_�g�p (2ch)
  echo ��Demux���s��...
  %EXEPATH%BonTsDemux.exe -i -nd "%TGTFILE%" -o "%EncTMP%" -encode Demux(m2v+wav) -nogui -sound 1 -start -quit
  echo ��AAC�t�@�C���쐬...
  %EXEPATH%neroAacEnc.exe -if "%EncTMP%.wav" -lc -br 128000 -of "%EncTMP%.aac"
  echo ��x264���k��mp4�R���e�i�i�[��...
  %EXEPATH%ffmpeg -y -i "%EncTMP%.aac" -i "%EncTMP%.m2v" -acodec copy %CONFIG% "%EncTMP%.mp4"
goto CLOSING
)

::-------------------------------------------------------------------------------------------------------------
:METHOD1-SUBMUX
if %~x1 neq .ts (
 echo ���̓t�@�C����TS�t�@�C���ł͂���܂���B
 goto GONEXT
)

echo %FileName%>%VideoPath%lock.txt
ren "%FileName%%~x1" %EncTMP%.in

echo ��Tssplit���s...
%EXEPATH%TsSplitter.exe -EIT -ECM -EMM -SD -1SEG -SEP2 -SEPA %EncTMP%.in
FOR /f "DELIMS=" %%A IN ('dir /b /os %EncTMP%_*') DO SET TGTFILE=%%A
if %TGTFILE%=="" set TGTFILE=%EncTMP%.in
echo ��������Demux���s��...
%EXEPATH%BonTsDemux.exe -i -nd "%TGTFILE%" -o "%EncTMP%_sub" -encode Demux(wav) -nogui -sound 2 -es 1 -start -quit
echo ��������AAC�t�@�C���쐬...
%EXEPATH%neroAacEnc.exe -if "%EncTMP%_sub.wav" -lc -br 128000 -of "%EncTMP%_sub.aac"
echo ��Demux���s��...
%EXEPATH%BonTsDemux.exe -i -nd "%TGTFILE%" -o "%EncTMP%" -encode Demux(m2v+wav) -nogui -sound 1 -start -quit
echo ��AAC�t�@�C���쐬...
%EXEPATH%neroAacEnc.exe -if "%EncTMP%.wav" -lc -br 128000 -of "%EncTMP%.aac"
echo ��x264���k��mp4�R���e�i�i�[��...
%EXEPATH%ffmpeg -y -i "%EncTMP%.m2v" %CONFIG% "%EncTMP%_main.mp4"
echo ���f��/���� MUX��...
%EXEPATH%MP4Box.exe -add "%EncTMP%_main.mp4"#video:group=1 -add "%EncTMP%.aac"#audio:group=1 -add "%EncTMP%_sub.aac"#audio:disable:group=1 -new "%EncTMP%.mp4"
goto CLOSING

::--------------------------------------------------------------------------------------------------------------
:METHOD1-AudioOnly
  echo ��mp3�쐬��...
  %EXEPATH%ffmpeg -y -i "%EncTMP%.in" -acodec copy -absf aac_adtstoasc "%EncTMP%.mp3"
goto CLOSING


:: ==================================================================================================================
:CLOSING

echo %FileName% �̃G���R�[�h���I�����܂����B

set tm=10%time: =%
set /a EXETIME=1%tm:~-11,2%*3600 + 1%tm:~-8,2%*60 + 1%tm:~-5,2% - 366000 -%STTIME%
if 0 gtr %EXETIME% set /a EXETIME=86400%EXETIME%
set /a min=%EXETIME%/60
set /a sec=%EXETIME%-%min%*60
set min=00%min%
set sec=0%sec%
echo �������Ԃ́A%min:~-3%�� %sec:~-2%�b �ł����B

echo .
set /p LOCKNAME=<%VideoPath%lock.txt
ren %VideoPath%Encodelog.txt Encodelog
echo %date:~-8% %time:~0,5%  %min:~-3%m%sec:~-2%s %exeparam:~1,8%  %LOCKNAME% > "%VideoPath%Encodelog.txt"
type "%VideoPath%Encodelog" >> "%VideoPath%Encodelog.txt"
del %VideoPath%Encodelog
copy %VideoPath%Encodelog.txt %EXEPATH%Encodelog.txt

ren "%EncTMP%.in" "%FileName%%~x1"

if %prm7%==2 (
  ren "%EncTMP%.mp4" "%FileName%_enc.mp4"
)

if %prm7%==3 (
  ren "%FileName%.mp4" "%FileName%_old.mp4"
  ren "%EncTMP%.mp4" "%FileName%.mp4"
)

if exist "%FileName%.mp4" (
       ren "%EncTMP%.mp4" "%FileName%_%UNQ%.mp4"
) ELSE ren "%EncTMP%.mp4" "%FileName%.mp4"
if "%ERRORLEVEL%"=="0" del "%EncTMP%*"

if %prm7%==0 (
  call %EXEPATH%SCRename.bat "%FileName%%~x1"
  call %EXEPATH%SCRename.bat "%FileName%.mp4"
)

:GONEXT
del %VideoPath%lock.txt
if %EDCB%==1 goto TERMINATION
shift
if /i "1%~1" EQU "1" goto TERMINATION
ping localhost -n 5 >nul:
goto START

:TERMINATION
echo �������I�����܂��B
if %SHUTD%==yes shutdown /s /t 240
if %EDCB%==0 pause else ping localhost -n 20 >nul:
endlocal
