function Invoke-TruePoolAPI {
    [CmdletBinding()]
    param(
        [string]$APIEndPoint,
        [hashtable]$APIParameters,
        [string]$Method,
        [string]$Single
    )


    $uri = "https://truepool.io/v1/pool/$APIEndPoint"

    if ($APIParameters.Keys.Count){
        $QueryString = ($APIParameters.Keys | foreach {
            if (![string]::IsNullOrEmpty($_)){
                $value = $APIParameters[$_]
                "$_=$value"
            }
        }) -join '&'

        if (-not[string]::IsNullOrEmpty($QueryString)){
            $uri = [string]::Join("?",@($uri,$QueryString))
        }
    }
    elseif ($PSBoundParameters.ContainsKey("Single")){
        $uri = [string]::Join("/",@($uri,$Single))
    }

    $RestMethodParameters = @{
        Method = $Method
        Uri = $uri
        ErrorAction = "Stop"
    }

    Invoke-RestMethod @RestMethodParameters
}