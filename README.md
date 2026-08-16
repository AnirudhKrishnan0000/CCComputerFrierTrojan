# ComputerFrier trojan
## What is the ComputerFrier trojan?
It is a trojan that will drop you into a fake shell.
Below is the preview of the terminal of an infected user who is trying to use system health checks and giving up.

<img width="621" height="350" src="https://github.com/user-attachments/assets/4394bfd6-ee90-41d8-b9dd-f512abd63c59" />

*Note: This preview was not the actual malware. A safe thumbnail script is used, but the result is recreatable using the malware.*

To download the thumbnail script, [click here](./Thumbnail.lua).

To download the trojan, [click here](./ComputerFrier.lua).

It kept printing the message:
```
Your files are gone. hehe :)
```
Nevertheless, this malware does not just do that. It also forces your computer into a bootloop. Inside CraftOS-PC, it even crashes the emulator, even if you have multiple computers running!

## How does this trojan work?
This trojan works by forcing a recursive launch. The trojan first bricks your computer by saving this Lua code as `startup.lua`:
```lua
pcall(function()
  shell.run("cd /rom")
  shell.run("./startup.lua")
  settings.set("shell.allow_disk_startup", false)
  settings.save()
end)
```
This code disables disk startup, and it will run the built in CraftOS `/rom/startup.lua`.
It is wrapped in a pcall, so that if you are running the malware in Minecraft, it will force your computer to get hardkilled after 10 seconds instead of letting you in the real CraftOS shell.

This works by running the built in CraftOS BIOS, which means it will set everything up, and print the MOTD (Message of the Day). After this, the BIOS will then boot up /startup.lua, which boots up the BIOS again. So much text comes flooding into your screen at the speed of light, which means the emulator crashes, or the engine will hardkill the computer.

## What does this trojan do?
It firstly uses the exploit mentioned earlier to cause the recursive launch to brick your system. After that, it creates a fake shell. No matter what command you type, this is the message it prints:
```
Your files are gone. hehe :)
```
Your files are not actually gone; they are hidden behind the shell.
After 25 seconds, the trojan will print the same message over and over at the speed of light. It will then reboot, causing your system to bootloop. If you also try to use ^T (Ctrl+T) to try to terminate the virus to escape into the shell, the virus will look something like:
```
> Terminated
Goodbye
```
2 seconds after the "Goodbye" is printed, and it will reboot your system, putting you in the bootloop.
It is an extremely simple trojan, but it is very destructive.

## How to disinfect after this trojan?
### Disinfecting in Minecraft
To disinfect the trojan in Minecraft, it is very simple. You should switch to Survival, and smash the computer using a pickaxe.
If this does not work, and you are a server administrator (or playing in singleplayer), you can delete `your_save/computercraft/computer/<ID>/startup.lua`.
### Disinfecting in CraftOS-PC
To disinfect here, it is a little bit complicated.
#### On Windows
Press Win+R, and type this inside the box:
```
%localappdata%\CraftOS-PC\computer\
```
Search for a folder whose name is the computer ID of the infected computer. Go into that folder, and delete startup.lua. Proceed onto the next step of disinfecting.
#### On macOS
Go into Finder. Press Cmd+Shift+G, and type this into the box:
```
~/Library/Application Support/CraftOS-PC/computer
```
Search for a folder whose name is the computer ID of the infected computer. Go into that folder, and delete startup.lua. Proceed onto the next step of disinfecting.
#### On Linux
Open up the terminal, and run this command (replace the `0` with the actual ID of your infected computer):
```
COMPUTERID=0 && rm -f ~/.local/share/craftos-pc/computer/$COMPUTERID/startup.lua ~/.craftos/computer/$COMPUTERID/startup.lua
```
Proceed onto the next step of disinfecting.
#### Disinfecting the settings
To disinfect the settings, you have already removed the bootlooper script. This means you have a fully functional CraftOS computer.
Open CraftOS-PC, and run this command inside it:
```
set shell.allow_disk_startup true
```
Now, your system has been fully disinfected.
