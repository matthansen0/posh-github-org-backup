param (
    [string]$Username,
    [string]$Token,
    [string]$OrgName,
    [string]$BackupDir
)

$headers = @{
    "Authorization" = "Basic $([Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($Username):$($Token)")))"
    "Accept" = "application/vnd.github.v3+json"
}

$url = "https://api.github.com/orgs/$OrgName/repos?per_page=100"

do {
    $response = Invoke-RestMethod -Uri $url -Method Get -Headers $headers
    foreach ($repo in $response) {
        $repoName = $repo.name
        $repoUrl = $repo.html_url + ".git"
        $backupPath = "$BackupDir\$repoName.git"
        if (!(Test-Path $backupPath)) {
            git clone --mirror $repoUrl $backupPath
        } else {
            cd $backupPath
            git fetch --prune
        }
    }
    $url = $null
    foreach ($link in $response.Links) {
        if ($link.rel -eq "next") {
            $url = $link.uri
        }
    }
} while ($url)
