param()

$ErrorActionPreference = "Stop"
$Status = 0

function Get-VaultFiles {
  Get-ChildItem -LiteralPath . -Recurse -File -Force |
    Where-Object { $_.FullName -notmatch '[\\/]\.git[\\/]' }
}

function Show-Section {
  param([string]$Title, [object[]]$Items)

  Write-Host ""
  Write-Host $Title
  if ($Items.Count -gt 0) {
    $script:Status = 1
    $Items | ForEach-Object { Write-Host $_ }
  } else {
    Write-Host "none"
  }
}

Write-Host "Windows compatibility check"

$Files = @(Get-VaultFiles)

$Invalid = @(
  $Files |
    Where-Object { $_.Name -match '[<>:"\\|?*]' } |
    ForEach-Object { $_.FullName }
)
Show-Section "Invalid Windows filename characters:" $Invalid

$Trailing = @(
  $Files |
    Where-Object { $_.Name -match '[. ]$' } |
    ForEach-Object { $_.FullName }
)
Show-Section "Trailing spaces or dots:" $Trailing

$Reserved = @(
  $Files |
    Where-Object {
      $Base = [System.IO.Path]::GetFileNameWithoutExtension($_.Name).ToUpperInvariant()
      $Base -match '^(CON|PRN|AUX|NUL|COM[1-9]|LPT[1-9])$'
    } |
    ForEach-Object { $_.FullName }
)
Show-Section "Reserved Windows basenames:" $Reserved

$Root = (Get-Location).Path
$Groups = $Files | Group-Object {
  $_.FullName.Substring($Root.Length).TrimStart([char[]]@('\', '/')).ToLowerInvariant()
}
$Collisions = @(
  $Groups |
    Where-Object { $_.Count -gt 1 } |
    ForEach-Object { $_.Group.FullName }
)
Show-Section "Case-insensitive path collisions:" $Collisions

$LongPaths = @(
  $Files |
    Where-Object { $_.FullName.Length -gt 240 } |
    ForEach-Object { "$($_.FullName.Length) $($_.FullName)" }
)
Show-Section "Long paths over 240 characters:" $LongPaths

exit $Status
