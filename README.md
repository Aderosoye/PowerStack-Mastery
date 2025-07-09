# ⚡ PowerStack-Mastery

A dual-purpose toolkit repository that includes:
- Azure automation labs using PowerShell (`Az` module)
- Microsoft 365 user onboarding automation using Microsoft Graph

Built for engineers, sysadmins, and cloud professionals looking to streamline operations with elite-level scripting.

---

## 📅 [July 3, 2025] Azure Deployment – PowerShell Lab

**Deployed Resources:**
- Resource Group: `DarkRG`
- Storage Account: `darkstoragelab01`
- Tool: PowerShell (`Az` module)

### 🔍 What I Learned:
- Authentication via Azure CLI and Az module
- How to create isolated containers with `New-AzResourceGroup`
- Storage account provisioning with SKU/Kind/Location control
- Naming conventions matter (e.g., globally unique storage names)

### 💡 Reflections:
- PowerShell is extremely powerful and scriptable for repeatable cloud setups
- This template will form the base of all future IaaS automation

---

## 🛡️ PowerShell M365 User Onboarding Toolkit

Automate Microsoft 365 onboarding using PowerShell and Microsoft Graph SDK — from **user creation** to **license assignment**, **group membership**, and **welcome email** dispatch.

---

### 🔧 What This Toolkit Does

- Creates new users in Microsoft 365 (Entra ID / Azure AD)
- Assigns licenses (O365 Business Premium default)
- Creates and assigns groups
- Sends welcome emails
- Supports bulk onboarding via CSV
- Includes logs and error handling

---

## 📂 Files Included

```bash
├── Onboard-M365User.ps1              # Single-user onboarding script
├── SmartOnboardBatch.ps1             # CSV-based batch onboarding script
├── users.csv                         # Sample input file for batch onboarding
└── README.md                         # This file


