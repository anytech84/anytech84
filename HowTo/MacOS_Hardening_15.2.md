# 1. Updates, Patches, and Additional Security Software
## 1.1 Ensure All-Apple-Provided Software is Current
  - ID : 1001
  - Level : 1
  - Assessment Status : Automated
  - Method : `softwareupdate`
  ---
  - Audit :
  ```bash
  softwareupdate -l
  ```
  - Remediation :
  ```bash
  softwareupdate -i -a
  ```
## 1.2 Ensure Auto Update is Enabled
  - ID : 1002
  - Level : 1
  - Assessment Status : Automated
  - Method : `defaults`
  ---
  - Audit :
  ```bash
  # TODO
  ```
  - Remediation :
  ```bash
  # TODO
  ```
## 1.3 Ensure Download New Updates When Available is Enabled
  - ID : 1003
  - Level : 1
  - Assessment Status : Automated
  - Method : `defaults`
  ---
  - Audit :
  ```bash
  defaults read /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload
  ```
  - Remediation :
  ```bash
  defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool true
  ```
## 1.4 Ensure Install of macOS Updates is Enabled
  - ID : 1004
  - Level : 1
  - Assessment Status : Automated
  - Method : `defaults`
  ---
  - Audit :
  ```bash
  defaults read /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticallyInstallMacOSUpdates
  ```
  - Remediation :
  ```bash
  defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticallyInstallMacOSUpdates -bool true
  ```
## 1.5 Ensure Install Application Updates from the App Store Is Enabled
  - ID : 1005
  - Level : 1
  - Assessment Status : Automated
  - Method : `defaults`
  ---
  - Audit :
  ```bash
  defaults read /Library/Preferences/com.apple.commerce.plist AutoUpdate
  ```
  - Remediation :
  ```bash
  defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool true
  ```
## 1.6 Ensure Install Security Responses and System Files Is Enabled
  - ID : 1006
  - Level : 1
  - Assessment Status : Automated
  - Method : `defaults`
  ---
  - Audit :
  ```bash
  defaults read /Library/Preferences/com.apple.SoftwareUpdate.plist ConfigDataInstall
  defaults read /Library/Preferences/com.apple.SoftwareUpdate.plist CriticalUpdateInstall
  ```
  - Remediation :
  ```bash
  defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist ConfigDataInstall -bool true
  defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist CriticalUpdateInstall -bool true
  ```
## 1.7 Ensure Software Update Deferment Is Less Than or Equal to 30 Days
  - ID : 1007
  - Level : 1
  - Assessment Status : Automated
  - Method : Configuration Profile 
  ---
  - Remediation : `com.apple.applicationaccess`, `enforceDelayedSoftwareUpdates`, `<integer><1-30></integer>`
## 1.8 Ensure the System is Managed by a Mobile Device Management (MDM) Software
  - ID : 1008
  - Level : 1
  - Assessment Status : Automated
  - Method : Configuration Profile
# 2. System Settings
## 2.1 Apple Account
### 2.1.1 iCloud
#### 2.1.1.1 Audit iCloud Keychain
  - ID : 2111
  - Level : 2
  - Assessment Status : Manual
  - Method : Configuration Profile
  ---
  - Audit :
  ```bash
  defaults read ~/Library/Preferences/MobileMeAccounts | grep KEYCHAINSYNC -B 1
  ```
  - Remediation : `com.apple.applicationaccess`, `allowCloudKeychainSync`, `<true|false/>`
#### 2.1.1.2 Audit iCloud Drive
  - ID : 2112
  - Level : 2
  - Assessment Status : Manual
  - Method : Configuration Profile
  ---
  - Audit :
  ```bash
  defaults read ~/Library/Preferences/MobileMeAccounts | grep MOBILE_DOCUMENTS -B 1
  ```
  - Remediation : `com.apple.applicationaccess`, `allowCloudDocumentSync`, `<true|false/>`
