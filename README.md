# garlicos-updater

this project is used for updating Anbernic [RG35XX](https://anbernic.com/fr/products/rg35xx) powered
by [GarlicOS](https://www.patreon.com/posts/76561333) with the latest version.
It also copies the `saves` dir on your computer.
Int and Ext SD card are considered.

**=> There is no warranty of operation without errors. At your own risks. <=**

## Prerequisite

1. Enable adb on your device by creating a file named `enableADB` on the misc mount point
2. edit `garlicos-updater.cfg`

| Variable                 | Optional | Description                                                                                                                                                              |
|--------------------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| garlicOsDownloadPath_001 |          | latest download link ([here](https://www.patreon.com/posts/76561333), named `RG35XX-CopyPasteOnTopOfStock.7z.001`)                                                       |
| garlicOsDownloadPath_002 |          | latest download link ([here](https://www.patreon.com/posts/76561333), named `RG35XX-CopyPasteOnTopOfStock.7z.002`)                                                       |
| adbDeviceId              |          | adb device id (`adb devices`)                                                                                                                                            |
| saveDir                  | x        | local dir where to save `saves` (example : `/home/Skekfly/saves`). It copies `saves` only if `saveDir` is set (From Ext SD card if there is one, Int SD card otherwise). |
| resetCfg                 | x        | `true` or `false` (default = false). Replace `retroarch.cfg` and the current theme by those in the update archive.							                                                |

## How to

1. power on your device
2. Set the latest download links (001 & 002) in `garlicos-updater.cfg`
3. connect your device on the computer via USB
4. Run `garlicos-updater.sh`

<br/>
<br/>
<br/>
<br/>
<a href="https://www.buymeacoffee.com/skekfly" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
