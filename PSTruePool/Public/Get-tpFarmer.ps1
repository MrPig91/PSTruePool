function Get-tpFarmer {
    [CmdletBinding(DefaultParameterSetName="query")]
    param(
        [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName="Launcher_ID")]
        [string]$launcher_id,

        [Parameter(ParameterSetName="query")]
        [string]$search,

        [Parameter(ValueFromPipeline,ValueFromPipelineByPropertyName,ParameterSetName="query")]
        [string]$display_name,

        [Parameter(ValueFromPipeline,ValueFromPipelineByPropertyName,ParameterSetName="query")]
        [int]$difficulty,

        [Parameter(ParameterSetName="query")]
        [string]$order,

        [Parameter(ParameterSetName="query")]
        [int]$limit,

        [Parameter(ParameterSetName="query")]
        [int]$offset
    )

    Process{
        $TruePoolParameters = @{
            APIEndPoint = "farmer"
            APIParameters = $PSBoundParameters
            Method = "GET"
        }
        $tpResponse = Invoke-TruePoolAPI @TruePoolParameters
        if ($Null -ne $tpResponse.results){
            foreach ($farmer in $tpResponse.results){
                $farmer.psobject.TypeNames.Insert(0,"TruePool.Farmer")
                $farmer
            }
        }
        
    } #Process
}