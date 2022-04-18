Option Explicit
'簡単な割り算の結果をメッセージボックスで表示
msgbox 2 / 1
'エラー発生時はエラーを無視して次の処理に移ります。
On Error Resume Next
'エラーを出すためにわざと０除算をします。
msgbox 2 / 0
'エラーが発生しているかをチェックします。
If Err.Number <> 0 Then
    msgbox "エラー発生　番号：" & Err.Number & " " & "エラー内容：" & Err.Description
End If
'上記で指定した「On Error Resume Next」は以下の行までとします。
On Error Goto 0
'エラー発生時は再度エラーを無視して次の処理に移るようにします。
On Error Resume Next
Err.Clear
'再度エラーを出すためにわざと文字列の値をCInt関数で数値型に変換します。
CInt("文字列")
'エラーが発生しているかをチェックします。
If Err.Number <> 0 Then
    msgbox "またエラーが発生しました。"
    'エラー内容をメッセージボックスで表示します。
    msgbox "エラー番号：" & Err.Number & " " & "エラー内容：" & Err.Description
End If
'エラーを無視する範囲は以下の行までとします。
On Error Goto 0
