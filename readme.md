# Sia torrent

Setup documentation for seeding torrents from Sia decentralized blockchain cloudstorage.

Requirements:
- Ubuntu 15.04+ with root access
- 20+ GB disk (syncing Sia take some days on HDD, some hours on SSD)
- 200+ Siacoin (4000 recommended for a TB)

### Table of contents

* [Install Sia](#install-sia)
* [Setup repertory](#setup-repertory-and-service)
* [Install qBittorrent-nox](#install-qBittorrent-nox)

# Install Sia

You can install Sia-UI if you have graphical interface ([read the Sia renter guide here](https://siasetup.info/guides/renting_on_sia)), but since this guide focuses on servers that normally don't have a desktop user interface, we will Sia daemon.

[Download the most recent version here](https://github.com/NebulousLabs/Sia/releases), and unzip the archive to a new "sia" folder. `siad` is the daemon, and `siac` is the user interface for this, so you need to enable executing:

``` bash
chmod +x /home/USER/sia/siad
chmod +x /home/USER/sia/siac

# Test:
./sia/siac
```

Of cource, it shows an error, because you didn't started `siad`. Before starting it, we'll create a service for this. Create a file, and paste the contents of `services/siad.service` into it (of yource, change every USER to your username).

`sudo nano /etc/systemd/system/siad.service`

Then reload the service daemon, start & enable siad:

``` bash
sudo systemctl daemon-reload
sudo systemctl start siad

# Enable siad auto start when your PC started:
sudo systemctl enable siad

# Check status of siad:
sudo systemctl status siad
```

Cool, now you can check is Sia synced:

`~/sia/siac consensus`

Syncing takes some days on HDDs, and some hours on SSDs, so be patient. You can download the bootstrapped blockchain from online sources, that should make the progress faster.

But wait, typing `./sia/siac` is ugly, so let's add siac to the PATH:

`ln -s ~/sia/siac ~/.local/bin/siac`

It creates a nymbolic link and adds the `siac` command to your user path. Note, only for the current user, so it's not a global path variable. Test:

`siac`

> If not works, try to open a new terminal/screen.

Initialize wallet:

`siac wallet init`

> Copy down the seed to a safe location! You will need this to unlock your wallet.

Unlock your wallet:

`siac wallet unlock`
 
 and then paste your seed. It could take some seconds.

> If your balance is too low, generate a new address with `siac wallet address`, and send some funds to it.

You need to buy storage on Sia, so type `siac renter setallowance`, and follow the instructions. After the contracts are formed (10-20 minutes), you can start uploading.

Check how many contracts you have (recommended: 50, you need 30+ for upload):

`siac renter`

Check your allowance:

`siac renter allowance`

Show alerts:

`siac alerts`

# Setup repertory and service

[Repertory](https://bitbucket.org/blockstorage/repertory/) allows you to mount Sia storage via FUSE, like a normal forder in your system. [Download the latest release from BitBucket](https://bitbucket.org/blockstorage/repertory/downloads/), and place it to your main folder (/home/USER). Also place here the `repertory_service.sh` file from this repo, but make sure you modified all "USER" to your current username.

You can create a service for repertory (which calls repertory_service.sh on startup):

`sudo nano /etc/systemd/system/repertory.service`

and then paste "service/repertory.service" from this repo (change the four USER string to your username again). 

Reload services, start & enable repertory:

``` bash
sudo systemctl daemon-reload
sudo systemctl start repertory
sudo systemctl enable repertory
```

Now repertory mounted your Sia drive to /home/USER/siadrive, so you can `cd siadrive` and create some files. If succeed, check the new file listed `siac renter ls -v`.

# Install qBittorrent-nox

``` bash
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
sudo apt-get update && sudo apt-get install qbittorrent-nox
```