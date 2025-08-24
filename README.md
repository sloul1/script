# Script

Scripts for system administration and automating various things.


> [!TIP] 
> This repository can be downloaded fully using `git`
```sh
git clone https://github.com/sloul1/script.git
```

> [!CAUTION] 
> Always CHECK and UNDERSTAND functions of THE SCRIPT files before running them on your system!

To download a single script from this repo (*or any file from any repo in GitHub*) using Linux shell:
1. Click preferred script in Github.
2. Copy the link address from 'Raw' box by clicking it with right button of the mouse (or touchpad) and choose 'Copy Link'.
![](images/github-copy-raw-link.webp) 

3. `Ctrl + Alt + T` key combination is a shortcut for opening `terminal` in Ubuntu and many other Linux distributions.

4. You can use `wget` or `cURL` for downloading the script by pasting the copied link after chosen command for downloading.
```sh
wget https://github.com/sloul1/script/raw/refs/heads/main/updates.sh
```
```sh
curl -LJO https://github.com/sloul1/script/raw/refs/heads/main/updates.sh
```

5. Make .sh files are excutable before trying to run them:
```sh
chmod +x updates.sh
```

If the commands in the script aren't created with `sudo` you might need to run the script as super user:
```sh
sudo ./updates.sh
```
