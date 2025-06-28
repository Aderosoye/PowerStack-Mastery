# Stop-RunningServices.ps1
Get-Service | Where-Object {$_.Status -eq 'Running'} | Stop-Service -WhatIf
