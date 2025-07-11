# Create user
New-AzADUser `
    -DisplayName "Dark Admin" `
    -UserPrincipalName "darkadmin01@adroyphill.onmicrosoft.com" `
    -Password "Darkone120" `
    -MailNickname "darkadmin01"

# Create group
New-AzADGroup `
    -DisplayName "PowerUsers" `
    -MailNickname "powerusers" `
    -SecurityEnabled $true

# Add user to group
$group = Get-AzADGroup -DisplayName "PowerUsers"
$user = Get-AzADUser -UserPrincipalName "darkadmin01@adroyphill.onmicrosoft.com"
Add-AzGroupMember -TargetGroupObjectId $group.Id -MemberObjectId $user.Id