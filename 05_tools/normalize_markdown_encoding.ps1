param(
  [switch]$Check,
  [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)]
  [string[]]$Path
)

$ErrorActionPreference = "Stop"
$Status = 0
$Utf8Strict = [System.Text.UTF8Encoding]::new($false, $true)
$Utf8NoBom = [System.Text.UTF8Encoding]::new($false)

function Get-TextEncoding {
  param([int[]]$CodePages)

  foreach ($CodePage in $CodePages) {
    try {
      return [System.Text.Encoding]::GetEncoding(
        $CodePage,
        [System.Text.EncoderFallback]::ExceptionFallback,
        [System.Text.DecoderFallback]::ExceptionFallback
      )
    } catch {
      continue
    }
  }

  return $null
}

$GbEncoding = Get-TextEncoding @(54936, 936)

function Get-InputFiles {
  param([string]$InputPath)

  if (Test-Path -LiteralPath $InputPath -PathType Container) {
    Get-ChildItem -LiteralPath $InputPath -Recurse -File |
      Where-Object { $_.Extension -in @(".md", ".txt") }
  } elseif (Test-Path -LiteralPath $InputPath -PathType Leaf) {
    Get-Item -LiteralPath $InputPath
  } else {
    Write-Error "missing: $InputPath"
  }
}

function Normalize-File {
  param([System.IO.FileInfo]$File)

  $Bytes = [System.IO.File]::ReadAllBytes($File.FullName)

  try {
    [void]$Utf8Strict.GetString($Bytes)
    Write-Host "utf8: $($File.FullName)"
    return
  } catch [System.Text.DecoderFallbackException] {
    if ($Check) {
      Write-Host "non-utf8: $($File.FullName)"
      $script:Status = 1
      return
    }
  }

  if ($null -eq $GbEncoding) {
    Write-Host "unsupported-encoding: $($File.FullName)"
    $script:Status = 1
    return
  }

  try {
    $Text = $GbEncoding.GetString($Bytes)
    [System.IO.File]::WriteAllText($File.FullName, $Text, $Utf8NoBom)
    Write-Host "converted-gb-to-utf8: $($File.FullName)"
  } catch {
    Write-Host "unsupported-encoding: $($File.FullName)"
    $script:Status = 1
  }
}

foreach ($InputPath in $Path) {
  foreach ($File in Get-InputFiles $InputPath) {
    Normalize-File $File
  }
}

exit $Status
