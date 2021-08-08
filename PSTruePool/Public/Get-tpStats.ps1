function Get-tpStats {
    [CmdletBinding()]
    param()

    $TruePoolParameters = @{
        APIEndPoint = "stats"
        Method = "GET"
    }
    Invoke-TruePoolAPI @TruePoolParameters
}