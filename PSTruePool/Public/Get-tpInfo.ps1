function Get-tpInfo {
    [CmdletBinding()]
    param()

    $tpResponse = Invoke-TruePoolAPI -APIEndPoint "info" -Method "GET"
    $tpResponse
}