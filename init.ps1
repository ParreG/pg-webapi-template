$projectName = Read-Host "Enter your project name (e.g. MyCompany.MyApi)"

if ([string]::IsNullOrWhiteSpace($projectName)) {
    Write-Host "Project name cannot be empty." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

$oldName = "PG.ProjectName"
$scriptPath = $MyInvocation.MyCommand.Path
$rootPath = Split-Path $scriptPath -Parent

Write-Host "`nInitializing project as '$projectName'..." -ForegroundColor Cyan

Write-Host "Replacing '$oldName' in file contents..." -ForegroundColor Gray
$extensions = @("*.cs", "*.json", "*.csproj", "*.sln", "*.yml", "*.md", "*.resx", "*.props", "*.config")
Get-ChildItem -Path $rootPath -Recurse -Include $extensions -File |
    Where-Object { $_.FullName -notmatch "\\(bin|obj|\.git)\\" } |
    ForEach-Object {
        $content = Get-Content $_.FullName -Raw
        if ($content -match [regex]::Escape($oldName)) {
            $content = $content -replace [regex]::Escape($oldName), $projectName
            Set-Content -Path $_.FullName -Value $content -NoNewline
            Write-Host "  Updated: $($_.FullName.Replace($rootPath, ''))" -ForegroundColor DarkGray
        }
    }

Write-Host "Renaming files..." -ForegroundColor Gray
Get-ChildItem -Path $rootPath -Recurse -File |
    Where-Object { $_.Name -match [regex]::Escape($oldName) } |
    ForEach-Object {
        $newName = $_.Name -replace [regex]::Escape($oldName), $projectName
        Rename-Item -Path $_.FullName -NewName $newName
        Write-Host "  Renamed: $($_.Name) -> $newName" -ForegroundColor DarkGray
    }

Write-Host "Renaming directories..." -ForegroundColor Gray
Get-ChildItem -Path $rootPath -Recurse -Directory |
    Where-Object { $_.Name -match [regex]::Escape($oldName) } |
    Sort-Object { $_.FullName.Length } -Descending |
    ForEach-Object {
        $newName = $_.Name -replace [regex]::Escape($oldName), $projectName
        Rename-Item -Path $_.FullName -NewName $newName
        Write-Host "  Renamed: $($_.Name) -> $newName" -ForegroundColor DarkGray
    }

Write-Host "Writing new README.md..." -ForegroundColor Gray
$readmeContent = @"
# $projectName

.NET Web API project bootstrapped from [pg-webapi-template](https://github.com/ParreG/pg-webapi-template).

## Getting started

``````bash
dotnet restore
dotnet build
dotnet run --project src/$projectName
``````

Open ``https://localhost:xxxx/scalar/v1`` in your browser to explore the API.

## Structure

- ``src/$projectName`` — Web API project
- ``tests/$projectName.Tests`` — Unit tests
"@

Set-Content -Path (Join-Path $rootPath "README.md") -Value $readmeContent

Write-Host "`nCommitting and pushing changes..." -ForegroundColor Cyan
Push-Location $rootPath
try {
    git add .
    git commit -m "Initialize project as $projectName"
    git push
    Write-Host "Pushed to remote." -ForegroundColor Green
} catch {
    Write-Host "Git push failed: $_" -ForegroundColor Yellow
    Write-Host "You can commit and push manually." -ForegroundColor Yellow
} finally {
    Pop-Location
}

Write-Host "`nRemoving init.ps1..." -ForegroundColor Gray
Remove-Item -Path $scriptPath -Force

Write-Host "`nDone! Project '$projectName' is ready." -ForegroundColor Green
Read-Host "`nPress Enter to close"
