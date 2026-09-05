# Exports team member names and roles to a CSV file for reporting purposes
function Export-TeamToCsv {
    param(
        [string]$OutputPath = "team-export.csv"
    )

    $team = @(
    [PSCustomObject]@{ Name = "Mathabo"; Role = "Developer" },
    [PSCustomObject]@{ Name = "Nadio"; Role = "Developer" },
    [PSCustomObject]@{ Name = "Andiswa"; Role = "Developer" },
    [PSCustomObject]@{ Name = "Kgomotso"; Role = "Developer" }
)
    )

    if (-not $team) {
        Write-Host "Error: no team data available"
        return
    }

    $team | Export-Csv -Path $OutputPath -NoTypeInformation
    Write-Host "Exported $($team.Count) team members to $OutputPath"
}

Export-TeamToCsv