## 1. Auto mapping (via PowerShell)
Funciona apenas no Outlook Classic (não no “novo Outlook”).

## Consultar permissões existentes em uma caixa postal:
Get-MailboxPermission -Identity email@empresa.com

## Criar permissão de acesso a caixa postal completa e mapear automaticamente no Outlook Classic do usuário — sem precisar adicionar manualmente:
Add-MailboxPermission -Identity email@empresa.com -User "email@empresa.com" -AccessRights FullAccess -AutoMapping:$true

🟢 Resultado:
Quando o usuário abrir o Outlook novamente, essa permissão mapeia automaticamente a caixa “email@empresa.com”, aparecendo no painel esquerdo — inclusive o calendário.

🔴 Observação:
Esse método permite o manuseio total da caixa postal.

Get-Mailbox -ResultSize Unlimited | Add-MailboxPermission -User "email@empresa.com" -AccessRights FullAccess -AutoMapping:$false

Get-Mailbox -ResultSize Unlimited | ForEach-Object {
    $mailbox = $_
    Get-MailboxPermission -Identity $mailbox.PrimarySmtpAddress | 
    Where-Object { $_.User -notlike "NT AUTHORITY*" -and $_.IsInherited -eq $false } |
    Select-Object @{Name="Caixa";Expression={$mailbox.PrimarySmtpAddress}}, User, AccessRights
} | Format-Table -AutoSize
