function Get-tpSize {
    [CmdletBinding()]
    param(
        [Parameter()]
        [int]$days
    )

    $TB = 1gb * 1024
    $PB = $TB * 1024
    $TruePoolParameters = @{
        APIEndPoint = "size"
        APIParameters = $PSBoundParameters
        Method = "GET"
    }
    $tpResponse = Invoke-TruePoolAPI @TruePoolParameters
    foreach ($datapoint in $tpResponse){
        $datapoint.datetime = [datetime]::Parse($datapoint.datetime)
        $datapoint | Add-Member -NotePropertyMembers @{
            Size_TB = [math]::Round($datapoint.size / $TB,2)
            Size_PB = [math]::Round($datapoint.size / $PB,2)
        }
    }
    $tpResponse
}