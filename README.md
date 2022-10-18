# Matt's rice void (Built from Randi's)

Install [debian os](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/)
I used debian 11 version (code name "bullseye")

---

My setup is install debian minimal without GUI and used expert method.

```bash
$ sudo apt install git

$ git clone https://github.com/rendiwijiatmoko/debian-dwm

$ cd debian-dwm

$ ./install.sh
```

Finish the setup
```bash
$ sudo reboot
```
That's it.

## Installs

- File Manager: Ranger
- ls replaced with exa
- microcode (intel or amd)
- Display Manager: Ly Console Manager
- Window Manager: dwm
- Terminal: st
- Menu: dmenu
- Browser: Firefox 
- Image browser: feh or nitrogen
- neofetch 
- htop

## Add to this:

- Surf
- emacs
- wireguard
- joplin

### Include

- configs for dwm, surf, st, dmenu, autostart
