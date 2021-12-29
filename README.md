## Proxmox Scripts

Inspired by [tteck's Proxmox helper scripts](https://github.com/tteck/Proxmox)

Scripts for Proxmox VE and Proxmox BS.

- Proxmox VE = [Proxmox Virtual Environment](https://proxmox.com/en/proxmox-ve)
- Proxmox BS = [Proxmox Backup Server](https://proxmox.com/en/proxmox-backup-server)

**Note:** The LXC Contrainers are currently untested. But they should work. I'll test them soon.

<details>
<summary markdown="span">Proxmox VE 7 Post Install</summary>
 
<p align="center"><img src="https://www.proxmox.com/images/proxmox/Proxmox_logo_standard_hex_400px.png" alt="Proxmox Server Solutions" height="55"/></p>

<h1 align="center" id="heading"> Proxmox VE 7 Post Install </h1>

This script will Disable the Enterprise Repo, Add & Enable the No-Subscription Repo and attempt the *No-Nag* fix. 
 
Run the following in the Proxmox Web Shell. ⚠️ **PVE7 ONLY**

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/pve7_post_install.sh)"
```

It's recommended to update Proxmox **after** running this script, **before** adding any VM/CT.

____________________________________________________________________________________________ 

</details>

<details>
<summary markdown="span">Proxmox BS 2 Post Install</summary>
 
<p align="center"><img src="https://www.proxmox.com/images/proxmox/Proxmox_logo_standard_hex_400px.png" alt="Proxmox Server Solutions" height="55"/></p>

<h1 align="center" id="heading"> Proxmox BS 2 Post Install </h1>

This script will Disable the Enterprise Repo and Add & Enable the No-Subscription Repo. 
 
Run the following in the Proxmox Web Shell. ⚠️ **PBS2 ONLY**

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/pbs2_post_install.sh)"
```

____________________________________________________________________________________________ 

</details>

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

<details>
<summary markdown="span">PostgreSQL (**without** pgadmin4) LXC</summary>
 
<p align="center"><img src="https://www.postgresql.org/media/img/about/press/elephant.png" alt="PostgreSQL"/></p>


<h1 align="center" id="heading"> Proxmox PostgreSQL (**without** pgadmin4) LXC Container </h1>

To create a new Proxmox PostgreSQL (**without** pgadmin4) LXC Container, run the following in the Proxmox web shell.

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/postgresql_container.sh)"
```
<h3 align="center" id="heading">⚡ Default Settings:  1GB RAM - 4GB Storage - 1vCPU ⚡</h3>

To enable PostgreSQL to listen to remote connections, you need to edit the configuration file. To do this, open the console in your PostgreSQL LXC:
```
nano /etc/postgresql/14/main/postgresql.conf
```
Chnage `listen_addresses='localhost'` to `listen_addresses='*'`
Save and exit the editor with "Ctrl+O", "Enter" and "Ctrl+X".

Restart PostgreSQL with
```
sudo systemctl restart postgresql 
```


Change password of `postgres` user:
```
sudo -u postgres psql

\password postgres

\q
```

Create a new user (e.g. for Nextcloud):
```
sudo -u postgres createuser -P -d nextcloud
```

Create a new databse (e.g. for Nextcloud):
```
sudo -u postgres createdb -O nextcloud nextcloud_db
```
This create the database `nextcloud_db` and set the ownership to the user `nextcloud`

____________________________________________________________________________________________ 

</details>

<details>
<summary markdown="span">PostgreSQL (**with** pgadmin4) LXC</summary>
 
<p align="center"><img src="https://www.postgresql.org/media/img/about/press/elephant.png" alt="PostgreSQL"/></p>


<h1 align="center" id="heading"> Proxmox PostgreSQL (**with** pgadmin4) LXC Container </h1>

To create a new Proxmox PostgreSQL (**with** pgadmin4) LXC Container, run the following in the Proxmox web shell.

```
bash -c "$(wget -qLO - https://raw.githubusercontent.com/StevenSeifried/proxmox-scripts/main/postgresql_pgadmin4_container.sh)"
```
<h3 align="center" id="heading">⚡ Default Settings:  2GB RAM - 8GB Storage - 2vCPU ⚡</h3>

To enable PostgreSQL to listen to remote connections, you need to edit the configuration file. To do this, open the console in your PostgreSQL LXC:
```
nano /etc/postgresql/14/main/postgresql.conf
```
Chnage `listen_addresses='localhost'` to `listen_addresses='*'`
Save and exit the editor with "Ctrl+O", "Enter" and "Ctrl+X".

Restart PostgreSQL with
```
sudo systemctl restart postgresql 
```


Change password of `postgres` user:
```
sudo -u postgres psql

\password postgres

\q
```

Create a new user (e.g. for Nextcloud):
```
sudo -u postgres createuser -P -d nextcloud
```

Create a new databse (e.g. for Nextcloud):
```
sudo -u postgres createdb -O nextcloud nextcloud_db
```
This create the database `nextcloud_db` and set the ownership to the user `nextcloud`.

To setup pgadmin4, open the console in your PostgreSQL LXC and run the following command:

```
/usr/pgadmin4/bin/setup-web.sh
```
Follow the instructions
____________________________________________________________________________________________ 

</details>
