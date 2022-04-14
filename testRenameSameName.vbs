Option Explicit
'https://blog.systemjp.net/entry/20080414/p1
'https://www.relief.jp/docs/wsh-get-files-name-wscript-arguments.html
'にあった例。


if WScript.Arguments.Count = 0 then
	MsgBox "ファイルをvbsにDrag&Dropしてください。一個だけだよ"
	WScript.Quit
end if

dim fso
set fso = CreateObject("Scripting.FileSystemObject")

dim dropedInputFilename, outputFileName, pt
dropedInputFilename = WScript.Arguments.item(0)
outputFileName = fso.GetBaseName(WScript.Arguments.item(0)) 'ファイル名の本体を抜く

pt = InputBox("ドラッグアンドドロップしたファイル名="  & dropedInputFilename & " からコマンド生成 ","mp4圧縮コマンド表示", "ffmpeg -y -i """ & dropedInputFilename & """ -vcodec h264_qsv -q 23 -look_ahead 0 -acodec aac -loglevel error """ & dropedInputFilename & ".mp4""" )


