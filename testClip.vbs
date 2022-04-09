Option Explicit
 
Dim s
 
s = "こんにちは" & vbTab & """田中""" & vbTab & "さん"
PutInClipboardText s
MsgBox "文字列をクリップボードにコピーしました。" & vbCrLf & "文字列:" & s
 
Public Sub PutInClipboardText(ByVal str)
  Dim cmd
   
  cmd = "cmd /c ""echo " & str & "| clip"""
  CreateObject("WScript.Shell").Run cmd, 0
End Sub