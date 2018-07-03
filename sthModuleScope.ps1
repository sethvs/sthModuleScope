using namespace System.Management.Automation

function Enter-sthModuleScope
{
    Param(
        [Parameter(Mandatory)]
        $Module
    )

    if ($Module = Get-Module -Name $Module -ListAvailable)
    {
        $Script:ModuleName = $Module.Name
        $currentPrompt = Get-Content -Path function:/prompt
        Set-Content -Path function:/prompt -Value {"[$($Module.Name)] PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "}

        . $(Import-Module -Name $Module -PassThru) {$Host.EnterNestedPrompt()}

        Set-Content -Path function:/prompt -Value $currentPrompt
        Remove-Variable -Name ModuleName -Scope Script
    }
}

function Get-sthModuleScopeFunction
{
    [CmdletBinding(DefaultParameterSetName='default')]
    Param(
        [Parameter(ParameterSetName='PublicOnly')]
        [switch]$PublicOnly,
        [Parameter(ParameterSetName='PrivateOnly')]
        [switch]$PrivateOnly,
        [Parameter(Position=0)]
        $Module
    )

    if ($PSBoundParameters.Module)
    {
        $Module = Get-Module -Name $Module -ListAvailable
        $Local:ModuleName = $Module.Name
    }

    if ($Script:ModuleName -or $Local:ModuleName)
    {
        $ScriptBlock = {
            Get-ChildItem -Path function: | 
            Where-Object -FilterScript {$_.Source -eq $ExecutionContext.SessionState.Module.Name}
        }

        inSetSessionState -ScriptBlock $ScriptBlock
        $result = . $ScriptBlock

        if ($result)
        {
            if ($PSCmdlet.ParameterSetName -eq 'default')
            {
                $result
            }
            else
            {
                $VisibleCommands = @(Get-Command -Module $ModuleName | ForEach-Object -MemberName Name)
                foreach ($res in $result)
                {
                    if ($PublicOnly -and $res -in $VisibleCommands)
                    {
                        $res
                    }
                    elseif ($PrivateOnly -and $res -notin $VisibleCommands)
                    {
                        $res
                    }
                }
            }
        }
    }
}

function Get-sthModuleScopeVariable
{
    [CmdletBinding(DefaultParameterSetName='default')]
    Param(
        [Parameter(ParameterSetName='PublicOnly')]
        [switch]$PublicOnly,
        [Parameter(ParameterSetName='PrivateOnly')]
        [switch]$PrivateOnly,
        [Parameter(Position=0)]
        $Module
    )

    if ($PSBoundParameters.Module)
    {
        $Module = Get-Module -Name $Module -ListAvailable
        $Local:ModuleName = $Module.Name
    }
    
    if ($Script:ModuleName -or $Local:ModuleName)
    {
        $ScriptBlock = {
            Get-Variable -Scope Script | Where-Object -FilterScript {$_.GetType().Name -eq 'PSVariable' -and $_.Name -notin @('true','false','error','PSCommandPath','PSScriptRoot','PSDefaultParameterValues','CurrentlyExecutingCommand')}
        }
        
        inSetSessionState -ScriptBlock $ScriptBlock

        $result = . $ScriptBlock
    }
    
    if ($result)
    {
        if ($PSCmdlet.ParameterSetName -eq 'default')
        {
            $result
        }
        else
        {
            foreach ($res in $result)
            {
                if ($PublicOnly -and $res.ModuleName)
                {
                    $res
                }
                elseif ($PrivateOnly -and -not $res.ModuleName)
                {
                    $res
                }
            }
        }
    }
}

function inSetSessionState
{
    Param(
        [ScriptBlock]$ScriptBlock,
        [SessionState]$SessionState = $null
        )

    if (!$SessionState)
    {
        $SessionState = & $(Import-Module -Name $ModuleName -PassThru) {$ExecutionContext.SessionState}
    }

    $flags = [System.Reflection.BindingFlags]'Instance,NonPublic'
    $SessionStateInternal = $SessionState.GetType().GetProperty('Internal', $flags).GetValue($SessionState, $null)
    [scriptblock].GetProperty('SessionStateInternal', $flags).SetValue($ScriptBlock, $SessionStateInternal, $null)
}

function Get-sthScopeDepth
{
    [CmdletBinding()]
    Param()
    
    $inc = 2
    $ScriptBlock = {
        Param($inc)
        $Depth = 0
        while ($true)
        {
            try
            {
                # Scope 0 - is ScriptBlock Scope
                # Scope 1 - it can be a global or some another scope, but in any case it will exist, so checking its existence is not nessessary.
                Get-Variable -Name true -Scope ($Depth + $inc) | Out-Null
            }
            catch
            {
                return $Depth
            }
            $Depth++
        }
    }

    $SessionState = $PSCmdlet.SessionState

    # if we will use Get-sthScopeDepth in this - sthModuleScope - module, one more scope - function Get-sthScopeDepth - will be added.
    # in other modules there will be no this function's scope
    if ($SessionState.Module.Name -eq 'sthModuleScope')
    {
        $inc++
    }

    inSetSessionState -ScriptBlock $ScriptBlock -SessionState $SessionState

    & $ScriptBlock $inc
}
