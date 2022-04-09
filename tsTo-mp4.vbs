Option Explicit
'https://blog.systemjp.net/entry/20080414/p1
'https://www.relief.jp/docs/wsh-get-files-name-wscript-arguments.html
'にあった例。
' クリップボードに納める件は
' https://www.ka-net.org/blog/?p=1563


if WScript.Arguments.Count = 0 then
	MsgBox "Drag and Drop TS File. Only One allowed"
'	MsgBox ("ファイルをvbsにDrag&Dropしてください。一個だけだよ")
	WScript.Quit
end if

dim fso
set fso = CreateObject("Scripting.FileSystemObject")

dim dropedInputFilename, outputFileName,  outputDirectory, pt
dropedInputFilename = WScript.Arguments.item(0)
outputDirectory = "F:\MP4Encoded1\"

outputFileName =  fso.GetFileName(WScript.Arguments.item(0))
outputFileName =  outputDirectory & Left (outputFileName, InStrRev(outputFileName,".")) & "mp4" '拡張子をtsからmp4　に差し替え

pt = InputBox ("ドラッグアンドドロップしたフルパスファイル名="  & dropedInputFilename & " からコマンド生成 ","mp4圧縮コマンド表示", "ffmpeg -y -i """ & dropedInputFilename & """ -vcodec h264_qsv -q 23 -look_ahead 0 -acodec aac -loglevel error """  & outputFileName & """" )

If IsEmpty(pt) = true Then
  MsgBox "キャンセルされました"
  pt = "cmd /c"
Else
  If pt = "" Then
    MsgBox "文字が入力されていません"
	pt = "cmd /c" 'これは何もしないコマンドのつもり
  Else
    dim ws, outExec, StdOut, StdErr, szStr, fileNameToSave, confirmationMessage
    Set ws = WScript.CreateObject("WScript.Shell")

    Set outExec = ws.Exec (pt)
    Set StdOut = outExec.StdOut
    Set StdErr = outExec.StdErr

    szStr = "STDOUT" & vbCrLf
    Do While Not StdOut.AtEndOfStream
      szStr = szStr & StdOut.ReadLine() &vbCrLf
    Loop
    WScript.Echo szStr

    szStr = "STDERR" & vbCrLf
    Do While Not StdErr.AtEndOfStream
      szStr = szStr & StdErr.ReadLine() &vbCrLf
    Loop
    WScript.Echo szStr

        '  fileNameToSave = "C:\Users\haya_\OneDrive\デスクトップ\errorLog.txt" 
'    fileNameToSave = ws.CurrentDirectory & "errorLog.txt" 
    fileNameToSave =  outputDirectory & "errorLog.txt" 
    confirmationMessage = dropedInputFilename & "の変換完了" &vbCrLf &vbCrLf & "mp4エンコードファイル保存先："  &  outputDirectory  &vbCrLf & "エラー記録は：" &fileNameToSave & "に保存します"
    MsgBox (confirmationMessage)
    if InStr(outputFileName,"ニュース") > 0 then fso.MoveFile outputFileName,"\\READYSHARE\S_Drive\Video\ニュース\"
    Dim ts

'    Set ts = fso.OpenTextFile(fileNameToSave, 2, True)
    Set ts = fso.CreateTextFile(fileNameToSave, 2, True)

    ts.Write( confirmationMessage &vbCrLf & szStr)
    ts.Close()

    Set ts = Nothing
    Set fso = Nothing
    Set szStr = Nothing
    Set StdOut = Nothing
    Set StdErr = Nothing
    Set outputFileName = Nothing
    Set dropedInputFilename = Nothing
    
    Set fileNameToSave = Nothing
    Set confirmationMessage = Nothing
    
    Set ws = Nothing
    Set outExec = Nothing

  End If
End If

Set pt = Nothing
