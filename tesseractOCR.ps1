#
# Tesseract OCR
#
$USR_INFO = "Tess4j "+$env:USERNAME+"@"+$env:COMPUTERNAME+"->"+ (Get-Date -DisplayHint DateTime)+" "
#
# 画像ファイル選択
#
[void][System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")
$dialog = New-Object System.Windows.Forms.OpenFileDialog
$dialog.Filter = "画像ファイル(*.PNG;*.JPG;*.GIF)|*.PNG;*.JPG;*.JPEG;*.GIF"
$dialog.InitialDirectory = $env:USERPROFILE+"\Desktop"
$dialog.Title = "文字を取り出したい画像ファイルを選択してください"
$dialog.Multiselect = $true
# ファイル選択ダイアログを表示
$IMG_FILE_NAME = ""
if($dialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK){
    Write-Output ($dialog.FileName + " が選択されました。")
    $IMG_FILE_NAME = $dialog.FileName
} else {
    write-output ($dialog.FileName + " ファイルが見つかりません。")
}
#
# is there exe in folder?
#
$Tess4J_exe   = "d:\tesseract4win64-master\x64\tesseract.exe "
#
if (Test-Path $Tess4J_exe) {
# found tesseract.exe in the folder
$USER_DESKTOP = $env:USERPROFILE+"\Desktop\"
$Tess4J_exe   = "d:\tesseract4win64-master\x64\tesseract.exe "
$OCR_OUT      = " "+$USER_DESKTOP+"out -l "
# OCR言語はjpn/日本語
$OCR_OPT      ="jpn"
# 実行コマンド文字列の生成
$EXECUTE_CMD = $Tess4J_exe + $IMG_FILE_NAME+$OCR_OUT+$OCR_OPT
write-host $EXECUTE_CMD
# tesseract.exe の環境変数を指定 traindata のフォルダパス指定
$env:TESSDATA_PREFIX = "D:\tesseract4win64-master\tessdata"
# コマンドを実行
Invoke-expression  $EXECUTE_CMD
    } else {
# tesseract.exe not found
# Tesseract.exe Installer
#
Write-Host Tesseract OCR 最新版を設定中
# Dドライブの既存Tesseract*フォルダを削除
Write-Host 古いバージョン削除中
Remove-Item d:\tesseract4win64* -Recurse -Force
# 共有からtesseract4win64-masterフォルダをD:ドライブ直下にリカーシブコピー
Write-Host 最新版を共有からコピー中
Copy-Item -Path \\whereis\ourshare\hereitis\共有\tools\tesseract4win64-master -Destination d:\ -Force -Recurse }
#
# Execute Tesseract OCR
#
$USER_DESKTOP = $env:USERPROFILE+"\Desktop\"
$Tess4J_exe   = "d:\tesseract4win64-master\x64\tesseract.exe "
$OCR_OUT      = " "+$USER_DESKTOP+"out -l "
# OCR言語はjpn/日本語
$OCR_OPT      ="jpn"
# 実行コマンド文字列の生成
$EXECUTE_CMD = $Tess4J_exe + $IMG_FILE_NAME+$OCR_OUT+$OCR_OPT
write-host $EXECUTE_CMD
# tesseract.exe の環境変数を指定 traindata のフォルダパス指定
$env:TESSDATA_PREFIX = "D:\tesseract4win64-master\tessdata"
# コマンドを実行
Invoke-expression  $EXECUTE_CMD
