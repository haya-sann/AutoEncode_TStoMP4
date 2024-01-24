' BEGIN: ファイル名を取得して表示する
dim targetServer
targetServer = "\\NAS702258\video\"
If WScript.Arguments.Count > 0 Then
    For Each arg In WScript.Arguments
        WScript.Echo arg
        
        ' BEGIN: ファイル名に"ニュース"または"報道"が含まれる場合、サーバー\\NAS702258\video\ニュース\に、もしファイル名に”落語”が含まれていればサーバーの \\NAS702258\video\落語・笑点\　に移動する
        If InStr(arg, "ニュース") > 0 Or InStr(arg, "報道") > 0 Then
            targetServer  = targetServer & "ニュース\"
            ElseIf InStr(arg, "落語") > 0 Or InStr(arg, "笑点") > 0  Then
            targetServer  = targetServer & "落語・笑点\"
            ElseIf InStr(arg, "クラシック") > 0  Then
            targetServer  = targetServer & "クラシック\"
            ElseIf InStr(arg, "さんま") > 0 Or InStr(arg, "バラエティ") > 0  Then
            targetServer  = targetServer & "バラエティ\"
            ElseIf InStr(arg, "クローズアップ現代") > 0  Then
            targetServer  = targetServer & "ドキュメンタリー\クローズアップ現代\"
            ElseIf InStr(arg, "カンブリア宮殿") > 0  Then
            targetServer  = targetServer & "ドキュメンタリー\カンブリア宮殿\"
            ElseIf InStr(arg, "ガイアの夜明け") > 0  Then
            targetServer  = targetServer & "ドキュメンタリー\ガイアの夜明け\"
            ElseIf InStr(arg, "ブラタモリ") > 0  Then
            targetServer  = targetServer & "ドキュメンタリー\ブラタモリ\"
            ElseIf InStr(arg, "映像の世紀") > 0  Then
            targetServer  = targetServer & "ドキュメンタリー\映像の世紀\"
            ElseIf InStr(arg, "ワイルドライフ") > 0  Then
            targetServer  = targetServer & "ドキュメンタリー\WildLife\"
            ElseIf InStr(arg, "ＢＢＣ　Ｅａｒｔｈ") > 0  Then
            targetServer  = targetServer & "ドキュメンタリー\ＢＢＣ　Ｅａｒｔｈ\"
            ElseIf InStr(arg, "ＮＨＫスペシャル") > 0  Then
            targetServer  = targetServer & "ドキュメンタリー\"
            ElseIf InStr(arg, "プラネットアース") > 0  Then
            targetServer  = targetServer & "ドキュメンタリー\Nature\"
            ElseIf InStr(arg, "１００カメ") > 0  Then
            targetServer  = targetServer & "ドキュメンタリー\100カメ\"
            ElseIf InStr(arg, "クラシック") > 0  Then
            targetServer  = targetServer & "Music\クラシック\"
            ElseIf InStr(arg, "料理") > 0 Or InStr(arg, "グルメ") > 0  Or InStr(arg, "献立") > 0  Then
            targetServer  = targetServer & "料理・グルメ\"
            ElseIf InStr(arg, "ミステリー") > 0 Or InStr(arg, "ポアロ") > 0 Or InStr(arg, "アガサ・クリスティー") > 0  Then
            targetServer  = targetServer & "ミステリー\"
         Else
            targetServer  = targetServer & "New\"
        End If
            Set fso = CreateObject("Scripting.FileSystemObject")
            Set f = fso.GetFile(arg)
            CreateObject("WScript.Shell").Popup f.Name + " moves to  " +  targetServer , 20, "注意" 'message, second, title

            f.Move targetServer & f.Name
            'targetServerをクリアする
            targetServer = "\\NAS702258\video\" '元に戻す

    Next
End If
' END: ファイル名を取得して表示する
