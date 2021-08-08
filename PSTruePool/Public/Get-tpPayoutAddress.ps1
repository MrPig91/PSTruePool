function Get-tpPayoutAddress {
    [CmdletBinding(DefaultParameterSetName="query")]
    param(
        [Parameter(Mandatory,ParameterSetName="id")]
        [int]$id,

        [Parameter(ParameterSetName="query")]
        [string]$payout,

        [Parameter(ParameterSetName="query")]
        [string]$puzzle_hash,

        [Parameter(ParameterSetName="query")]
        [string]$farmer,

        [Parameter(ParameterSetName="query")]
        [string]$ordering,

        [Parameter(ParameterSetName="query")]
        [int]$limit,

        [Parameter(ParameterSetName="query")]
        [int]$offset
    )

    Process{
        $TruePoolParameters = @{
            APIEndPoint = "payout_address"
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
                foreach ($payoutAddress in $tpResponse.results){
                    $payoutAddress.psobject.TypeNames.Insert(0,"TruePool.PayoutAddress")
                    $payoutAddress
                }
            }
        }
        else{
            $tpResponse
        }
        
    } #Process
}