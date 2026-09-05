param(
    [string]$Path = "team.json"
)

try {
    $rawJson = Get-Content -Path $Path -Raw -ErrorAction Stop
    $team = $rawJson | ConvertFrom-Json -ErrorAction Stop
}
catch {
    Write-Error "team.json could not be read or contains malformed JSON."
    exit 1
}

if ($team -isnot [System.Array]) {
    Write-Error "team.json must contain a JSON array of team members."
    exit 1
}

foreach ($member in $team) {
    if ([string]::IsNullOrWhiteSpace([string]$member.name)) {
        Write-Error "Each team member must have a name."
        exit 1
    }

    if ([string]::IsNullOrWhiteSpace([string]$member.role)) {
        Write-Error "Each team member must have a role."
        exit 1
    }
}

Write-Host "team.json is valid. All team members have a name and role."
