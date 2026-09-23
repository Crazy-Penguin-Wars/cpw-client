# Crazy Penguin Wars Client

This repository contains the source code for GameLauncher.swf.

## Prerequisites
When running for the first time, be sure that:
- You have installed the [AIR SDK from HARMAN](https://airsdk.harman.com/release_notes) (latest tested is v50.2.2.5).
- [cpw-server](https://github.com/Crazy-Penguin-Wars/cpw-server) is running
- the data URL and api URL (from cpw-server), as well as your developer account data, are set in Config.as

## Building
### Adobe Animate
Using Adobe Animate, make sure the necessary SWC libraries from the bin folder are linked correctly in the Actionscript settings in Adobe Animate (they will probably default to their file location on my computer).

### Visual Studio Code
- Make sure you install the recommended [ActionScript & MXML](https://open-vsx.org/vscode/item?itemName=bowlerhatllc.vscode-as3mxml) extension, it requires Java JDK 11 or newer.
- create `.vscode/settings.json`, and change the path to where you installed the AIRSDK:
```jsonc
{
    "as3mxml.sdk.framework": "/path/to/your/AIRSDK_LINUX/",
}
```
- To compile the game, press `CTRL+SHIFT+B` and run the ActionScript build task. (using `release` preferably for the production build)
