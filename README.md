# protosync
A Roblox Studio plugin to assist with large scripts in Void Script Builder.
<h1 align="center">
  ProtoSYNC
</h1>
<h3 align="center"> Large amounts of code? No problem. </h3>

### Introduction
ProtoSYNC allows you to transport large amounts of lua to a secret server to get around the pesky character limit supplied by Roblox's Textbox solution.

### Requirements
This only requires Internet access and Node.js v16.x.x or newer.

Also, Roblox & Roblox Studio installed on your computer.

### Usage

1. Download the master zip of the repository
2. Unzip it, and place it somewhere safe
3. Open a terminal window in the directory that you unzipped
4. Use `npm i` to install the necessary packages (or `express`, `superagent` & `localtunnel` if that doesn't install properly)
5. Run `node protosync` to start ProtoSYNC.

### Important
ProtoSYNC expects for your Roblox installation to be in `%localappdata%\Roblox`. It will automatically attempt to import the plugin into your Plugins folder & then ask to restart Roblox Studio.

If it is not in there, you will be prompted to manually install the plugin into your Plugins Folder in Roblox Studio.
