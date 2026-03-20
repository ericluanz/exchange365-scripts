## 📌 Fuso horário do Exchange Online (Horário de Brasília)

O Exchange não usa GMT-3 direto, para os parâmetros de TimeZone ele usa o identificador:

👉 E. South America Standard Time

Language vai usar o valor pt-BR.

🔹 Atualizar uma conta específica

Set-MailboxRegionalConfiguration -Identity "seuemail@empresa.com" -Language pt-BR -LocalizeDefaultFolderName:$true -TimeZone "E. South America Standard Time"

Atualiza:
- Fuso horário
- Idioma
- Idioma das pastas padrão
✔ Impacta OWA e calendário

## 🔹 Para todas as contas
⚠️ Use com cuidado.

Get-Mailbox -ResultSize Unlimited | Set-MailboxRegionalConfiguration -Language pt-BR -LocalizeDefaultFolderName:$true -TimeZone "E. South America Standard Time"

## 🔹 Para todas as contas, exceto algumas
⚠️ Use com cuidado.

Get-Mailbox -ResultSize Unlimited | Where-Object { 
    $_.PrimarySmtpAddress -ne "seuemail@empresa.com" -and
    $_.PrimarySmtpAddress -ne "seuemail2@empresa.com"
} | Set-MailboxRegionalConfiguration -Language pt-BR -LocalizeDefaultFolderName:$true -TimeZone "E. South America Standard Time"

🔍 Conferir se aplicou corretamente

Get-MailboxRegionalConfiguration -Identity "seuemail@empresa.com" | Select Language, TimeZone, DateFormat, TimeFormat

Você deve ver: TimeZone : E. South America Standard Time

Todas as contas:
Get-Mailbox -ResultSize Unlimited | ForEach-Object {
    $User = $_.PrimarySmtpAddress
    Get-MailboxRegionalConfiguration -Identity $User | Select-Object @{Name="User";Expression={$User}}, DefaultFolderNameMatchingUserLanguage, Language, TimeZone, DateFormat, TimeFormat
} | FT -AutoSize
