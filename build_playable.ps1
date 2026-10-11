$template = Get-Content -Path "playable_template.html" -Raw -Encoding UTF8

$assets = @('logo','tile1','tile2','tile3','tile4','tile5','tile6')
foreach ($a in $assets) {
    $b64 = (Get-Content -Path "assets/$a.b64" -Raw).Trim()
    $dataUri = "data:image/png;base64,$b64"
    $template = $template.Replace("{{${a}_data}}", $dataUri)
}

[System.IO.File]::WriteAllText("d:\IK\Cello\cello_playable_ad.html", $template, [System.Text.Encoding]::UTF8)
$size = (Get-Item "cello_playable_ad.html").Length
$sizeKB = [math]::Round($size/1024)
$sizeMB = [math]::Round($size/1024/1024, 2)
Write-Host "Built cello_playable_ad.html - Size: ${sizeKB}KB (${sizeMB}MB)"
if ($size -lt 2097152) {
    Write-Host "PASS: Under 2MB limit for Meta playable ads"
} else {
    Write-Host "FAIL: Over 2MB limit - needs optimization"
}
