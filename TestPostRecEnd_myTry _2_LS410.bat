 rem  h264_qsv を使ってエンコーディング
echo ****************************************  >> F:\MP4Encoded1\result.txt 2>>&1
echo.   >> F:\MP4Encoded1\result.txt 2>>&1
ECHO %DATE% %TIME%  >> F:\MP4Encoded1\result.txt 2>>&1
ECHO 現在実行中のファイル名→%~nx0 >> F:\MP4Encoded1\result.txt 2>>&1
echo ========================================  >> F:\MP4Encoded1\result.txt 2>>&1
echo $FilePath$ >> F:\MP4Encoded1\result.txt 2>>&1
echo.   >> F:\MP4Encoded1\result.txt 2>>&1
echo $FileName$ >> F:\MP4Encoded1\result.txt 2>>&1
set encodedFile=F:\MP4Encoded1\$SDYYYY$$SDMM$$SDDD$$STHH$$STMM$$TitleF$.mp4
echo ======================================== >> F:\MP4Encoded1\result.txt 2>>&1
ffmpeg -y -i "$FilePath$" -vcodec h264_qsv -q 23 -look_ahead 0 -acodec aac -loglevel error "%encodedFile%" >> F:\MP4Encoded1\result.txt 2>>&1
echo エンコーディング終了 >> F:\MP4Encoded1\result.txt 2>>&1
echo 元ファイル $FilePath$ を削除作業準備開始 >> F:\MP4Encoded1\result.txt 2>>&1
move "$FilePath$" E:\Media2-1\toBeTrash   >> F:\MP4Encoded1\result.txt 2>>&1
echo $FileName$をQNAPサーバーのVideoフォルダに移動  >> F:\MP4Encoded1\result.txt 2>>&1
echo $FileName$ | findstr "ニュース 報道" >NUL
set ServerTarget="\\NAS702258\video\" ::無駄なスペースが入らないように”で囲む
rem 保存先のサーバーアドレス。まず、変数の内容をesult.txtに書き出してから次に進みます。
echo %encodedFile% >> F:\MP4Encoded1\result.txt
echo %ServerTarget%落語\ >> F:\MP4Encoded1\result.txt
rem move "%encodedFile%" "%ServerTarget%ニュース\"  >> F:\MP4Encoded1\result.txt 2>>&1
echo "Line-23" >> F:\MP4Encoded1\result.txt 2>>&1
if not ERRORLEVEL 1 (
    echo "Line-25" >> F:\MP4Encoded1\result.txt 2>>&1
    move "%encodedFile%" "%ServerTarget%ニュース\"  >> F:\MP4Encoded1\result.txt 2>>&1
) else (
    echo $FileName$ | findstr "笑点 落語" >NUL
    echo "Line-29" >> F:\MP4Encoded1\result.txt 2>>&1
    if not ERRORLEVEL 1 (
        move "%encodedFile%" "%ServerTarget%落語・笑点\"  >> F:\MP4Encoded1\result.txt 2>>&1
        )  else (
            echo $FileName$ | findstr "料理 グルメ おいしい" >NUL
            echo "Line-34" >> F:\MP4Encoded1\result.txt 2>>&1
            if not ERRORLEVEL 1 (
                move "%encodedFile%" "%ServerTarget%料理・グルメ\"  >> F:\MP4Encoded1\result.txt 2>>&1
                ) else (
                echo $FileName$ | findstr "映画 シネマ ロードショー [映]" >NUL
                echo "Line-39" >> F:\MP4Encoded1\result.txt 2>>&1
                if not ERRORLEVEL 1 (
                    move "%encodedFile%" "%ServerTarget%映画\"  >> F:\MP4Encoded1\result.txt 2>>&1
                    ) else (
                    echo $FileName$ | findstr "新婚さんいらっしゃい さんま" >NUL
                    echo "Line-44" >> F:\MP4Encoded1\result.txt 2>>&1
                    if not ERRORLEVEL 1 (
                        move "%encodedFile%" "%ServerTarget%バラエティ\"  >> F:\MP4Encoded1\result.txt 2>>&1
                    ) else (
                        echo $FileName$ | findstr "プログラミング" >NUL
                        echo "Line-49" >> F:\MP4Encoded1\result.txt 2>>&1
                        if not ERRORLEVEL 1 (
                            move "%encodedFile%" "%ServerTarget%programing\"  >> F:\MP4Encoded1\result.txt 2>>&1
                        ) else (
                            move "%encodedFile%" "%ServerTarget%New\"  >> F:\MP4Encoded1\result.txt 2>>&1

                )
            )
    )
)
echo ======================================== >> F:\MP4Encoded1\result.txt 2>>&1
