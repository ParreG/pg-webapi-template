$projectName = Read-Host "Enter your new project name (e.g. My.NewProject)."

if ([string]::IsNullOrWhiteSpace($projectName)) {
    Write-Host "Project name cannot be empty!" -ForegroundColor Red
    exit
}

$placeholder = "PG.ProjectName"
$rootPath = $PSScriptRoot

Write-Host "Renaming project to $projectName..." -ForegroundColor Cyan

# Replace text in files
Get-ChildItem -Path $rootPath -Recurse -File -Include "*.cs","*.json","*.csproj","*.sln","*.yml","*.md" |
ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    if ($content -match $placeholder) {
        $content -replace $placeholder, $projectName | Set-Content $_.FullName
        Write-Host "Updated: $($_.Name)"
    }
}

# Rename files
Get-ChildItem -Path $rootPath -Recurse -File | Where-Object { $_.Name -match $placeholder } |
ForEach-Object {
    $newName = $_.Name -replace $placeholder, $projectName
    Rename-Item $_.FullName $newName
    Write-Host "Renamed file: $($_.Name) -> $newName"
}

# Rename folders
Get-ChildItem -Path $rootPath -Recurse -Directory | Where-Object { $_.Name -match $placeholder } |
Sort-Object { $_.FullName.Length } -Descending |
ForEach-Object {
    $newName = $_.Name -replace $placeholder, $projectName
    Rename-Item $_.FullName $newName
    Write-Host "Renamed folder: $($_.Name) -> $newName"
}

Write-Host "Done! Project renamed to $projectName" -ForegroundColor Green

# Delete this script
Remove-Item $PSScriptRoot\init.ps1