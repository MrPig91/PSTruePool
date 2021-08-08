function Get-tpCoinRecord {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [Alias("Launcher_ID")]
        [string]$farmed_by,

        [Parameter(ValueFromPipelineByPropertyName)]
        [int]$payout,

        [Parameter()]
        [string]$order,

        [Parameter()]
        [int]$limit,

        [Parameter()]
        [int]$offset
    )

    Process{
        $TruePoolParameters = @{
            APIEndPoint = "coinrecord"
            APIParameters = $PSBoundParameters
            Method = "GET"
        }
        $tpResponse = Invoke-TruePoolAPI @TruePoolParameters
        if ($Null -ne $tpResponse.results){
            foreach ($coinrecord in $tpResponse.results){
                $coinrecord.psobject.TypeNames.Insert(0,"TruePool.CoinRecord")
                $coinrecord
            }
        }
        
    } #Process
}