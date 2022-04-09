@echo off

rem 変数「hensu」に文字列「井手ちゃんぽん」を代入
set hensu=井手ちゃんぽん
set resultFile=resultTest.txt 

rem 変数「hensu」の中身を確認
echo 変数「hensu」には「%hensu%」が代入されました。
echo やっぱり%hensu%     はおいしいなあ。
echo %DATE% %TIME%　に食べる%hensu%は格別だ

set FileName=朝のニュース　今日の天気
echo ======================================== >> F:\MP4Encoded1\%resultFile% 2>>&1
echo %FileName%　　エンコーディング中
echo End encoding
echo %FileName%  | find "ニュース" >NUL
echo ErrorLevelは　%ERRORLEVEL%　です 
if not ERRORLEVEL 1 echo ニュースでした
echo echo %FileName%  | find "ニュース" 
echo ======================================== 
set FileName=朝のニュー　今日の天気
echo %FileName%　　エンコーディング中
echo End encode %FileName% >> F:\MP4Encoded1\%resultFile% 2>>&1
echo %FileName%  | find "ニュース" >NUL
echo ErrorLevelは　%ERRORLEVEL%　です 
if not ERRORLEVEL 1 echo 「%FileName%」を移動しました

echo ======================================== >> F:\MP4Encoded1\%resultFile% 2>>&1
pause

