 rem  h264_qsv を使ってエンコーディング
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
echo $FileName$をLS410DX3DAのSharedFilesに移動  >> F:\MP4Encoded1\result.txt 2>>&1
echo $FileName$ | find "ニュース" >NUL
if not ERRORLEVEL 1 (
    move "%encodedFile%" \\LS410DX3DA\SharedDisk1\SharedFiles\ニュース\  >> F:\MP4Encoded1\result.txt 2>>&1
) else (
    echo $FileName$ | find "笑点" >NUL
    if not ERRORLEVEL 1 (
        move "%encodedFile%" \\LS410DX3DA\SharedDisk1\SharedFiles\落語・笑点\  >> F:\MP4Encoded1\result.txt 2>>&1
    )  else (
            echo $FileName$ | find "新婚さんいらっしゃい" >NUL
            if not ERRORLEVEL 1 (
                move "%encodedFile%" \\LS410DX3DA\SharedDisk1\SharedFiles\バラエティ\  >> F:\MP4Encoded1\result.txt 2>>&1
            ) else (
                echo $FileName$ | find "プログラミング" >NUL
                if not ERRORLEVEL 1 (
                    move "%encodedFile%" \\LS410DX3DA\SharedDisk1\SharedFiles\programing\  >> F:\MP4Encoded1\result.txt 2>>&1
                ) else (
                    move "%encodedFile%" \\LS410DX3DA\SharedDisk1\SharedFiles\New\  >> F:\MP4Encoded1\result.txt 2>>&1

                )
            )
    )
)
echo ======================================== >> F:\MP4Encoded1\result.txt 2>>&1
