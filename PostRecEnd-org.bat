@echo on
rem 180521
rem _EDCBX_DIRECT_
rem _EDCBX_DONTHIDE_
rem 視聴予約なら終了
if "%RecMode%" == "4" (
    goto :eof
)
rem ファイル名をタイトルバーに表示
title %~nx0:%FileName%.ts

rem ====================環境変数設定====================
rem ログフォルダのパス
set "log_path=C:\DTV\EncLog"

rem 連番jpgを出力するフォルダ用のディレクトリのパス
set "jpg_path=C:\Users\Shibanyan\Desktop\TVTest"

rem 一時的にmp4を吐き出すフォルダのパス
set "tmp_folder_path=C:\DTV\tmp"
rem backup and sync用フォルダのパス
set "bas_folder_path=C:\DTV\backupandsync"
rem エンコしたファイルが10GBより大きい、処理に25回失敗した場合にts、ts.program.txt、mp4を退避するフォルダのパス
set "err_folder_path=C:\Users\Shibanyan\Desktop"

rem tweet.rbのパス
set "tweet_rb_path=C:\DTV\EDCB\tweet.rb"
rem SSL証明書のパス
set "ssl_cert_file=C:\DTV\EDCB\cacert.pem"

rem ====================ログ====================
if not "%started%" == "1" (
    set started=1
    rem 自分自身を子バッチとして起動し直し、ログ出力
    call "%~0" %* > "%log_path%\%FileName%.txt" 2>&1
    exit
)

rem dirでログフォルダのtxtファイルをファイル名のみ日付順で表示し、新しい方から100個飛ばし、あぶれたファイルを削除する
for /f "skip=100 delims=" %%a in ('dir "%log_path%\*.txt" /b /o-d') do (
    rem log削除
    del "%log_path%\%%~na.txt"
)

rem ====================jpg出力====================
rem 環境変数Addkey(自動予約時のキーワード)に特定の文字が含まれている場合は連番jpgも出力
rem findstr ""でerrorlevel=2となる
echo "%AddKey%" | findstr "ポプテピピック フランキス BEATLESS エヴァーガーデン"
if %errorlevel% equ 0 (
    rem 出力フォルダ作成
    md "%jpg_path%\%FileName%"
    rem 生TSの横が1920か1440か調べる
    rem 変数ts_widthに格納することで、tsファイル特有のwidthがメタデータの2箇所にあり2つ出力されちゃう問題を解決
    for /f "delims=" %%a in ('ffprobe -v quiet -i "%FilePath%" -show_entries stream^=width -of default^=noprint_wrappers^=1:nokey^=1') do (
        set "ts_width=%%a"
    )
    if "%ts_width%" == "1440" (
        rem 1440ならば1920x1080にリサイズしてjpg出力
        ffmpeg -hide_banner -nostats -an -skip_frame nokey -i "%FilePath%" -vf yadif=0:-1:1,scale=1920:1080,hqdn3d=4.0 -f image2 -q:v 0 -vsync 0 "%jpg_path%\%FileName%\%%05d.jpg"
    ) else (
        rem 1440でなければリサイズせずにjpg出力
        ffmpeg -hide_banner -nostats -an -skip_frame nokey -i "%FilePath%" -vf yadif=0:-1:1,hqdn3d=4.0 -f image2 -q:v 0 -vsync 0 "%jpg_path%\%FileName%\%%05d.jpg"
    )
)

rem ====================tsフォルダサイズを一定に保つファイルの削除====================
rem 録画フォルダの最大サイズを指定(1～20000の整数、単位:GB)
set folder_max=100
rem GBをbyteの下4桁切り捨て(32bit計算の為)た状態に直す
set /a folder_max=folder_max*107374
:filedeltop
rem tsのフォルダ内のファイルすべてのサイズをdirでソートし、findstrでフォルダサイズの行を抽出し、3番目のトークンを環境変数に格納
for /f "tokens=3 delims= " %%a in ('dir /-d /-c "%FolderPath%" ^| findstr "個のファイル"') do (
    set folder_size=%%a
)
rem 録画フォルダのサイズがfolder_maxで指定したサイズより大きいならサブルーチンを読んでこのルーチンの最初に戻る
rem 環境変数folder_size、folder_maxがそれぞれ下4桁切り捨てのbyte単位で計算される
if %folder_size:~0,-4% gtr %folder_max% (
    call :filedelsub
    goto :filedeltop
)

