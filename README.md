# GarlicOS Updater

this project is used for updating Anbernic [RG35XX](https://anbernic.com/fr/products/rg35xx) powered by [GarlicOS](https://www.patreon.com/posts/76561333) with the latest version. It also copies the `saves` dir on your computer.

**=> There is no warranty of operation without errors. At your own risks. <=**


For launching the update, please follow these steps :
1. edit `variables.sh` 

| Variable | Description |
| --- | --- |
| garlicOsDownloadPath | latest download link ([here](https://www.patreon.com/posts/76561333), named `RG35XX-CopyPasteOnTopOfStock.7z`)|
| workingDir | local working dir |
| intMiscDir | Int SD card : `misc` mount point
| intRomsDir | Int SD card : `roms` mount point
| extRomsDir | Ext SD card : `roms` mount point
| extSaveDir | local dir where to save `saves`
2. Insert Int SD card
3. Launch `01_update_int.sh`
4. unmount and eject Int SD card
5. Insert Ext SD card
6. Lauch `02_update_ext.sh`
7. unmount and eject Ext SD card
