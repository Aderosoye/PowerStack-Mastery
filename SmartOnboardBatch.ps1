# Connect to Microsoft Graph
Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All", "Directory.ReadWrite.All", "Mail.Send"

# Input CSV and log paths
$CsvPath = "C:\Users\a84302994\Documents\GitHub\Dark\NewUsers.csv"
$LogPath = "C:\Users\a84302994\Documents\GitHub\Dark\OnboardLog.txt"

# Ensure log directory exists
if (!(Test-Path -Path (Split-Path -Path $LogPath -Parent))) {
    New-Item -ItemType Directory -Path (Split-Path -Path $LogPath -Parent) | Out-Null
}

# Load CSV data
$Users = Import-Csv -Path $CsvPath

# Loop through each user in the CSV
foreach ($User in $Users) {
    try {
        Write-Host "`nProcessing user: $($User.DisplayName) <$($User.UserPrincipalName)>"

        # Check if user already exists
        $ExistingUser = Get-MgUser -Filter "UserPrincipalName eq '$($User.UserPrincipalName)'" -ErrorAction SilentlyContinue
        if ($ExistingUser) {
            Add-Content $LogPath "SKIPPED: User $($User.UserPrincipalName) already exists."
            continue
        }

        # Create the user
        $NewUser = New-MgUser -AccountEnabled $true `
            -DisplayName $User.DisplayName `
            -UserPrincipalName $User.UserPrincipalName `
            -PasswordProfile @{ Password = $User.Password; ForceChangePasswordNextSignIn = $true } `
            -MailNickname $User.MailNickname `
            -UsageLocation "NG"

        Add-Content $LogPath "CREATED: User $($User.UserPrincipalName) created successfully."

        # Check or create group
        $Group = Get-MgGroup -Filter "DisplayName eq '$($User.GroupName)'" -ErrorAction SilentlyContinue
        if (-not $Group) {
            $Group = New-MgGroup -DisplayName $User.GroupName -MailEnabled $false -MailNickname "$($User.GroupName)-group" -SecurityEnabled $true -GroupTypes @()
            Add-Content $LogPath "GROUP CREATED: $($User.GroupName) group created successfully."
        }

        # Add user to the group
        Add-MgGroupMember -GroupId $Group.Id -DirectoryObjectId $NewUser.Id
        Add-Content $LogPath "ADDED TO GROUP: User $($User.UserPrincipalName) added to group $($User.GroupName)."

        # Assign the license
        $SkuId = (Get-MgSubscribedSku | Where-Object { $_.SkuPartNumber -eq "0365_BUSINESS_PREMIUM" }).SkuId
        Set-MgUserLicense -UserId $NewUser.Id -AddLicenses @{ SkuId = $SkuId } -RemoveLicenses @()
        Add-Content $LogPath "LICENSE ASSIGNED: License assigned to user $($User.UserPrincipalName)."

        # Send welcome email
        $WelcomeSubject = "Welcome to Dark Domain"
        $WelcomeBody = @"
Hello $($User.DisplayName),

Welcome aboard! Your account has been created successfully. 
Please log in using your credentials sent sent securely by your admin.

-Dark Team
"@
        Send-MailMessage -To $User.UserPrincipalName -Subject $WelcomeSubject -Body $WelcomeBody -SmtpServer "smtp.office365.com" -Port 587 -UseSsl
        Add-Content $LogPath "EMAIL SENT: Welcome email sent to $($User.UserPrincipalName)."
    } catch {
        Add-Content $LogPath "ERROR: $($User.UserPrincipalName) →$($_.Exception.Message)"
    }
}