
# Backup for gnome settings

## To bring the backup up-to-date:
```bash
# settings:
dconf dump / > saved_settings.dconf

#extentions:
ls ~/.local/share/gnome-shell/extensions | awk -F '@' '{print $1}' > extensions
```


## To load the backup:
```bash
dconf load -f / < saved_settings.dconf
```
extentions need to be downloaded manually


