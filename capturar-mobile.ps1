$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$base = "C:\Users\Bruno\Desktop\afegue-barbearia"
$probe = Join-Path $base "_probe-mobile.html"
Add-Type -AssemblyName System.Drawing

foreach ($p in @("index","servicos","sobre","contato")) {

  $html = @"
<!DOCTYPE html>
<html lang="pt-BR">
<head><meta charset="utf-8"><title>probe $p</title></head>
<body style="margin:0;background:#000">
<iframe src="$p.html" style="width:390px;height:3200px;border:0;display:block"></iframe>
</body>
</html>
"@
  Set-Content -Path $probe -Value $html -Encoding UTF8

  $tmp = Join-Path $env:TEMP "cap-$p.png"
  if (Test-Path $tmp) { Remove-Item $tmp -Force }
  & $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --virtual-time-budget=8000 --window-size=500,3300 --screenshot="$tmp" "http://localhost:8092/_probe-mobile.html" | Out-Null
  Start-Sleep -Seconds 4

  if (-not (Test-Path $tmp)) { Write-Output "FALHOU $p"; continue }

  $img = [System.Drawing.Image]::FromFile($tmp)
  $retangulo = New-Object System.Drawing.Rectangle(0,0,390,[Math]::Min(3200,$img.Height))
  $bmp = New-Object System.Drawing.Bitmap(390, $retangulo.Height)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.DrawImage($img, (New-Object System.Drawing.Rectangle(0,0,390,$retangulo.Height)), $retangulo, [System.Drawing.GraphicsUnit]::Pixel)
  $g.Dispose()
  $img.Dispose()
  $dest = Join-Path $base ".capturas\$p-mobile.png"
  if (Test-Path $dest) { Remove-Item $dest -Force }
  $bmp.Save($dest, [System.Drawing.Imaging.ImageFormat]::Png)
  $bmp.Dispose()
  Write-Output "OK $p"
}
if (Test-Path $probe) { Remove-Item $probe -Force }
Get-ChildItem "$base\.capturas" | Sort-Object Name | Select-Object Name, Length
