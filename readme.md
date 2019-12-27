# Sia torrent

Setup documentation for seeding torrents from Sia decentralized blockchain cloudstorage.

Requirements:
- Linux/Ubuntu with root access
- 20+ GB disk (syncing Sia take some days on HDD, some hours on SSD)
- 200+ Siacoin (4000 recommended for a TB)

### Table of contents

* [Install Sia](#install-sia)
* [Setup repertory](#setup-repertory)
* [Install qBittorrent-nox](#install-qBittorrent-nox)

# Install Sia

You can install Sia-UI if you have graphical interface: [read the Sia renter guide here](https://siasetup.info/guides/renting_on_sia), but I decided to use Sia daemon on my VPS, so here is the setup for that.

Download the most recent version here: https://github.com/NebulousLabs/Sia/releases.  Uncompress the archive to a new "sia" folder. `siad` is the daemon, and `siac` is the user interface for this, so you need to enable executing:
`chmod +x /home/USER/sia/siad`
`chmod +x /home/USER/sia/siac`
Test: `./sia/siac`

Of yource, it shows an error, because you didn't started `siad`. Before starting it, we'll create a service for this. Create a file, and paste the contents of `services/siad.service` into it (of yource, change every USER to your username).
`sudo nano /etc/systemd/system/siad.service`

Then reload the service daemon:
`sudo systemctl daemon-reload`

Now you can start siad:
`sudo systemctl start siad`

Check status of siad: 
`sudo systemctl status siad`

Enable siad to auto start when your PC started: 
`sudo systemctl enable siad`

Cool, now you can check is Sia synced:
`~/sia/siac consensus`

Syncing takes some days on HDDs, and some hours on SSDs, so be patient. You can download the bootstrapped blockchain from online sources, that should make the progress faster.

But wait, typing `./sia/siac` is fckn ugly, so let's add siac to the PATH:
`ln -s ~/sia/siac ~/.local/bin/siac`
It creates a nymbolic link and adds the `siac` command to your user path. Note, only for the current user, so it's not a global path variable. Test:
`siac`
If not works, try to open a new terminal/screen.

Cool, now you can check your balance:
`siac wallet`
If your wallet is locked, unlock with `siac wallet unlock`, and then paste your passphrase. It could take some seconds.
If your balance is too low, generate a new address with `siac wallet address`, and send some funds to it.

You need to buy storage on Sia, so type `siac renter setallowance`, and follow the instructions. After allowance formed (10-20 minutes), you can start uploading.

# Setup repertory