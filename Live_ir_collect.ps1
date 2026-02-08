# ==============================
# Live IR Collector - PowerShell
# ==============================

Write-Host "Live Incident Response Collector Starting..." -ForegroundColor Cyan

# --- Build Case Folder ---
$Desktop = [Environment]::GetFolderPath("Desktop")
$CaseDir = Join-Path $Desktop "Cases\Case01-PolicyViolation"

New-Item -ItemType Directory -Path $CaseDir -Force | Out-Null
Set-Location $CaseDir

# --- Build Output Filename ---
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$OutFile = "liveIR-$timestamp.txt"

function Add-Section {
    param($title)
    Add-Content $OutFile "`n===================="
    Add-Content $OutFile $title
    Add-Content $OutFile "===================="
}

# --- Start Logging ---
"IR Collection Start Time: $(Get-Date)" | Out-File $OutFile

# =====================
Add-Section "RUNNING PROCESSES"
Get-Process | Sort CPU -Descending | Out-String | Add-Content $OutFile

Add-Section "PROCESS DETAILS (WMI)"
Get-CimInstance Win32_Process | Select Name, ProcessId, ParentProcessId, CommandLine | Out-String | Add-Content $OutFile

# =====================
Add-Section "SERVICES"
Get-Service | Out-String | Add-Content $OutFile

# =====================
Add-Section "NETWORK CONNECTIONS"
netstat -nao | Out-String | Add-Content $OutFile

Add-Section "ARP CACHE"
arp -a | Out-String | Add-Content $OutFile

Add-Section "IP CONFIG"
ipconfig /all | Out-String | Add-Content $OutFile

Add-Section "DNS CACHE"
ipconfig /displaydns | Out-String | Add-Content $OutFile

Add-Section "ROUTE TABLE"
route print | Out-String | Add-Content $OutFile

# =====================
Add-Section "NETWORK ADAPTERS"
Get-NetAdapter | Out-String | Add-Content $OutFile

Add-Section "LISTENING PORTS (PS)"
Get-NetTCPConnection -State Listen | Out-String | Add-Content $OutFile

# =====================
Add-Section "LOGGED ON USERS"
query user | Out-String | Add-Content $OutFile

Add-Section "LOCAL USERS"
net user | Out-String | Add-Content $OutFile

Add-Section "CURRENT USER DETAILS"
net user $env:USERNAME | Out-String | Add-Content $OutFile

# =====================
Add-Section "NETWORK SHARES"
net share | Out-String | Add-Content $OutFile

# =====================
Add-Section "ENVIRONMENT VARIABLES"
Get-ChildItem Env: | Out-String | Add-Content $OutFile

# =====================
Add-Section "SCHEDULED TASKS"
schtasks | Out-String | Add-Content $OutFile

# =====================
Add-Section "STARTUP PROGRAMS"
Get-CimInstance Win32_StartupCommand | Out-String | Add-Content $OutFile

# =====================
Add-Section "SYSTEM INFO"
systeminfo | Out-String | Add-Content $OutFile

Add-Section "OS INFO (PS)"
Get-ComputerInfo | Out-String | Add-Content $OutFile

# =====================
Add-Section "DRIVE INFO"
Get-PSDrive | Out-String | Add-Content $OutFile

# =====================
Add-Section "RECENT FILES (USER)"
Get-ChildItem "$env:APPDATA\Microsoft\Windows\Recent" -ErrorAction SilentlyContinue | 
Select Name, LastWriteTime | Out-String | Add-Content $OutFile

# =====================
"IR Collection Complete: $(Get-Date)" | Add-Content $OutFile

Write-Host ""
Write-Host "Collection Complete." -ForegroundColor Green
Write-Host "Output File:" -ForegroundColor Yellow
Write-Host "$CaseDir\$OutFile"
