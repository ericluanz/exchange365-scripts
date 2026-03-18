# ==========================================
# Exchange 365 Scripts 
# ==========================================

# ================================
# CONEXÃO
# ================================
function Connect-Exchange {
    Write-Host "Conectando ao Exchange Online..." -ForegroundColor Cyan
    Import-Module ExchangeOnlineManagement -ErrorAction SilentlyContinue
    Connect-ExchangeOnline
}

# ================================
# MAILBOX
# ================================
function New-SharedMailbox {
    param($Name, $Email)
    Write-Host "Criando Shared Mailbox..." -ForegroundColor Yellow
    New-Mailbox -Shared -Name $Name -DisplayName $Name -PrimarySmtpAddress $Email
}

function Convert-ToShared {
    param($Email)
    Write-Host "Convertendo para Shared Mailbox..." -ForegroundColor Yellow
    Set-Mailbox $Email -Type Shared
}

function Enable-Archive {
    param($Email)
    Write-Host "Ativando Archive..." -ForegroundColor Yellow
    Enable-Mailbox $Email -Archive
}

function Set-MailboxQuota {
    param($Email, $Send, $SendReceive)
    Set-Mailbox $Email -ProhibitSendQuota $Send -ProhibitSendReceiveQuota $SendReceive
}

# ================================
# PERMISSÃO
# ================================
function Add-FullAccess {
    param($Mailbox, $User)
    Add-MailboxPermission -Identity $Mailbox -User $User -AccessRights FullAccess
}

function Add-SendAs {
    param($Mailbox, $User)
    Add-RecipientPermission -Identity $Mailbox -Trustee $User -AccessRights SendAs
}

function Add-SendOnBehalf {
    param($Mailbox, $User)
    Set-Mailbox $Mailbox -GrantSendOnBehalfTo $User
}

function Audit-Permissions {
    param($Mailbox)
    Get-MailboxPermission $Mailbox
}

# ================================
# GRUPOS
# ================================
function New-DistributionList {
    param($Name, $Email)
    New-DistributionGroup -Name $Name -PrimarySmtpAddress $Email
}

function Add-MembersBulk {
    param($Group, $CsvPath)
    Import-Csv $CsvPath | ForEach-Object {
        Add-DistributionGroupMember -Identity $Group -Member $_.Email
    }
}

function Export-Members {
    param($Group, $Path)
    Get-DistributionGroupMember $Group |
        Select Name,PrimarySmtpAddress |
        Export-Csv $Path -NoTypeInformation
}

# ================================
# REPORTS
# ================================
function Get-InactiveMailboxes {
    Get-Mailbox -InactiveMailboxOnly
}

function Get-StorageReport {
    Get-MailboxStatistics | Select DisplayName,TotalItemSize
}

# ================================
# SEGURANÇA
# ================================
function Get-LoginAudit {
    Search-UnifiedAuditLog -StartDate (Get-Date).AddDays(-7) -EndDate (Get-Date)
}

function Get-Forwarding {
    Get-Mailbox | Select UserPrincipalName,ForwardingSmtpAddress
}

function Get-InboxRulesAudit {
    param($Mailbox)
    Get-InboxRule -Mailbox $Mailbox
}

# ================================
# MENU INTERATIVO
# ================================
function Show-Menu {
    Clear-Host
    Write-Host "=====================================" -ForegroundColor Cyan
    Write-Host " Exchange Online Admin Toolkit"
    Write-Host "====================================="

    Write-Host "1. Criar Shared Mailbox"
    Write-Host "2. Converter para Shared"
    Write-Host "3. Ativar Archive"
    Write-Host "4. Adicionar Full Access"
    Write-Host "5. Criar Distribution List"
    Write-Host "6. Relatório de Storage"
    Write-Host "7. Auditoria de Login"
    Write-Host "8. Ver Encaminhamento"
    Write-Host "9. Sair"

    $choice = Read-Host "Escolha uma opção"

    switch ($choice) {
        1 {
            $name = Read-Host "Nome"
            $email = Read-Host "Email"
            New-SharedMailbox $name $email
        }
        2 {
            $email = Read-Host "Email"
            Convert-ToShared $email
        }
        3 {
            $email = Read-Host "Email"
            Enable-Archive $email
        }
        4 {
            $mailbox = Read-Host "Mailbox"
            $user = Read-Host "Usuário"
            Add-FullAccess $mailbox $user
        }
        5 {
            $name = Read-Host "Nome do Grupo"
            $email = Read-Host "Email"
            New-DistributionList $name $email
        }
        6 {
            Get-StorageReport | Format-Table
        }
        7 {
            Get-LoginAudit | Format-Table
        }
        8 {
            Get-Forwarding | Format-Table
        }
        9 {
            Disconnect-ExchangeOnline
            exit
        }
    }

    Pause
    Show-Menu
}

# ================================
# EXECUÇÃO
# ================================
Connect-Exchange
Show-Menu