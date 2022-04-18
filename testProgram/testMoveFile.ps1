# https://qiita.com/sueasen/items/6081d84ad4d1ec21cebe �ɂ���������v���O�����T���v��
$path = "C:\Users\haya_\Documents\AutoEncode_TStoMP4\testProgram";
$dist = "C:\Users\haya_\Documents\AutoEncode_TStoMP4\testProgram\moveTest";

# �ȉ��� Move ���� test1, test2 �ɓ����̃t�H���_������ƃG���[�ɂȂ��Ă��܂��B�B�B
# Move-Item $($path + "\*") -Destination $dist -Force;

# ChildItem �Ń��[�v
Get-ChildItem $path | ForEach-Object {
    # Move-Item ���s�� function �Ƃ��� moveItem �쐬���ČĂяo��
    moveItem $_.FullName $($dist + "\" + $_.Name);
    # moveItem "C:\Users\haya_\Documents\AutoEncode_TStoMP4\testProgram\testClip.txt" $($dist + "\" + $_.Name);
} 

############ moveItem
function moveItem($path, $dist) {
    if ((Test-Path $dist) -and (Test-Path -PathType Container $path)) {
        # �t�H���_�㏑��(�ړ���ɑ��� ���� �t�H���_)�͍ċA�I�� moveItem �Ăяo��
        Get-ChildItem $path | ForEach-Object {
            moveItem $_.FullName $($dist + "\" + $_.Name);
        }
        # �ړ����I������t�H���_���폜
        Remove-Item $path -Recurse -Force;
        Move-Item $path -Destination $dist -Force;
    } else {
        # �ړ���ɑΏۂȂ� �܂��� �t�@�C���� Move-Item �� -Forece ���Ď��s
        Move-Item $path -Destination $dist -Force;
    }
}
