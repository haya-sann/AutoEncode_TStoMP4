Option explicit
Dim INFile,splName,intIndex,FilePath,FileName,Count,i
Dim fso
' Dim Count As Integer
set fso = createobject("scripting.filesystemobject")

set INFile = WScript.Arguments
    splName = Split(INFile(0), "\")
    count = UBound(splName)
        For i = 0 To count -1
        FilePath = FilePath + splName(i) + "\"
        Next
    splName(count) = Replace(splName(count), "　", "_")
    splName(count) = Replace(splName(count), "!", "")
    splName(count) = Replace(splName(count), "！", "")

    If not fso.fileExists(Filepath + splName(count)) then
    fso.getfile(INFile(0)).name = splName(count)
    End If

FilePath = Join(splName, "\")
WScript.Echo fso.GetBaseName(FilePath)
set fso = nothing
set INFile = nothing
set splName = nothing
set intIndex = nothing
set count = nothing
' set FilePath = nothing
' set FileName = nothing
WScript.Quit

' FileName      対象ファイル名                  aaaaaaa_01
' FilePath      対象ファイルのフルパス          "D:\dir\aaaaaaa_01.txt"
