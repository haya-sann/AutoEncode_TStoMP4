
set someStrings="202205161125きょうの料理ヒ?キ?ナース?「鶏のサクサク１枚揚け?」[字].mp4"
echo %someStrings%
echo %someStrings% | findstr "サクサク グルメ" >NUL
echo ErrorLevelは %ERRORLEVEL% です 
        if not ERRORLEVEL 1 (
        echo "料理エリアに移動"
    ) else (
        echo 何もしません
)

