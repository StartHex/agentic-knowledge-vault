# Windows Setup

## Recommended Role

Windows should start as a reading, clipping, and light editing device.

Avoid bulk renames and large structural changes on Windows until sync behavior is stable.

## Vault Path

Use a short path to reduce path-length problems, for example:

```text
C:\Users\<user>\Documents\agentic-knowledge-vault
```

Avoid deeply nested locations such as:

```text
C:\Users\<user>\Documents\Some\Very\Long\Nested\Sync\Path\agentic-knowledge-vault
```

## Filename Rules

Avoid Windows-invalid characters:

```text
< > : " / \ | ? *
```

Also avoid:

- trailing spaces
- trailing dots
- names that differ only by case
- reserved names such as `CON`, `PRN`, `AUX`, `NUL`, `COM1`, `LPT1`

## Line Endings

The repository uses `.gitattributes` to keep text files normalized with LF line endings.

## Sync

Recommended options:

1. WebDAV client or Obsidian WebDAV sync plugin for daily use.
2. Git clone for review/history if needed.
3. Do not sync `.git/` through WebDAV.

## Validation

Run from PowerShell on Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\05_tools\check_windows_compat.ps1
powershell -ExecutionPolicy Bypass -File .\05_tools\normalize_markdown_encoding.ps1 -Check .\01_raw
```

Run from Linux, macOS, WSL, or Git Bash:

```bash
05_tools/check_windows_compat.sh
05_tools/normalize_markdown_encoding.sh --check 01_raw
```

The main lint command also includes this check:

```bash
05_tools/lint_links.sh
```

## Encoding

The vault standard is UTF-8 without relying on Windows system locale.

Before importing project Markdown copied from Windows software or older Chinese projects, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\05_tools\normalize_markdown_encoding.ps1 .\00_inbox
```

The script accepts existing UTF-8 files and converts common GB18030/GBK/GB2312 text files to UTF-8.