#### 2.1.1.3 Ensure iCloud Drive Document and Desktop Sync Is Disabled
  - ID : 2113
  - Level : 2
  - Assessment Status : Automated
  - Method : Configuration Profile
  ---
  - Audit :
  ```bash
  ls -l ~/Library/Mobile\ Documents/com~apple~CloudDocs/ | grep total
  ```
  - Remediation : `com.apple.applicationaccess`, `allowCloudDesktopAndDocuments`, `<false/>`
#### 2.1.1.4 Audit Security Keys Used With Apple Accounts
  - ID : 2114
  - Level : 2
  - Assessment Status : Manual
  - Method : System Settings
  ---
  - Audit : `System Preferences` -> `Apple ID` -> `Sign-In & Security` -> `Two Factor Authentification` -> `Security Keys`
#### 2.1.1.5 Audit Freeform Sync to iCloud
  - ID : 2115
  - Level : 2
  - Assessment Status : Manual
  - Method : Configuration Profile
  ---
  - Audit :
  ```bash
  defaults read ~/Library/Preferences/MobileMeAccounts | grep FREEFORM -B 1
  ```
  - Remediation : `com.apple.applicationaccess`, `allowCloudFreeformSync`, `<true|false/>`
#### 2.1.1.6 Audit Find My Mac
  - ID : 2116
  - Level : 2
  - Assessment Status : Manual
  - Method : System Settings
  ---
  - Audit : `System Preferences` -> `iCloud` -> `See All` -> `Find My Mac`
### 2.1.2 Audit App Store Password Settings
  - ID : 2120
  - Level : 2
  - Assessment Status : Manual
  - Method : System Settings
  ---
  - Audit : `System Preferences` -> `Apple ID` -> `Media & Purchases`
## 2.2 Network
### 2.2.1 Ensure Firewall Is Enabled
  - ID : 2210
  - Level : 1
  - Assessment Status : Automated
  - Method : `socketfilterfw`
  ---
  - Audit :
  ```bash
  /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate
  ```
  - Remediation :
  ```bash
  /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
  ```
### 2.2.2 Ensure Firewall Stealth Mode Is Enabled
  - ID : 2220
  - Level : 1
  - Assessment Status : Automated
  - Method : `socketfilterfw`
  ---
  - Audit :
  ```bash
  /usr/libexec/ApplicationFirewall/socketfilterfw --getstealthmode
  ```
  - Remediation :
  ```bash
  /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
  ```
## 2.3 General
### 2.3.1 AirDrop & Handoff
#### 2.3.1.1 Ensure AirDrop Is Disabled When Not Actively Transferring Files
  - ID : 2311
  - Level : 1
  - Method : Configuration Profile
  - Assessment Status : Automated
  - Remediation : `com.apple.applicationaccess`, `allowAirDrop`, `<false/>`
#### 2.3.1.2 Ensure AirPlay Receiver Is Disabled
  - ID : 2312
  - Level : 1
  - Method : Configuration Profile
  - Assessment Status : Automated
  - Remediation : `com.apple.applicationaccess`, `allowAirPlayIncomingRequests`, `<false/>`
### 2.3.2 Date & Time
#### 2.3.2.1 Ensure Set Time and Date Automatically Is Enabled
  - ID : 2321
  - Level : 1
  - Method : `systemsetup`
  - Assessment Status : Automated
  - Audit :
  ```bash
  sudo systemsetup -getusingnetworktime
  ```
  - Remediation :
  ```bash
  sudo systemsetup -setusingnetworktime on
  ```
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.3.2.2 Ensure the Time Service Is Enabled
  - ID : 2322
  - Level : 1
  - Method : `systemsetup`
  - Assessment Status : Automated
  - Audit :
  ```bash
  sudo systemsetup -getnetworktimeserver
  ```
### 2.3.3 Sharing
#### 2.3.3.1 Ensure DVD or CD Sharing Is Disabled
  - ID : 2331
  - Level : 1
  - Assessment Status : Automated
  - Method : `launchctl`
  - Audit :
  ```bash
  launchctl list | grep -c ODSAgent
  ```
  - Remediation :
  ```bash
  sudo launchctl disable system/com.apple.ODSAgent
  sudo launchctl bootout system/com.apple.ODSAgent
  ```
