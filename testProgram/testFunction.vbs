Function Hoge(a, ByVal b, ByRef c) 
    WScript.Echo a 
    WScript.Echo b 
    WScript.Echo c 
    Hoge = "D"
End Function 
MsgBox Hoge ("A", "B", "C")
