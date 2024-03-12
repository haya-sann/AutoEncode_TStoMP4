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
echo さらに引き続き、$FileName$をQNAPサーバーのVideoフォルダに移動  >> F:\MP4Encoded1\result.txt 2>>&1
echo $FileName$ | findstr "ニュース 報道" >NUL
set ServerTarget="\\NAS702258\video\"
rem 保存先のサーバーアドレス。まず、変数の内容をesult.txtに書き出してから次に進みます。
echo Line-20 移動させるファイルは %encodedFile% . Error Level は %ERRORLEVEL% : >> F:\MP4Encoded1\result.txt


if not ERRORLEVEL 1 (
    rem not ERRORLEVEL 1 はエラーはなかった、つまり検索にヒットしたという意味
    echo Line-25 >> F:\MP4Encoded1\result.txt 2>>&1
    set ServerTarget="%ServerTarget%ニュース\"
    rem %ServerTarget%ニュース\ は無駄なスペースが入らないように”で囲んだ
) else (
    echo $FileName$ | findstr "笑点 落語" >NUL
    echo Line-29 >> F:\MP4Encoded1\result.txt 2>>&1
    if not ERRORLEVEL 1 (
        set ServerTarget="%ServerTarget%落語・笑点\"
        )  else (
            echo $FileName$ | findstr "料理 グルメ おいしい レシピ" >NUL
            echo Line-34 >> F:\MP4Encoded1\result.txt 2>>&1
            if not ERRORLEVEL 1 (
                set ServerTarget="%ServerTarget%料理・グルメ\"
                )  else (
                echo $FileName$ | findstr "クローズアップ現代" >NUL
                echo Line-34 >> F:\MP4Encoded1\result.txt 2>>&1
                if not ERRORLEVEL 1 (
                    set ServerTarget="%ServerTarget%ドキュメンタリー\クローズアップ現代\"
                )  else (
                echo $FileName$ | findstr "Ｅａｒｔｈ" >NUL
                echo Line-34 >> F:\MP4Encoded1\result.txt 2>>&1
                if not ERRORLEVEL 1 (
                    set ServerTarget="%ServerTarget%ドキュメンタリー\Nature\"
                )  else (
                echo $FileName$ | findstr "ドキュメンタリー" >NUL
                echo Line-34 >> F:\MP4Encoded1\result.txt 2>>&1
                if not ERRORLEVEL 1 (
                    set ServerTarget="%ServerTarget%ドキュメンタリー\"
                                    )  else (
                echo $FileName$ | findstr "カンブリア宮殿" >NUL
                echo Line-34 >> F:\MP4Encoded1\result.txt 2>>&1
                if not ERRORLEVEL 1 (
                    set ServerTarget="%ServerTarget%ドキュメンタリー\カンブリア宮殿\"
                    ) else (
                    echo $FileName$ | findstr "映画 シネマ ロードショー [映]" >NUL
                    echo Line-39 >> F:\MP4Encoded1\result.txt 2>>&1
                    if not ERRORLEVEL 1 (
                        set ServerTarget="%ServerTarget%映画\"
                        ) else (
                        echo $FileName$ | findstr "新婚さんいらっしゃい さんま" >NUL
                        echo Line-46 >> F:\MP4Encoded1\result.txt 2>>&1
                        if not ERRORLEVEL 1 (
                            set ServerTarget="%ServerTarget%バラエティ\"
                        ) else (
                            echo $FileName$ | findstr "プログラミング" >NUL
                            echo Line-51 >> F:\MP4Encoded1\result.txt 2>>&1
                            if not ERRORLEVEL 1 (
                                echo Line-53 >> F:\MP4Encoded1\result.txt 2>>&1
                                set ServerTarget= "%ServerTarget%computer\"
                            ) else (
                                echo $FileName$ | findstr "クラシック" >NUL
                                echo Line-56 >> F:\MP4Encoded1\result.txt 2>>&1
                                if not ERRORLEVEL 1 (
                                    echo Line-61 >> F:\MP4Encoded1\result.txt 2>>&1
                                    set ServerTarget="%ServerTarget%Music\クラシック\"
                                ) else (
                                    echo Line-64 >> F:\MP4Encoded1\result.txt 2>>&1
                                    set ServerTarget="%ServerTarget%New\"
                                    )))))
                                    echo Line-67 もうチェックする項目はありません >> F:\MP4Encoded1\result.txt 2>>&1
    ))))))
move "%encodedFile%" "%ServerTarget%"  >> F:\MP4Encoded1\result.txt 2>>&1
echo Line-67, $FileName$をQNAPサーバーの%ServerTarget%フォルダに移動完了。  >> F:\MP4Encoded1\result.txt 2>>&1
echo ======================================== >> F:\MP4Encoded1\result.txt 2>>&1
