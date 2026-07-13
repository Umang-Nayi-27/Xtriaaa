# Run from this folder: powershell -ExecutionPolicy Bypass -File build.ps1
# Rebuilds ..\index.html from template.html + assets\*.b64.txt

$dir = $PSScriptRoot
$tpl = Get-Content "$dir\template.html" -Raw

$map = @{
  "__MAIN_B64__"            = (Get-Content "$dir\assets\main.b64.txt" -Raw)
  "__LINKEDIN_B64__"        = (Get-Content "$dir\assets\linkedin.b64.txt" -Raw)
  "__TWEETDELETER_B64__"    = (Get-Content "$dir\assets\tweetdeleter.b64.txt" -Raw)
  "__TWITTERBOOKMARK_B64__" = (Get-Content "$dir\assets\twitterbookmark.b64.txt" -Raw)
  "__WHATSAPP_B64__"        = (Get-Content "$dir\assets\whatsapp.b64.txt" -Raw)
  "__SITELOCKER_B64__"      = (Get-Content "$dir\assets\sitelocker.b64.txt" -Raw)
  "__MAP_GRID_DOTS__"       = (Get-Content "$dir\assets\map_grid_dots.txt" -Raw)
  "__WORLD_MAP_PATHS__"     = (Get-Content "$dir\assets\world_map_paths.txt" -Raw)
}

foreach ($key in $map.Keys) {
  $tpl = $tpl.Replace($key, $map[$key].Trim())
}

$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$outPath = Join-Path (Split-Path $dir -Parent) "index.html"
[System.IO.File]::WriteAllText($outPath, $tpl, $utf8NoBom)
Write-Output "Built $outPath ($((Get-Item $outPath).Length) bytes)"