rem ====================デュアルモノの判別====================
rem 番組情報の中に"デュアルモノ"という文字列があれば環境変数"audio_option"に"-filter_complex channelsplit"を加え、音声ビットレートを半分にする
findstr "デュアルモノ" "%FilePath%.program.txt"
if %errorlevel% equ 0 (
    set audio_option=-c:a aac -b:a 128k -filter_complex channelsplit
) else if %errorlevel% equ 1 (
    rem set audio_option=-c:a copy -bsf:a aac_adtstoasc
    set audio_option=-c:a aac -b:a 256k
)

rem ====================tsファイルサイズ判別====================
rem TSファイルのサイズを環境変数"ts_size"に指定
for %%i in ("%FilePath%") do (
    set ts_size=%%~zi
)
rem 20GB=21474836480byte以下ならquality 26、より大きいなら28
if %ts_size:~0,-1% leq 2147483648 (
    set quality=26
) else if %ts_size:~0,-1% gtr 2147483648 (
    set quality=28
)

rem ====================エンコード====================
rem ループ処理用
set cnt=0
:encode
rem 録画の開始終了でビジーなので負荷を減らすためにちょっと待つ
timeout /t 10 /nobreak
rem エンコ
ffmpeg -y -hide_banner -nostats -init_hw_device qsv:hw -fflags +discardcorrupt -i "%FilePath%" %audio_option% -vf yadif=0:-1:1,hqdn3d=4.0,scale=1280:720:flags=lanczos+accurate_rnd,unsharp=3:3:0.5:3:3:0.5:0 -global_quality %quality% -c:v h264_qsv -preset:v veryslow -g 300 -bf 16 -refs 9 -b_strategy 1 -look_ahead 1 -look_ahead_downsampling off -pix_fmt nv12 -map 0:p:%SID10%:0 -map 0:p:%SID10%:1 -map 0:p:%SID10%:2 -sn -dn -ignore_unknown -movflags +faststart "%tmp_folder_path%\%FileName%.mp4"
rem 終了コードが1且つループカウントが25以下までの間、エンコードを試みる
if "%errorlevel%" equ "1" (
    if "%cnt%" leq "25" (
        set /a cnt+=1
        goto :encode
    ) else (
        goto :err
    )
)

rem ====================mp4ファイルサイズ判別====================
rem エンコ後mp4のサイズを環境変数"mp4_size"に指定
for %%i in ("%tmp_folder_path%\%FileName%.mp4") do (
    set mp4_size=%%~zi
)
rem 10GB=10737418240byte以下ならbackup and sync用フォルダ、より大きいなら10GB以上用フォルダへ(mp4が約40GBを超える場合は想定していない)
if %mp4_size:~0,-1% leq 1073741824 (
    move "%tmp_folder_path%\%FileName%.mp4" "%bas_folder_path%"
) else if %mp4_size:~0,-1% gtr 1073741824 (
    goto :err
)

rem 正常終了
exit

rem ====================サブルーチン====================
:filedelsub
rem dirで録画フォルダのtsファイルをファイル名のみ新しいものから日付順で表示し、最後に環境変数del_nameに代入される一番古いtsファイル名を取得
rem 遅延環境変数を使うと！をなんとかする処理が増えるので、ラベルをcallすることにした
for /f "delims=" %%a in ('dir "%FolderPath%\*.ts" /b /o-d') do (
    set "del_name=%%~na"
)
rem ts削除
del "%FolderPath%\%del_name%.ts"
rem 同名のts.program.txt削除
del "%FolderPath%\%del_name%.ts.program.txt"
rem 同名のmp4削除
del "%bas_folder_path%\%del_name%.mp4"
exit /b

:err
rem ffmpegによるエラーのみ対応、シンタックスエラーやコマンドプロンプトの不具合はここに到達しないのでログを参照されたし
rem エンコしたファイルが10GBより大きい、処理に25回失敗した場合にts、ts.program.txt、mp4を退避する
move "%FilePath%" "%err_folder_path%"
move "%FilePath%.program.txt" "%err_folder_path%"
move "%tmp_folder_path%\%FileName%.mp4" "%err_folder_path%"
rem ツイートで警告
set "tweet_content=ERROR:%FileName%.tsと関連ファイルを退避しました。ログを確認して下さい。"
ruby "%tweet_rb_path%"
rem 異常終了
exit