# 🛡️ Project 1: The IM8-Hardened "Digital Vault" (Landing Zone)

## 📖 Executive Summary
In legal discovery, the integrity of **Electronically Stored Information (ESI)** is paramount. This project deploys a secure landing zone that eliminates public internet exposure, ensuring a forensic "Chain of Custody" for sensitive government and legal data.

## 🏗️ Technical Architecture
This overview illustrates the "Zero-Trust" bridge between the application layer and the hardened storage vault.

![Architecture Diagram](./images/overview%20diagram.png)

## 📸 Deployment & Compliance Evidence

### 1. Automated Infrastructure Provisioning
The deployment was executed via a modular Bicep template, confirmed by the Azure Resource Manager.
* **Status**: Succeeded.
* **Resource Group**: `rg-epiq-test`.

![Deployment Success](./images/image1.png)
*Figure 1: PowerShell terminal showing successful ARM validation and deployment name.*

### 2. Zero-Trust Networking (Public Access: Disabled)
The primary security control ensures that the ESI Storage Account is invisible to the public internet.
* **Control**: Public Network Access set to 'Disabled'.
* **Access Method**: Private Endpoint only.

![Storage Security](./images/image4.png)
*Figure 2: Azure Portal verification of restricted network access for the Storage Account.*

### 3. Resource Inventory Audit
A CLI-based audit confirms all critical components (VNet, NSG, Key Vault, Storage, Private Endpoint) are active in the Singapore region.

**Command**: `az resource list --resource-group rg-epiq-test --output table`

![Inventory Audit](./images/image2.png)
*Figure 3: Audited list of physical cloud resources and their deployment status.*

---

## 🛠️ How to Deploy
1. Clone this repository.
2. Navigate to `./Project-1-Landing-Zone`.
3. Run the deployment script:
   ```powershell
   .\scripts\deploy.ps1

##   Decomissioning

PS command : .\scripts\Cleanup.ps1

END 


# 🛰️ Project 2: Sentinel Watchtower & IM8 Compliance Monitoring

## 📖 Overview
This project focuses on the implementation of **Continuous Security Monitoring** and **Detective Controls** within the Azure environment. Designed to align with Singapore's **IM8 (Instruction Manual 8)** security standards, this architecture establishes a centralized "Watchtower" using a Log Analytics Workspace to capture audit trails, monitor for privilege escalation, and visualize compliance across the tenant.

## 🛠️ Tech Stack
* **Infrastructure as Code:** Azure Bicep
* **SIEM:** Microsoft Sentinel
* **Telemetry Pipeline:** Azure Monitor Diagnostic Settings
* **Query Language:** Kusto Query Language (KQL)
* **Governance:** Azure Workbooks (Dashboards)

## ✨ Key Capabilities Demonstrated
* **Cross-Resource Telemetry:** Automated diagnostic streaming from Azure Key Vault to a centralized SIEM.
* **Privilege Escalation Detection:** Authored KQL alert logic to identify unauthorized "Global Administrator" role assignments in Entra ID.
* **Compliance Visualization:** Developed an IM8-aligned dashboard to monitor Disk Encryption status across all Virtual Machines.
* **Advanced Troubleshooting:** Implemented custom PowerShell polling logic to validate telemetry ingestion during cloud provider latency.

---

## 🖼️ Implementation Evidence

### 1. Telemetry Bridge Configuration
Demonstrates the successful configuration of the `RouteToSentinel` telemetry bridge, routing `AuditEvent` logs to the centralized Log Analytics Workspace.
![Diagnostic Settings](./images/Proof%20of%20Configuration%20Route%20to%20Sentinel.png)

### 2. Data Plane Audit Generation
Validation of secret creation within the production-tier Key Vault to trigger an auditable event for Sentinel ingestion.
![Secret Creation](./images/Portfolio-Audit-Proof.png)

### 3. Governance & Compliance Dashboard
A custom-built Azure Workbook providing real-time visibility into Disk Encryption status across the environment, aligned with IM8 security guidelines.
![IM8 Workbook](./images/IM8%20Compliance%20Workbook%20Disk%20Encrpytion%20status%20.png)

### 4. Infrastructure-as-Code (IaC) Validation
CLI output confirming the successful automated provisioning of the Sentinel Alert rules and the IM8 Compliance Workbook via Bicep.
![Deployment Success](./images/Evidence_3_Deployment_Success.png)

---

## 🧪 How to Verify
To reproduce the security monitoring environment:

1. **Deploy Monitoring Stack:**
   ```powershell
   az deployment group create --resource-group "rg-epiq-test" --template-file "./infra/monitoring.bicep"

2. **Trigger Audit Event: Powershell**
    Set-AzKeyVaultSecret -VaultName "kv-ep-prd-vfrlat" -Name "AuditTest" -SecretValue (ConvertTo-SecureString "TestValue" -AsPlainText -Force)

3. **Validate via KQL**
    AzureDiagnostics 
 where OperationName =~ 'SecretSet' 
 project TimeGenerated, Resource, OperationName

 # 💰 Project 3: FinOps & Governance Automation

