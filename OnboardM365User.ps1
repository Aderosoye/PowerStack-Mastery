# Variables
$DisplayName = "Dark User"
$UserPrincipalName = "dark.user@darkdomain.onmicrosoft.com"
$Password = "DarkPass120"
$LicenseSku = "darkdomain:0365_BUSINESS_PREMIUM"
$GroupName = "Dark Sales"
$WelcomeSubject = "Welcome to Dark Domain"
$WelcomeBody = "Hello $DisplayName,`n`nWelcome to Dark Domain! Your account has been created successfully. Please log in using your credentials.`n`nBest regards,`nDark Domain Team"

# Connect to Microsoft 365
Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All", "Directory.ReadWrite.All", "Mail.Send"

# Create the user
$User = New-MgUser -AccountEnabled $true `
    -DisplayName $DisplayName `
    -UserPrincipalName $UserPrincipalName `
    -PasswordProfile @{ Password = $Password; ForceChangePasswordNextSignIn = $true } `
    -MailNickname "darkuser" `
    -GivenName "Dark" `
    -UsageLocation "US" 

# Assign the license
$Licenses = @(
    @{
        SkuId = (Get-MgSubscribedSku | Where-Object { $_.SkuPartNumber -eq "0365_BUSINESS_PREMIUM" }).SkuId

    }
)

# Set the license user
Set-MgUserLicense -UserId $User.Id -AddLicenses $Licenses -RemoveLicenses @()

# Add the user to the group
$Group = Get-MgGroup -Filter "DisplayName eq '$GroupName'"
Add-MgGroupMember -GroupId $Group.Id -DirectoryObjectId $User.Id

# Send wekcome email
Send-MailMessage -From "admin@darkdomain.com" -To $UserPrincipalName `
    -Subject $WelcomeSubject -Body $WelcomeBody -SmtpServer "smtp.office365.com"
    -UseSsl -Credential (Get-Credential -Message "Enter your Office 365 admin credentials")

Write-Output "User onboarding completed for $DisplayName"