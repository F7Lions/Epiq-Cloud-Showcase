# Project 1: The IM8-Hardened "Digital Vault" 🛡️

## 📖 Executive Summary
In legal discovery, the integrity of **Electronically Stored Information (ESI)** is paramount. This project deploys a secure landing zone that eliminates public internet exposure, ensuring a forensic "Chain of Custody" for sensitive government and legal data.

## 🏗️ Technical Architecture
This overview illustrates the "Zero-Trust" bridge between the application layer and the hardened storage vault.

![Architecture Diagram](./images/architecture.png)

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
A CLI-based audit confirms all five critical components (VNet, NSG, KV, Storage, PE) are active in the Singapore region.

**Command**: `az resource list --resource-group rg-epiq-test --output table`

![Inventory Audit](./images/image2.png)
*Figure 3: Audited list of physical cloud resources and their deployment status.*

🛠️ How to Deploy
Clone this repository.

Navigate to ./Project-1-Landing-Zone.

Run the deployment script:

PowerShell
.\scripts\deploy.ps1


Author : Muhamed Imraan (Roger)
© 2026 Muhamed Imraan. All Rights Reserved.

