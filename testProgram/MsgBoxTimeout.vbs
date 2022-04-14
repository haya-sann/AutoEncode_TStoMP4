Option Explicit
' 10秒で消えるメッセージボックスの書き方
Dim confirmationMessage
confirmationMessage = "これは短時間のお知らせです"
CreateObject("WScript.Shell").Popup confirmationMessage, 10, "ご注意"
