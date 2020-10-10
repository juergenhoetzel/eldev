# FIXME Github URLs
# This script downloads Eldev startup script as `USERPROFILE/.eldev/bin/eldev'
# for use in a GitHub workflow.
#
# In your `.github/workflows/*.yml' add this:
#
#   run: iwr -useb https://raw.github.com/juergenhoetzel/eldev/powershell/webinstall/github-eldev.ps1 | iex
$ErrorActionPreference = "Stop"
$ELDEV_BIN_DIR = "$env:USERPROFILE\.eldev\bin"

mkdir -Force $ELDEV_BIN_DIR | Out-Null

Invoke-WebRequest https://raw.githubusercontent.com/juergenhoetzel/eldev/powershell/bin/eldev.ps1 -Outfile "$ELDEV_BIN_DIR\eldev.ps1"

# Magic output that instructs GitHub to modify `$PATH'.
Write-Host "::add-path::$ELDEV_BIN_DIR"