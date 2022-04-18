# https://qiita.com/sueasen/items/6081d84ad4d1ec21cebe にあった解説プログラムサンプル
$path = "C:\Users\haya_\Documents\AutoEncode_TStoMP4\testProgram";
$dist = "C:\Users\haya_\Documents\AutoEncode_TStoMP4\testProgram\moveTest";

# 以下の Move だと test1, test2 に同名のフォルダがあるとエラーになってしまう。。。
# Move-Item $($path + "\*") -Destination $dist -Force;

# ChildItem でループ
Get-ChildItem $path | ForEach-Object {
    # Move-Item を行う function として moveItem 作成して呼び出す
    moveItem $_.FullName $($dist + "\" + $_.Name);
    # moveItem "C:\Users\haya_\Documents\AutoEncode_TStoMP4\testProgram\testClip.txt" $($dist + "\" + $_.Name);
} 

############ moveItem
function moveItem($path, $dist) {
    if ((Test-Path $dist) -and (Test-Path -PathType Container $path)) {
        # フォルダ上書き(移動先に存在 かつ フォルダ)は再帰的に moveItem 呼び出し
        Get-ChildItem $path | ForEach-Object {
            moveItem $_.FullName $($dist + "\" + $_.Name);
        }
        # 移動し終わったフォルダを削除
        Remove-Item $path -Recurse -Force;
        Move-Item $path -Destination $dist -Force;
    } else {
        # 移動先に対象なし または ファイルの Move-Item に -Forece つけて実行
        Move-Item $path -Destination $dist -Force;
    }
}
