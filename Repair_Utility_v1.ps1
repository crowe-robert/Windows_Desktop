# Windows OS Repair Utility v1. Windows 10 and newer.
#
# Copyright 2023 Robert Crowe
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the Apache License as published by
# the Apache Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# Apache License for more details.
#
# You should have received a copy of the Apache License
# along with this program.  If not, see <https://apache.org/licenses/>.

$ErrorActionPreference = "Stop"

while ($true) {
  Clear-Host
  Write-Host "Repair Utility v1"
  Write-Host "----------------"
  Write-Host "1 - Enable Microsoft Windows Updates"
  Write-Host "2 - Enable WSUS"
  Write-Host "3 - Reset network"
  Write-Host "4 - Clear print spooler"
  Write-Host "5 - Quit"

  $choice = Read-Host "Enter your selection (1-5):"

  switch ($choice) {
    1 {
      Stop-Service -Name wuauserv -Force
      Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name "UseWUServer" -Value 0
      Start-Service -Name wuauserv
      Write-Host "Microsoft Windows Updates task is completed, returning to main menu."
      break
    }
    2 {
      Stop-Service -Name wuauserv -Force
      Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name "UseWUServer" -Value 1
      Start-Service -Name wuauserv
      Write-Host "WSUS task is completed, returning to main menu."
      break
    }
    3 {
      ipconfig /release
      ipconfig /renew
      ipconfig /flushdns
      ipconfig /registerdns
      Write-Host "Reset network task is completed, returning to main menu."
      break
    }
    4 {
      net stop spooler
      Remove-Item -Path "$env:windir\system32\spool\printers\*" -Force -Recurse
      net start spooler
      Write-Host "Clear print spooler task is completed, returning to main menu."
      break
    }
    5 {
      Write-Host "Quitting Repair Utility v1. Have a nice day!"
      break
    }
    default {
      Write-Host "Invalid option, please try again."
    }
  }

  if ($choice -eq 5) {
    break
  }
}
