Option Explicit
On Error Resume Next
' �e�X�g�p�֐��P
Sub Test1()
    WScript.Echo "����� Test1 �֐��̏o�͂ł��B"
End Sub

' �e�X�g�p�֐��Q
Sub Test2()
    WScript.Echo "����� Test2 �֐��̏o�͂ł��B"
End Sub

Dim strFuncName     ' �Ăяo���֐���
Dim objFunction     ' �֐��̃|�C���^

If WScript.Arguments.Count = 1 Then
    strFuncName = WScript.Arguments.Item(0)
    Set objFunction = GetRef(strFuncName)
    If Err.Number = 0 Then
        Call objFunction()
    Else
        WScript.Echo strFuncName & " �֐����擾�ł��܂���ł����B"
    End If
    Set objFunction = Nothing
Else
    WScript.Echo "�Ăяo���֐������w�肵�Ă��������B"
End If
