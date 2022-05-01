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

### Important Privacy Notice

If for whatever reason you're using a version downloaded from before 5/1/2022, please re-download immediately! Otherwise, you may be at risk of getting your IP leaked because localtunnel is fucking stupid.

### Usage

1. Download the master zip of the repository
2. Unzip it, and place it somewhere safe
3. Open a terminal window in the directory that you unzipped
4. Use `npm i` to install the necessary packages (or `express`, `uuid` & `localtunnel` if that doesn't install properly)
5. Run `node protosync` to start ProtoSYNC.

(Check the next tab for more info on installing the plugin)

### Safety

It is recommended that you change the password for your script's safety. To do so, open up the `protosync.js` file and go to the Configuration table. Change the password from 'soup' to something else. You don't need to remember it, to be honest. Make sure you save the file, and double check your server still starts successfully.

Then, open up an empty Roblox Studio baseplate and drag the `ProtoSYNC V2.0.0.rbxm` file in. Open ProtoSYNC > Primary and then change the `password` variable to the same thing you put for the `protosync.js` file. If it's not the same, the server won't accept it. 

Finally, you can right click on the ProtoSYNC folder in Studio and "Save as Local Plugin". Press Save when it prompts (and overwrite if it prompts too), and you should be all set.

.. This process will likely be changed in the future.
