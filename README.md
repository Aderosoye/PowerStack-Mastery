# PowerStack-Mastery

### [July 3, 2025] Azure Deployment – PowerShell Lab

- Deployed Resource Group: `DarkRG`
- Deployed Storage Account: `darkstoragelab01`
- Tool Used: PowerShell with Az module
- Learned:
  - How to authenticate to Azure via CLI
  - Created isolated resource containers (RG)
  - Provisioned globally-available storage
  - Understood the logic behind SKU, Kind, and region choices
- Reflections:
  - PowerShell is extremely powerful for managing Azure
  - Learned that naming conventions matter due to global uniqueness
  - Will reuse this template for future automation scripts

# ⚡ PowerShell M365 User Onboarding Toolkit

Automate the entire Microsoft 365 onboarding process in minutes — from user creation to license assignment, group membership, and welcome email — using nothing but PowerShell and Graph API.

---

## 🔧 What This Toolkit Does

- Creates a new user in Microsoft 365 (Azure AD / Entra ID)
- Automatically assigns a license (e.g., O365 Business Premium)
- Adds user to a specified group (e.g., "Sales", "HR")
- Sends a welcome email with login instructions
- Fully customizable — built with Microsoft Graph PowerShell SDK

---

## 📂 Files Included

- `Onboard-M365User.ps1` – Main automation script
- `onboarding-checklist.pdf` – Simple checklist to follow during onboarding
- `license-setup-guide.pdf` – Instructions to find and set license SKUs
- `README.md` – This file

---

## 🚀 Quick Start

1. **Install Graph SDK:**

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
