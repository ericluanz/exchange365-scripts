O Exchange não usa GMT-3 direto, ele usa o identificador:

👉 `E. South America Standard Time`

Esse é o *Horário de Brasília* (sem horário de verão, RIP).

🔹 Opção 1 — Atualizar UM usuário ou recurso:
Set-MailboxRegionalConfiguration -Identity usuario@suaempresa.com `
-TimeZone "E. South America Standard Time" `
-Language pt-BR `
-DateFormat "dd/MM/yyyy" `
-TimeFormat "HH:mm"

✔ Atualiza:
- Fuso horário
- Idioma
- Formato de data/hora
✔ Impacta OWA e calendário

🔹 Opção 2 — Atualizar TODAS as caixas (usuários + recursos)
⚠️ Use com cuidado.

Get-Mailbox -ResultSize Unlimited |
Set-MailboxRegionalConfiguration `
-TimeZone "E. South America Standard Time" `
-Language pt-BR `
-DateFormat "dd/MM/yyyy" `
-TimeFormat "HH:mm"

🔹 Opção 3 — Só recursos (salas e equipamentos)
Ideal pra evitar bagunçar usuários.

Get-Mailbox -RecipientTypeDetails RoomMailbox, EquipmentMailbox -ResultSize Unlimited |
Set-MailboxCalendarConfiguration `
    -WorkingHoursTimeZone "E. South America Standard Time" `
    -WorkingHoursStartTime 00:00 `
    -WorkingHoursEndTime 23:59 `
    -WorkDays AllDays

🔹 Comando para os calendários
Get-Mailbox -RecipientTypeDetails RoomMailbox, EquipmentMailbox -ResultSize Unlimited |
Set-CalendarProcessing -TimeZone "E. South America Standard Time"

🔍 Conferir se aplicou corretamente
Get-MailboxRegionalConfiguration usuario@elizcapital.com

Você deve ver: TimeZone : E. South America Standard Time

## ⚠️ Observações importantes

- Isso não altera eventos antigos já criados
- Afeta OWA e novos eventos
- Outlook Desktop:
    - O cliente usa o fuso do Windows
    - Se o Windows estiver errado, o Outlook vai continuar errado