#### 2.3.3.2 Ensure Screen Sharing Is Disabled (Automated)
  - ID : 2332
  - Level : 1
  - Assessment Status : Automated
  - Method : `launchctl` 
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.3.3.3 Ensure File Sharing Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.3.3.4 Ensure Printer Sharing Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.3.3.5 Ensure Remote Login Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.3.3.6 Ensure Remote Management Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.3.3.7 Ensure Remote Apple Events Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.3.3.8 Ensure Internet Sharing Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.3.3.9 Ensure Content Caching Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.3.3.10 Ensure Media Sharing Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.3.3.11 Ensure Bluetooth Sharing Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.3.3.12 Ensure Computer Name Does Not Contain PII or Protected Organizational Information (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.3.4 Time Machine
#### 2.3.4.1 Ensure Backup Automatically is Enabled If Time Machine Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.3.4.2 Ensure Time Machine Volumes Are Encrypted If Time Machine Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 2.4 Control Center
### 2.4.1 Ensure Show Wi-Fi status in Menu Bar Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.4.2 Ensure Show Bluetooth Status in Menu Bar Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 2.5 Siri
### 2.5.1 Audit Siri Settings (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.5.2 Ensure Listen for (Siri) Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 2.6 Privacy & Security
### 2.6.1 Location Services
#### 2.6.1.1 Ensure Location Services Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.6.1.2 Ensure 'Show Location Icon in Control Center when System Services Request Your Location' Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.6.1.3 Audit Location Services Access (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.6.2 Full Disk Access
#### 2.6.2.1 Audit Full Disk Access for Applications (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.6.3 Analytics & Improvements
#### 2.6.3.1 Ensure Share Mac Analytics Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.6.3.2 Ensure Improve Siri & Dictation Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.6.3.3 Ensure Improve Assistive Voice Features Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.6.3.4 Ensure 'Share with app developers' Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.6.3.5 Ensure Share iCloud Analytics Is Disabled (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.6.4 Ensure Limit Ad Tracking Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.6.5 Ensure Gatekeeper Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.6.6 Ensure FileVault Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.6.7 Audit Lockdown Mode (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.6.8 Ensure an Administrator Password Is Required to Access System-Wide Preferences (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 2.7 Desktop & Dock
### 2.7.1 Ensure Screen Saver Corners Are Secure (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.7.2 Audit iPhone Mirroring (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 2.8 Displays
### 2.8.1 Audit Universal Control Settings (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 2.9 Battery (Energy Saver)
### 2.9.1 OS Resuming From Sleep
#### 2.9.1.1 Ensure the OS Is Not Active When Resuming from Standby (Intel) (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
#### 2.9.1.2 Ensure Sleep and Display Sleep Is Enabled on Apple Silicon Devices (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.9.2 Ensure Power Nap Is Disabled for Intel Macs (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.9.3 Ensure Wake for Network Access Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 2.10 Lock Screen
### 2.10.1 Ensure an Inactivity Interval of 20 Minutes Or Less for the Screen Saver Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.10.2 Ensure Require Password After Screen Saver Begins or Display Is Turned Off Is Enabled for 5 Seconds or Immediately (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.10.3 Ensure a Custom Message for the Login Screen Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.10.4 Ensure Login Window Displays as Name and Password Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.10.5 Ensure Show Password Hints Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 2.11 Touch ID & Password (Login Password)
### 2.11.1 Ensure Users' Accounts Do Not Have a Password Hint (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.11.2 Audit Touch ID (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
##  2.12 Users & Groups
### 2.12.1 Ensure Guest Account Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.12.2 Ensure Guest Access to Shared Folders Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 2.12.3 Ensure Automatic Login Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 2.13 Passwords
### 2.13.1 Audit Passwords System Preference Setting (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 2.14 Game Center
### 2.14.1 Audit Game Center Settings (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 2.15 Notifications 
### 2.15.1 Audit Notification & Focus Settings (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 2.16 Wallet & Apple Pay
### 2.16.1 Audit Wallet & Apple Pay Settings (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 2.17 Internet Accounts
### 2.17.1 Audit Internet Accounts for Authorized Use (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 2.18 Keyboard
### 2.18.1 Ensure On-Device Dictation Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
# 3. Logging and Auditing
## 3.1 Ensure Security Auditing Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 3.2 Ensure Security Auditing Flags For User-Attributable Events Are Configured Per Local Organizational Requirements (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 3.3 Ensure install.log Is Retained for 365 or More Days and No Maximum Size (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 3.4 Ensure Security Auditing Retention Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 3.5 Ensure Access to Audit Records Is Controlled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 3.6 Audit Software Inventory (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
# 4. Network Configurations
## 4.1 Ensure Bonjour Advertising Services Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 4.2 Ensure HTTP Server Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 4.3 Ensure NFS Server Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
# 5. System Access, Authentication and Authorization
## 5.1 File System Permissions and Access Controls
### 5.1.1 Ensure Home Folders Are Secure (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 5.1.2 Ensure System Integrity Protection Status (SIP) Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 5.1.3 Ensure Apple Mobile File Integrity (AMFI) Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 5.1.4 Ensure Signed System Volume (SSV) Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 5.1.5 Ensure Appropriate Permissions Are Enabled for System Wide Applications (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 5.1.6 Ensure No World Writable Folders Exist in the System Folder (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 5.1.7 Ensure No World Writable Folders Exist in the Library Folder (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 5.2 Password Management
### 5.2.1 Ensure Password Account Lockout Threshold Is Configured (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 5.2.2 Ensure Password Minimum Length Is Configured (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 5.2.3 Ensure Complex Password Must Contain Alphabetic Characters Is Configured (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 5.2.4 Ensure Complex Password Must Contain Numeric Character Is Configured (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 5.2.5 Ensure Complex Password Must Contain Special Character Is Configured (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 5.2.6 Ensure Complex Password Must Contain Uppercase and Lowercase Characters Is Configured (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 5.2.7 Ensure Password Age Is Configured (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 5.2.8 Ensure Password History Is Configured (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 5.3 Encryption
### 5.3.1 Ensure all user storage APFS volumes are encrypted (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 5.3.2 Ensure all user storage CoreStorage volumes are encrypted (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 5.4 Ensure the Sudo Timeout Period Is Set to Zero (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 5.5 Ensure a Separate Timestamp Is Enabled for Each User/tty Combo (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 5.6 Ensure the "root" Account Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 5.7 Ensure an Administrator Account Cannot Login to Another User's Active and Locked Session (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 5.8 Ensure a Login Window Banner Exists (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 5.9 Ensure the Guest Home Folder Does Not Exist (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 5.10 Ensure XProtect Is Running and Updated (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 5.11 Ensure Logging Is Enabled for Sudo (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
# 6. Applications
## 6.1 Finder
### 6.1.1 Ensure Show All Filename Extensions Setting is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 6.2 Mail
### 6.2.1 Ensure Protect Mail Activity in Mail Is Enabled (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 6.3 Safari
### 6.3.1 Ensure Automatic Opening of Safe Files in Safari Is Disabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 6.3.2 Audit History and Remove History Items (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 6.3.3 Ensure Warn When Visiting A Fraudulent Website in Safari Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 6.3.4 Ensure Prevent Cross-site Tracking in Safari Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 6.3.5 Audit Hide IP Address in Safari Setting (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 6.3.6 Ensure Advertising Privacy Protection in Safari Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 6.3.7 Ensure Show Full Website Address in Safari Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 6.3.8 Audit AutoFill (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 6.3.9 Audit Pop-up Windows (Manual)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
### 6.3.10 Ensure Show Status Bar Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
## 6.4 Terminal
### 6.4.1 Ensure Secure Keyboard Entry Terminal.app Is Enabled (Automated)
  - ID :
  - Level :
  - Method :
  - Assessment Status :
  - Audit :
  - Remediation :
  - DefaultValue :
  - RecommendedValue :
  - TypeValue :
