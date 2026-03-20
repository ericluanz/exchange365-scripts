## Instalação rápida

Abra o **PowerShell 7 como administrador** e manda:

Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module PnP.PowerShell-Scope CurrentUser
Esse comando instala os cmdlets mais recentes para o usuário atual.

## Teste a instalação

Get-Command-Module PnP.PowerShell

Se vier uma lista gigante → sucesso.

O login interativo padrão foi descontinuado.

O PnP quer que você autentique usando um app no Entra ID

Use o login do próprio PnP: Register-PnPEntraIDAppForInteractiveLogin

Ele vai:
- abrir o navegador
- pedir login global admin
- criar o app automaticamente
- pedir para aceitar as permissões → aceite
- salve o CLIENT-ID em local seguro, ele não será exibido novamente
