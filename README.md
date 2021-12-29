## Proxmox Scripts

Inspired by [tteck's Proxmox helper scripts](https://github.com/tteck/Proxmox)


<details>
<summary markdown="span">Jellyfin Server LXC</summary>
 
<p align="center"><img src="https://jellyfin.org/images/banner-dark.svg" height="80"/></p>

<h1 align="center" id="heading"> Jellyfin Server LXC </h1>

To create a new Proxmox Jellyfin Server LXC, run the following in the Proxmox web shell.

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/jellyfin_container.sh)"
```
<h3 align="center" id="heading">⚡ Default Settings:  2GB RAM - 8GB Storage - 2vCPU ⚡</h3>

After the script completes, If you're dissatisfied with the default settings, click on the LXC, then on the **_Resources_** tab and change the **_Memory_**, **_Cores_** and **_Root Disk_** (Resize disk) settings to what you desire. Changes are immediate.

**Jellyfin Server Interface - IP:8096**

____________________________________________________________________________________________ 

</details>

<details>
<summary markdown="span">Emby Server LXC</summary>
 
<p align="center"><img src="https://emby.media/resources/logowhite_1881.png" height="80"/></p>

<h1 align="center" id="heading"> Emby Server LXC </h1>

To create a new Proxmox Emby Server LXC, run the following in the Proxmox web shell.

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/emby_container.sh)"
```
<h3 align="center" id="heading">⚡ Default Settings:  2GB RAM - 8GB Storage - 2vCPU ⚡</h3>

After the script completes, If you're dissatisfied with the default settings, click on the LXC, then on the **_Resources_** tab and change the **_Memory_**, **_Cores_** and **_Root Disk_** (Resize disk) settings to what you desire. Changes are immediate.

**Emby Server Interface - IP:8096**

____________________________________________________________________________________________ 

</details>
