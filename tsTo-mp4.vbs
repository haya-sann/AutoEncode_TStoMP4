Option Explicit
'https://blog.systemjp.net/entry/20080414/p1
'https://www.relief.jp/docs/wsh-get-files-name-wscript-arguments.html
'にあった例。
' クリップボードに納める件は
' https://www.ka-net.org/blog/?p=1563


if WScript.Arguments.Count = 0 then
  CreateObject("WScript.Shell").Popup "Drag and Drop TS File. Only One allowed", 5, "注意"
	WScript.Quit
end if

dim fso
set fso = CreateObject("Scripting.FileSystemObject")

dim dropedInputFilename, outputFileName,  outputDirectory, targetServer, pt
dropedInputFilename = WScript.Arguments.item(0)
outputDirectory = "F:\MP4Encoded1\"
targetServer = "\\LS410DX3DA\SharedDisk1\SharedFiles\"

outputFileName =  fso.GetFileName(WScript.Arguments.item(0))
outputFileName =  outputDirectory & Left (outputFileName, InStrRev(outputFileName,".")) & "mp4" '拡張子をtsからmp4　に差し替え

pt = InputBox ("ドラッグアンドドロップしたフルパスファイル名="  & dropedInputFilename & " からコマンド生成 ","mp4圧縮コマンド表示", "ffmpeg -y -i """ & dropedInputFilename & """ -vcodec h264_qsv -q 23 -look_ahead 0 -acodec aac -loglevel error """  & outputFileName & """" )
If IsEmpty(pt) = true Then
    CreateObject("WScript.Shell").Popup "キャンセルされました", 5, "注意"
  pt = "cmd /c"
Else
  If pt = "" Then
    CreateObject("WScript.Shell").Popup "文字が入力されていません", 5, "注意"
	pt = "cmd /c" 'これは何もしないコマンドのつもり
  Else
    dim ws, outExec, StdOut, StdErr, szStr, errorLogfileNameToSave, confirmationMessage
    Set ws = WScript.CreateObject("WScript.Shell")

    Set outExec = ws.Exec (pt)
    Set StdOut = outExec.StdOut
    Set StdErr = outExec.StdErr

    szStr = "STDOUT" & vbCrLf
    Do While Not StdOut.AtEndOfStream
      szStr = szStr & StdOut.ReadLine() &vbCrLf
    Loop

    szStr = "STDERR" & vbCrLf
    Do While Not StdErr.AtEndOfStream
      szStr = szStr & StdErr.ReadLine() &vbCrLf
    Loop

    errorLogfileNameToSave =  outputDirectory & "errorLog.txt" 
    confirmationMessage = dropedInputFilename & "の変換完了" &vbCrLf &vbCrLf & "mp4エンコードファイル保存先："  &  outputDirectory  &vbCrLf & "エラー記録は：" &errorLogfileNameToSave & "に保存します"
    CreateObject("WScript.Shell").Popup confirmationMessage, 5, "注意"
    ' エラーが起きなければ：元のtsファイルは削除候補に移動
    fso.MoveFile dropedInputFilename,"E:\Media2-1\toBeTrash\"
    CreateObject("WScript.Shell").Popup dropedInputFilename + "を削除対象にしました", 5, "注意"
    confirmationMessage = confirmationMessage &vbCrLf & dropedInputFilename & "を削除対象にしました"

    if InStr(outputFileName,"ニュース") > 0 or InStr(outputFileName,"クーパー360") > 0 then 
      fso.MoveFile outputFileName,targetServer & "ニュース\"
      ElseIf InStr(outputFileName,"さんま") > 0 or InStr(outputFileName,"バラエティ") > 0  Then
      fso.MoveFile outputFileName,targetServer & "バラエティ\"
      ElseIf InStr(outputFileName,"落語") > 0 or InStr(outputFileName,"笑点") > 0  Then
      fso.MoveFile outputFileName,targetServer & "落語・笑点\"
      ElseIf InStr(outputFileName,"映画") > 0 or InStr(outputFileName,"シネマ") > 0  Then
      fso.MoveFile outputFileName,targetServer & "映画\"
      ElseIf InStr(outputFileName,"マープル") > 0 or InStr(outputFileName,"ポアロ") > 0 or InStr(outputFileName,"ミステリー") > 0  Then
      fso.MoveFile outputFileName,targetServer & "ミステリー\"
      ElseIf InStr(outputFileName,"音楽") > 0 or InStr(outputFileName,"ミュージック") > 0 or InStr(outputFileName,"Music") > 0  Then
      fso.MoveFile outputFileName,targetServer & "Music\"
      Else
      fso.MoveFile outputFileName,targetServer & "New\"
    End If
    CreateObject("WScript.Shell").Popup outputFileName + "をサーバーに移動して保存しました", 5, "注意"
    confirmationMessage = confirmationMessage &vbCrLf & outputFileName & "をサーバー" & targetServer &  "に移動して保存しました"

    Dim ts
    Set ts = fso.CreateTextFile(errorLogfileNameToSave, 2, True)

    ts.Write( confirmationMessage &vbCrLf & szStr)
    ts.Close()

    Set ts = Nothing
    Set fso = Nothing
    Set szStr = Nothing
    Set StdOut = Nothing
    Set StdErr = Nothing
    Set outputFileName = Nothing
    Set dropedInputFilename = Nothing
    
    Set errorLogfileNameToSave = Nothing
    Set confirmationMessage = Nothing
    
    Set ws = Nothing
    Set outExec = Nothing

  End If
End If

Set pt = Nothing
