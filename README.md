## Proxmox Scripts

Inspired by and based on [tteck's Proxmox helper scripts](https://github.com/tteck/Proxmox)

Scripts for Proxmox VE and Proxmox BS.

- Proxmox VE = [Proxmox Virtual Environment](https://proxmox.com/en/proxmox-ve)
- Proxmox BS = [Proxmox Backup Server](https://proxmox.com/en/proxmox-backup-server)

<details>
<summary markdown="span">Proxmox VE 7 Post Install</summary>

<h1 align="center" id="heading"> Proxmox VE 7 Post Install </h1>

This script will Disable the Enterprise Repo, Add & Enable the No-Subscription Repo and attempt the *No-Nag* fix. 
 
Run the following in the Proxmox Web Shell.

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/pve7_post_install.sh)"
```

It's recommended to update Proxmox **after** running this script, **before** adding any VM/CT.

____________________________________________________________________________________________ 

</details>

<details>
<summary markdown="span">Proxmox BS 2 Post Install</summary>

<h1 align="center" id="heading"> Proxmox BS 2 Post Install </h1>

This script will Disable the Enterprise Repo and Add & Enable the No-Subscription Repo. 
 
Run the following in the Proxmox Web Shell.

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/pbs2_post_install.sh)"
```

____________________________________________________________________________________________ 

</details>

<details>
<summary markdown="span">Home Assistant OS VM</summary> 
 
<h1 align="center" id="heading"> Home Assistant OS VM </h1>

To create a new Proxmox VM with the latest version of Home Assistant OS, run the following from Proxmox web shell

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/haos_vm.sh)"
```

<h3 align="center" id="heading">Default Settings:  4GB RAM - 32GB Storage - 2vCPU</h3>
 
After the script completes, If you're dissatisfied with the default settings, click on the VM, then on the **_Hardware_** tab and change the **_Memory_** and **_Processors_** settings to what you desire. Once all changes have been made, **_Start_** the VM.

**Home Assistant Interface - IP:8123**

____________________________________________________________________________________________ 
 
</details>

<details>
<summary markdown="span">Pi-hole LXC</summary>
 
<h1 align="center" id="heading"> Pi-hole LXC </h1>

To create a new Proxmox Pi-hole LXC, run the following in the Proxmox web shell.

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/pihole_container.sh)"
```
<h3 align="center" id="heading">Default Settings: 512MiB RAM - 4GB Storage - 1vCPU</h3>
 
**Change Pi-hole password:**
 
Run from the LXC console

```
pihole -a -p
```

____________________________________________________________________________________________ 

</details>

<details>
<summary markdown="span">Pi-hole with cloudflared LXC</summary>
 
<h1 align="center" id="heading"> Pi-hole with cloudflared LXC </h1>

**Please note:** I don't want discussions about cloudflared in the Issues.

To create a new Proxmox Pi-hole with cloudflared LXC, run the following in the Proxmox web shell.

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/pihole_cloudflared_container.sh)"
```
<h3 align="center" id="heading">Default Settings: 1024MiB RAM - 4GB Storage - 1vCPU</h3>
 
**Change Pi-hole password:**
 
Run from the LXC console

```
pihole -a -p
```

You must configure Pi-hole to use the local cloudflared service as the upstream DNS server by specifying "127.0.0.1#5053" as the "Custom DNS 1 (IPv4)". 

____________________________________________________________________________________________ 

</details>

<details>
<summary markdown="span">Emby Server LXC</summary>

<h1 align="center" id="heading"> Emby Server LXC </h1>

To create a new Emby Server LXC, run the following in the Proxmox web shell.

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/emby_container.sh)"
```
<h3 align="center" id="heading">Default Settings:  2GB RAM - 8GB Storage - 2vCPU</h3>

After the script completes, If you're dissatisfied with the default settings, click on the LXC, then on the **_Resources_** tab and change the **_Memory_**, **_Cores_** and **_Root Disk_** (Resize disk) settings to what you desire. Changes are immediate.

**Emby Server Interface - IP:8096**

____________________________________________________________________________________________ 

</details>

<details>
<summary markdown="span">Jellyfin Server LXC</summary>
 
<h1 align="center" id="heading"> Jellyfin Server LXC </h1>

To create a new Jellyfin Server LXC, run the following in the Proxmox web shell.

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/jellyfin_container.sh)"
```
<h3 align="center" id="heading">Default Settings:  2GB RAM - 8GB Storage - 2vCPU</h3>

After the script completes, If you're dissatisfied with the default settings, click on the LXC, then on the **_Resources_** tab and change the **_Memory_**, **_Cores_** and **_Root Disk_** (Resize disk) settings to what you desire. Changes are immediate.

**Jellyfin Server Interface - IP:8096**

____________________________________________________________________________________________ 

</details>

<details>
<summary markdown="span">Tvheadend Server LXC</summary>
 
<h1 align="center" id="heading"> Tvheadend Server LXC </h1>

To create a new Tvheadend Server LXC, run the following in the Proxmox web shell.

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/tvheadend_container.sh)"
```
<h3 align="center" id="heading">Default Settings:  2GB RAM - 8GB Storage - 2vCPU</h3>

After the script completes, If you're dissatisfied with the default settings, click on the LXC, then on the **_Resources_** tab and change the **_Memory_**, **_Cores_** and **_Root Disk_** (Resize disk) settings to what you desire. Changes are immediate.

**You must setup Tvheadend in LXC console first**

Run from the LXC console and follow the instructions:

```
dpkg-reconfigure tvheadend
```

**Tvheadend Server Interface - IP:9981**

____________________________________________________________________________________________ 

</details>

<details>
<summary markdown="span">jdownloader2 Server LXC</summary>

<h1 align="center" id="heading"> jdownloader2 Server LXC </h1>

To create a new Jellyfin Server LXC, run the following in the Proxmox web shell.

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/jdownloader2_container.sh)"
```
<h3 align="center" id="heading">Default Settings:  2GB RAM - 32GB Storage - 2vCPU</h3>

After the script completes, If you're dissatisfied with the default settings, click on the LXC, then on the **_Resources_** tab and change the **_Memory_**, **_Cores_** and **_Root Disk_** (Resize disk) settings to what you desire. Changes are immediate.

**You must setup jdownloader2 in LXC console first**

Run from the LXC console and follow the instructions:

```
sudo -u jdown2 java -jar /opt/jdown2/JDownloader.jar -norestart
```

____________________________________________________________________________________________

</details>
