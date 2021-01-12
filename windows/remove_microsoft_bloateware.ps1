Get-AppxPackage -AllUsers | where-object {$_.name –notlike “*store*”} | Remove-AppxPackage
Get-appxprovisionedpackage –online | where-Object {$_.packagename –notlike “*store*”} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -like "*xbox*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -like "*bing*"} | Remove-AppxProvisionedPackage -Online