# Connectivity script to join Windows 10 to a WPA2 wireless network.
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

$ssid = "TESTNETWORK"
$username = "ADMIN"
$password = "12345"

Add-Type -AssemblyName System.ServiceModel.Dnssd
$probe = New-Object System.ServiceModel.Dnssd.DnssdWiFiProbe
$result = $probe.FindWiFiNetworkBySsid($ssid)
if ($result) {
    $wifi = [Windows.Networking.Connectivity.NetworkAdapter]::GetFromNetworkId("$ssid")
    $wifi.ConnectAsync("WPA2_Enterprise", $username, $password)
}
else {
    Write-Output "Network not found"
}
