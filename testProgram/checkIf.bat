
set someStrings="202205161125きょうの料理ヒ?キ?ナース?「鶏のサクサク１枚揚け?」[字].mp4"
echo %someStrings%
echo %someStrings% | findstr "サクサク グルメ" >NUL
echo ErrorLevelは %ERRORLEVEL% です 
        if not ERRORLEVEL 1 (
        echo "料理エリアに移動"
    ) else (
        echo 何もしません
)

set omestrings=%someStrings%
echo %omestrings% | findstr "ニュース" >NUL
if not ERRORLEVEL 1 (
    echo "報道"
) else (
    echo %omestrings% | findstr "海 山 魚" >NUL
    if not ERRORLEVEL 1 (
        echo "自然"
    ) else (
        echo %omestrings% | findstr "さんま" >NUL
        if not ERRORLEVEL 1 (
            echo "バラエティ"
        ) else (
            echo %omestrings% | findstr "ポアロ" >NUL
            if not ERRORLEVEL 1 (
                echo "ミステリー"
            )
        )
    )
)

