param(
    [string]$MavenVersion = '3.8.8',
    [string]$TakariWrapperVersion = '0.5.6'
)

Write-Host "Bootstrapping Maven wrapper (will download a temporary Maven $MavenVersion to generate wrapper)..."

$tmp = Join-Path $env:TEMP "maven-bootstrap-$([guid]::NewGuid().ToString())"
New-Item -ItemType Directory -Path $tmp | Out-Null

$zip = Join-Path $tmp "apache-maven-$MavenVersion-bin.zip"

$primaryUrl = "https://dlcdn.apache.org/maven/maven-3/$MavenVersion/binaries/apache-maven-$MavenVersion-bin.zip"
$archiveUrl = "https://archive.apache.org/dist/maven/maven-3/$MavenVersion/binaries/apache-maven-$MavenVersion-bin.zip"

Write-Host "Attempting to download Maven $MavenVersion from primary URL: $primaryUrl ..."
try {
    Invoke-WebRequest -Uri $primaryUrl -OutFile $zip -UseBasicParsing -ErrorAction Stop
} catch {
    Write-Warning "Primary download failed, trying archive URL: $archiveUrl"
    try {
        Invoke-WebRequest -Uri $archiveUrl -OutFile $zip -UseBasicParsing -ErrorAction Stop
    } catch {
        Write-Error "Failed to download Maven from both primary and archive URLs: $_"
        exit 1
    }
}

$extract = Join-Path $tmp "apache-maven-$MavenVersion"
Write-Host "Extracting to $extract ..."
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($zip, $tmp)

$mvnCmd = Join-Path $extract "bin\mvn.cmd"
if (!(Test-Path $mvnCmd)) {
    Write-Error "mvn.cmd not found after extraction"
    exit 1
}

Write-Host "Generating Maven Wrapper (takari wrapper $TakariWrapperVersion)..."
& $mvnCmd -N "io.takari:maven:wrapper:$TakariWrapperVersion:wrapper" 2>&1 | Write-Host

Write-Host "Cleaning up temporary files..."
Remove-Item -Recurse -Force $tmp

Write-Host "Done. You should now have ./mvnw, ./mvnw.cmd and ./.mvn/wrapper/* in this project. Use .\mvnw.cmd test to run tests on Windows."
