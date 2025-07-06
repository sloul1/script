# Script

Scripts for system administration and automating various things.

> [!CAUTION] 
> Always CHECK and UNDERSTAND functions of THE SCRIPT files before running them on your system!

To download script using Linux shell click preferred script in Github and copy link address from "Raw" box.
![](images/github-copy-raw-link.webp)

You can use wget for downloading script.
```shell
wget https://github.com/sloul1/script/raw/main/updates.sh
```

Make .sh files are excutable before trying to run them:
```shell
chmod +x updates.sh
```

If the commands in the script aren't created with `sudo` you might need to run the script as super user:
```shell
sudo ./updates.sh
```
