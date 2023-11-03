#!/bin/sh

ls /etc/wireguard/us-* |sort -R |tail -n 1 |while read file; do
    # Replace `doas` with `sudo` if your machine uses `sudo`,
    # or remove `doas` if users don't need to su to run wg-quick
    wg-quick up $file;
    printf "\nCreated Mullvad wireguard connection with file: $file";
    printf "\n\nPrinting new IP info:\n"
    curl https://am.i.mullvad.net/connected
done
