function Get-tpPayout {
    [CmdletBinding(DefaultParameterSetName="query")]
    param(
        [Parameter(Mandatory,ParameterSetName="id")]
        [int]$id,

        [Parameter(ParameterSetName="query")]
        [string]$ordering,

        [Parameter(ParameterSetName="query")]
        [int]$limit,

        [Parameter(ParameterSetName="query")]
        [int]$offset
    )

    Process{
        $TruePoolParameters = @{
            APIEndPoint = "payout"
            Method = "GET"
        }
        if ($PSCmdlet.ParameterSetName -eq "query"){
            $TruePoolParameters["APIParameters"] = $PSBoundParameters
        }
        else{
            $TruePoolParameters["Single"] = $id
        }
        $tpResponse = Invoke-TruePoolAPI @TruePoolParameters
        if ($PSCmdlet.ParameterSetName -eq "query"){
            if ($Null -ne $tpResponse.results){
                foreach ($payout in $tpResponse.results){
                    $payout.psobject.TypeNames.Insert(0,"TruePool.Payout")
                    $payout
                }
            }
        }
        else{
            $tpResponse
        }
        
    } #Process
}