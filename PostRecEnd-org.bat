@echo on
rem 180521
rem _EDCBX_DIRECT_
rem _EDCBX_DONTHIDE_
rem �����\��Ȃ�I��
if "%RecMode%" == "4" (
    goto :eof
)
rem �t�@�C�������^�C�g���o�[�ɕ\��
title %~nx0:%FileName%.ts

rem ====================���ϐ��ݒ�====================
rem ���O�t�H���_�̃p�X
set "log_path=C:\DTV\EncLog"

rem �A��jpg���o�͂���t�H���_�p�̃f�B���N�g���̃p�X
set "jpg_path=C:\Users\Shibanyan\Desktop\TVTest"

rem �ꎞ�I��mp4��f���o���t�H���_�̃p�X
set "tmp_folder_path=C:\DTV\tmp"
rem backup and sync�p�t�H���_�̃p�X
set "bas_folder_path=C:\DTV\backupandsync"
rem �G���R�����t�@�C����10GB���傫���A������25�񎸔s�����ꍇ��ts�Ats.program.txt�Amp4��ޔ�����t�H���_�̃p�X
set "err_folder_path=C:\Users\Shibanyan\Desktop"

rem tweet.rb�̃p�X
set "tweet_rb_path=C:\DTV\EDCB\tweet.rb"
rem SSL�ؖ����̃p�X
set "ssl_cert_file=C:\DTV\EDCB\cacert.pem"

rem ====================���O====================
if not "%started%" == "1" (
    set started=1
    rem �������g���q�o�b�`�Ƃ��ċN���������A���O�o��
    call "%~0" %* > "%log_path%\%FileName%.txt" 2>&1
    exit
)

rem dir�Ń��O�t�H���_��txt�t�@�C�����t�@�C�����̂ݓ��t���ŕ\�����A�V����������100��΂��A���Ԃꂽ�t�@�C�����폜����
for /f "skip=100 delims=" %%a in ('dir "%log_path%\*.txt" /b /o-d') do (
    rem log�폜
    del "%log_path%\%%~na.txt"
)

rem ====================jpg�o��====================
rem ���ϐ�Addkey(�����\�񎞂̃L�[���[�h)�ɓ���̕������܂܂�Ă���ꍇ�͘A��jpg���o��
rem findstr ""��errorlevel=2�ƂȂ�
echo "%AddKey%" | findstr "�|�v�e�s�s�b�N �t�����L�X BEATLESS �G���@�[�K�[�f��"
if %errorlevel% equ 0 (
    rem �o�̓t�H���_�쐬
    md "%jpg_path%\%FileName%"
    rem ��TS�̉���1920��1440�����ׂ�
    rem �ϐ�ts_width�Ɋi�[���邱�ƂŁAts�t�@�C�����L��width�����^�f�[�^��2�ӏ��ɂ���2�o�͂��ꂿ�Ⴄ��������
    for /f "delims=" %%a in ('ffprobe -v quiet -i "%FilePath%" -show_entries stream^=width -of default^=noprint_wrappers^=1:nokey^=1') do (
        set "ts_width=%%a"
    )
    if "%ts_width%" == "1440" (
        rem 1440�Ȃ��1920x1080�Ƀ��T�C�Y����jpg�o��
        ffmpeg -hide_banner -nostats -an -skip_frame nokey -i "%FilePath%" -vf yadif=0:-1:1,scale=1920:1080,hqdn3d=4.0 -f image2 -q:v 0 -vsync 0 "%jpg_path%\%FileName%\%%05d.jpg"
    ) else (
        rem 1440�łȂ���΃��T�C�Y������jpg�o��
        ffmpeg -hide_banner -nostats -an -skip_frame nokey -i "%FilePath%" -vf yadif=0:-1:1,hqdn3d=4.0 -f image2 -q:v 0 -vsync 0 "%jpg_path%\%FileName%\%%05d.jpg"
    )
)

rem ====================ts�t�H���_�T�C�Y�����ɕۂt�@�C���̍폜====================
rem �^��t�H���_�̍ő�T�C�Y���w��(1�`20000�̐����A�P��:GB)
set folder_max=100
rem GB��byte�̉�4���؂�̂�(32bit�v�Z�̈�)����Ԃɒ���
set /a folder_max=folder_max*107374
:filedeltop
rem ts�̃t�H���_���̃t�@�C�����ׂẴT�C�Y��dir�Ń\�[�g���Afindstr�Ńt�H���_�T�C�Y�̍s�𒊏o���A3�Ԗڂ̃g�[�N�������ϐ��Ɋi�[
for /f "tokens=3 delims= " %%a in ('dir /-d /-c "%FolderPath%" ^| findstr "�̃t�@�C��"') do (
    set folder_size=%%a
)
rem �^��t�H���_�̃T�C�Y��folder_max�Ŏw�肵���T�C�Y���傫���Ȃ�T�u���[�`����ǂ�ł��̃��[�`���̍ŏ��ɖ߂�
rem ���ϐ�folder_size�Afolder_max�����ꂼ�ꉺ4���؂�̂Ă�byte�P�ʂŌv�Z�����
if %folder_size:~0,-4% gtr %folder_max% (
    call :filedelsub
    goto :filedeltop
)

rem ====================�f���A�����m�̔���====================
rem �ԑg���̒���"�f���A�����m"�Ƃ��������񂪂���Ί��ϐ�"audio_option"��"-filter_complex channelsplit"�������A�����r�b�g���[�g�𔼕��ɂ���
findstr "�f���A�����m" "%FilePath%.program.txt"
if %errorlevel% equ 0 (
    set audio_option=-c:a aac -b:a 128k -filter_complex channelsplit
) else if %errorlevel% equ 1 (
    rem set audio_option=-c:a copy -bsf:a aac_adtstoasc
    set audio_option=-c:a aac -b:a 256k
)

rem ====================ts�t�@�C���T�C�Y����====================
rem TS�t�@�C���̃T�C�Y�����ϐ�"ts_size"�Ɏw��
for %%i in ("%FilePath%") do (
    set ts_size=%%~zi
)
rem 20GB=21474836480byte�ȉ��Ȃ�quality 26�A���傫���Ȃ�28
if %ts_size:~0,-1% leq 2147483648 (
    set quality=26
) else if %ts_size:~0,-1% gtr 2147483648 (
    set quality=28
)

rem ====================�G���R�[�h====================
rem ���[�v�����p
set cnt=0
:encode
rem �^��̊J�n�I���Ńr�W�[�Ȃ̂ŕ��ׂ����炷���߂ɂ�����Ƒ҂�
timeout /t 10 /nobreak
rem �G���R
ffmpeg -y -hide_banner -nostats -init_hw_device qsv:hw -fflags +discardcorrupt -i "%FilePath%" %audio_option% -vf yadif=0:-1:1,hqdn3d=4.0,scale=1280:720:flags=lanczos+accurate_rnd,unsharp=3:3:0.5:3:3:0.5:0 -global_quality %quality% -c:v h264_qsv -preset:v veryslow -g 300 -bf 16 -refs 9 -b_strategy 1 -look_ahead 1 -look_ahead_downsampling off -pix_fmt nv12 -map 0:p:%SID10%:0 -map 0:p:%SID10%:1 -map 0:p:%SID10%:2 -sn -dn -ignore_unknown -movflags +faststart "%tmp_folder_path%\%FileName%.mp4"
rem �I���R�[�h��1�����[�v�J�E���g��25�ȉ��܂ł̊ԁA�G���R�[�h�����݂�
if "%errorlevel%" equ "1" (
    if "%cnt%" leq "25" (
        set /a cnt+=1
        goto :encode
    ) else (
        goto :err
    )
)

rem ====================mp4�t�@�C���T�C�Y����====================
rem �G���R��mp4�̃T�C�Y�����ϐ�"mp4_size"�Ɏw��
for %%i in ("%tmp_folder_path%\%FileName%.mp4") do (
    set mp4_size=%%~zi
)
rem 10GB=10737418240byte�ȉ��Ȃ�backup and sync�p�t�H���_�A���傫���Ȃ�10GB�ȏ�p�t�H���_��(mp4����40GB�𒴂���ꍇ�͑z�肵�Ă��Ȃ�)
if %mp4_size:~0,-1% leq 1073741824 (
    move "%tmp_folder_path%\%FileName%.mp4" "%bas_folder_path%"
) else if %mp4_size:~0,-1% gtr 1073741824 (
    goto :err
)

rem ����I��
exit

rem ====================�T�u���[�`��====================
:filedelsub
rem dir�Ř^��t�H���_��ts�t�@�C�����t�@�C�����̂ݐV�������̂�����t���ŕ\�����A�Ō�Ɋ��ϐ�del_name�ɑ��������ԌÂ�ts�t�@�C�������擾
rem �x�����ϐ����g���ƁI���Ȃ�Ƃ����鏈����������̂ŁA���x����call���邱�Ƃɂ���
for /f "delims=" %%a in ('dir "%FolderPath%\*.ts" /b /o-d') do (
    set "del_name=%%~na"
)
rem ts�폜
del "%FolderPath%\%del_name%.ts"
rem ������ts.program.txt�폜
del "%FolderPath%\%del_name%.ts.program.txt"
rem ������mp4�폜
del "%bas_folder_path%\%del_name%.mp4"
exit /b

:err
rem ffmpeg�ɂ��G���[�̂ݑΉ��A�V���^�b�N�X�G���[��R�}���h�v�����v�g�̕s��͂����ɓ��B���Ȃ��̂Ń��O���Q�Ƃ��ꂽ��
rem �G���R�����t�@�C����10GB���傫���A������25�񎸔s�����ꍇ��ts�Ats.program.txt�Amp4��ޔ�����
move "%FilePath%" "%err_folder_path%"
move "%FilePath%.program.txt" "%err_folder_path%"
move "%tmp_folder_path%\%FileName%.mp4" "%err_folder_path%"
rem �c�C�[�g�Ōx��
set "tweet_content=ERROR:%FileName%.ts�Ɗ֘A�t�@�C����ޔ����܂����B���O���m�F���ĉ������B"
ruby "%tweet_rb_path%"
rem �ُ�I��
exit