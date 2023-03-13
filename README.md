# garlicos-updater

this project is used for updating Anbernic [RG35XX](https://anbernic.com/fr/products/rg35xx) powered by [GarlicOS](https://www.patreon.com/posts/76561333) with the latest version. It also copies the `saves` dir on your computer.

**=> There is no warranty of operation without errors. At your own risks. <=**

## Prerequisite
1. Enable adb on your device by creating a file named `enableADB` on the misc mount point
2. edit `garlicos-updater.cfg` 

| Variable             | Description                                                                                                    |
|----------------------|----------------------------------------------------------------------------------------------------------------|
| garlicOsDownloadPath | latest download link ([here](https://www.patreon.com/posts/76561333), named `RG35XX-CopyPasteOnTopOfStock.7z`) |
| adbDeviceId          | adb device id                                                                                                  |
| extSaveDir           | local dir where to save `saves` from ext                                                                       |

## How to
1. power on your device
2. connect your device on the computer
3. Launch `garlicos-updater.sh`