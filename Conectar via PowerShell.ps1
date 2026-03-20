## 🔌 Conectar ao Exchange Online (Admin)

Conecte ao Exchange Online utilizando uma conta administrativa do Microsoft 365.

---

## 📦 Instalar o módulo (primeira vez)

Se o módulo ainda não estiver instalado, execute:

```powershell
Install-Module ExchangeOnlineManagement -Scope CurrentUser
```

Se já estiver instalado, você pode pular esta etapa.

---

## 🔐 Conectar forçando a conta correta

```powershell
Connect-ExchangeOnline -UserPrincipalName seuemail@empresa.com
```

✔ Abre a tela de login diretamente na autenticação  
✔ MFA funciona normalmente  
✔ Evita conflito com outras contas logadas no Windows  

---

## ✅ Conferir conexão (opcional, recomendado)

```powershell
Get-OrganizationConfig | Select Name
```