## 📖 Executive Summary
In enterprise cloud environments like **GCC 2.0**, "Cloud Sprawl" and orphaned resources lead to unnecessary billing and compliance gaps. This project automates Resource Governance and Cost Management to proactively mitigate waste. It utilizes a **User-Assigned Managed Identity (IM8 IA-3)** to execute a cost-auditing script securely, eliminating the need for expiring Service Principal secrets.

## 🛠️ Tech Stack
* **Infrastructure as Code:** Azure Bicep
* **Automation:** PowerShell, Azure CLI
* **Governance:** Azure Policy (Subscription Level)
* **Identity & Access Management:** User-Assigned Managed Identities

## ✨ Key Capabilities & Tasks Executed
1. **Secret-less Automation:** Deployed a Managed Identity to run scripts without hardcoded credentials.
2. **The "Orphan Hunter":** Authored a PowerShell automation script that scans the Azure tenant for unattached Managed Disks and unassociated Public IPs (Zombie resources).
3. **Automated Resource Governance:** Authored and deployed a Subscription-level Azure Policy that automatically appends a `Security-Review-Date` tag to all newly created resource groups.

## 🖼️ Deployment Evidence

### 1. The Cost Audit Execution
Execution of the `Find-OrphanResources.ps1` script identifying an unassociated Public IP in the production resource group.
![Cost Audit Success](./images/Evidence_1_Cost_Audit.png)
*Figure 3.1: Terminal output highlighting wasted resources flagged for deletion.*

### 2. Subscription Governance Success
Successful deployment of the Bicep template enforcing the auto-tagging policy across the entire subscription.
![Policy Success](./images/Evidence_2_Governance_Policy.png)
*Figure 3.2: Successful Bicep deployment of subscription-wide policies.*

---

## 🚀 How to Deploy & Verify

1. **Deploy the Identity & Auto-Tagging Policy:**
   ```powershell
   # Deploy Managed Identity
   az deployment group create --resource-group "rg-epiq-test" --template-file "./infra/identity.bicep"
   
   # Deploy Subscription-Level Policy
   az deployment sub create --location "southeastasia" --template-file "./infra/policy.bicep"


 2. **Execute the FinOps Audit:** 
    .\scripts\Find-OrphanResources.ps1

    END 

    # ⚖️ Project 4: The "Secure Legal Bundle" Pipeline (Capstone)

## 📖 Executive Summary
Designed for the specific requirements of Tier-1 Legal and Government clients (e.g., **TBC**), this capstone mimics core eDiscovery operations: Document Review and Evidence Processing. This pipeline calculates the SHA-256 hash of court transcripts prior to uploading them into a **WORM (Write Once, Read Many)** Azure Blob container. This guarantees absolute data integrity and prevents file tampering for the duration of a legal hold.

## 🛠️ Tech Stack
* **Storage Vault:** Azure Blob Storage (Immutable Containers)
* **Infrastructure as Code:** Azure Bicep
* **Integrity Logic:** Python 3.x (SHA-256 Cryptography)
* **CI/CD:** Jenkins (Pipeline-as-Code)

## ✨ Key Capabilities & Tasks Executed
1. **Legal Integrity Verification:** Developed a Python script to calculate a cryptographic hash (Digital Seal) of files before they are ingested into the cloud.
2. **WORM Storage Deployment:** Engineered an immutable storage container locked with a "Time-based Retention Policy" (1-day retention at the Version scope) to prevent any deletion or modification.
3. **CI/CD Pipeline Integration:** Authored a declarative `Jenkinsfile` that orchestrates the integrity checks and deployment, ready to be plugged into a client's existing Jenkins infrastructure.

## 🖼️ Deployment Evidence

### 1. Legal Integrity Verification
![Integrity Hash](./images/Evidence_1_Integrity_Hash.png)
*Figure 4.1: Python integrity tool calculating the SHA-256 "Digital Seal" for a court transcript.*

### 2. WORM Storage Policy Enforcement
![Immutable Policy](./images/Evidence%202%20Immutable%20Policy%20Portal.png)
*Figure 4.2: Azure Portal verification showing the Immutability policy successfully locked on the legal bundle container.*

---

## 🚀 How to Deploy & Verify

### 1. Provision the Legal Vault
```powershell
az deployment group create --resource-group "rg-epiq-test" --template-file "./infra/storage.bicep"

##2. Generate Transcript & Verify Integrity
     # Run the Python Hash script
python ./scripts/verify_integrity.py "./scripts/Transcript_001.txt"

🤖 CI/CD Integration (Jenkins)
This project includes a declarative Jenkinsfile located in the root. To run this pipeline in a managed environment:

Create a new Pipeline item in Jenkins.

Under Pipeline Definition, select "Pipeline script from SCM."

Point to this repository and execute the path: Project-4-LegalBundle/Jenkinsfile.

Author: Muhamed Imraan (Roger)
© 2026 Muhamed Imraan. All Rights Reserved.
