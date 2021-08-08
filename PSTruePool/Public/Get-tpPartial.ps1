function Get-tpPartial {
    [CmdletBinding(DefaultParameterSetName="query")]
    param(
        [Parameter(Mandatory,ParameterSetName="partial_id")]
        [int]$id,

        [Parameter(ValueFromPipeline,ValueFromPipelineByPropertyName,ParameterSetName="query")]
        [string]$launcher_id,

        [Parameter(ParameterSetName="query")]
        [int]$timestamp,

        [Parameter(ParameterSetName="query")]
        [int]$start_timestamp,

        [Parameter(ParameterSetName="query")]
        [string]$order,

        [Parameter(ParameterSetName="query")]
        [int]$limit,

        [Parameter(ParameterSetName="query")]
        [int]$offset
    )

    Process{
        $TruePoolParameters = @{
            APIEndPoint = "partial"
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
                foreach ($partial in $tpResponse.results){
                    $partial.psobject.TypeNames.Insert(0,"TruePool.Partial")
                    $partial
                }
            }
        }
        else{
            $tpResponse
        }
        
    } #Process
}