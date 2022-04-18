Option Explicit
On Error Resume Next
' テスト用関数１
Sub Test1()
    WScript.Echo "これは Test1 関数の出力です。"
End Sub

' テスト用関数２
Sub Test2()
    WScript.Echo "これは Test2 関数の出力です。"
End Sub

Dim strFuncName     ' 呼び出す関数名
Dim objFunction     ' 関数のポインタ

If WScript.Arguments.Count = 1 Then
    strFuncName = WScript.Arguments.Item(0)
    Set objFunction = GetRef(strFuncName)
    If Err.Number = 0 Then
        Call objFunction()
    Else
        WScript.Echo strFuncName & " 関数を取得できませんでした。"
    End If
    Set objFunction = Nothing
Else
    WScript.Echo "呼び出す関数名を指定してください。"
End If
