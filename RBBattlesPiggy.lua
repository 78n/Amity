--This is the best you will get
local function getfolder()
    local storage
    repeat
        for i,v in next, workspace:GetChildren() do
            if v:IsA("Folder") and tonumber(v.Name) then
                storage = v
            end
        end
    until storage
    return storage
end

local folder = getfolder()
local ItemFolder = lp:WaitForChild("PlayerInfoFolder"):WaitForChild("ItemFolder")
local Space = workspace:WaitForChild("Space")
local Events = Space:WaitForChild("Events")
local CombinationEvent = Events:WaitForChild("CombinationEvent")
local FinalCodeEvent = Events:WaitForChild("FinalCodeEvent")
local ColorEvent = Events:WaitForChild("ColorEvent")
local SafeEvents = Events:WaitForChild("SafeEvents")
local WireEvent = Events:WaitForChild("WireEvent")
local BatteryEvent = Events:WaitForChild("BatteryEvent")
local WireTrigger = Events:WaitForChild("RocketEvent"):WaitForChild("WireTrigger")
local PipeEvent = Events:WaitForChild("PipeEvent")

for i,v in next, folder:GetChildren() do
    if v:IsA("Model") then
        v.Name = v:WaitForChild("Item"):FindFirstChildWhichIsA("ProximityPrompt").ObjectText
    end
end

local function anchoredcheck()
    if lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.Anchored then
        repeat task.wait() until not lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.Anchored
        task.wait(1) --noticed the game unanchores you before it reenables your ability to do stuff
    end
    return false
end

local function getcode()
    local code = ""

    for i,v in next, CombinationEvent:GetChildren() do
        if v:IsA("Model") and v.Name:find("Code") then
            code = code..v:WaitForChild("CodeInput"):WaitForChild("SurfaceGui"):WaitForChild("TextLabel").Text
        end
    end

    lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = CombinationEvent:WaitForChild("Door").CFrame * CFrame.new(5,0,0)
    rs.Heartbeat:Wait()
    
    for i = 1,#code do
        wait(1)
        anchoredcheck()
        CombinationEvent:FindFirstChild("Num"..code:sub(i,i)):WaitForChild("ClickEvent"):FireServer()
    end
    
    return code --if you want to print it or smthing im not here to judge if you wanna help your friends
end

local function Collect(BasePart,itemInstance)
    local itemname = itemInstance.Parent.Name
    repeat
        lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = BasePart.CFrame
        rs.Heartbeat:Wait()
        if BasePart and BasePart:FindFirstChildWhichIsA("RemoteEvent") then
            BasePart:FindFirstChildWhichIsA("RemoteEvent"):FireServer()
        end
        if itemInstance and itemInstance:FindFirstChildWhichIsA("ProximityPrompt") then
            fireproximityprompt(itemInstance:FindFirstChildWhichIsA("ProximityPrompt"))
        end
    until ItemFolder:FindFirstChild(itemname)
end

local function depositwire(wire)
    repeat
        lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = WireTrigger.CFrame * CFrame.new(0,0,5)
        if WireTrigger:FindFirstChildWhichIsA("RemoteEvent") then
            WireTrigger:FindFirstChildWhichIsA("RemoteEvent"):FireServer()
        end
        rs.Heartbeat:Wait()
    until not ItemFolder:FindFirstChild(wire)
end

local function Colors()--doesnt really work so if somebody wants to fix it be my guest
    local storage = {}
    local colors = ""

    for i,v in next, ColorEvent:GetChildren() do
        if v:IsA("BasePart") and v.Name:find("Screen") then
            colors = colors..v:WaitForChild("CBGUI"):WaitForChild("Letter").Text
        end
    end

    lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = ColorEvent:WaitForChild("Door").CFrame * CFrame.new(0,0,5)
    rs.Heartbeat:Wait()

    for i,v in next, ColorEvent:GetChildren() do --lazy
        if v:IsA("BasePart") and v.Name:find("Button") then
            storage[v.Name:sub(1,1)] = v.Name
        end
    end

    for i = 1,#colors do
        wait(1)
        anchoredcheck()
        fireclickdetector(ColorEvent:FindFirstChild(storage[colors:sub(i,i)]):FindFirstChildWhichIsA("ClickDetector"))
        --ColorEvent:FindFirstChild(storage[colors:sub(i,i)]):WaitForChild("ClickEvent"):FireServer()
    end

    return colors
end

local function Wires()
    for i,v in next, folder:GetChildren() do
        if v:IsA("Model") and v.Name == "Wire" then
            local WirePart = v:WaitForChild("Item")
            repeat
                lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = WirePart.CFrame
                if v and WirePart and WirePart:FindFirstChildWhichIsA("ProximityPrompt") then
                    fireproximityprompt(WirePart:FindFirstChildWhichIsA("ProximityPrompt"))
                end
                rs.Heartbeat:Wait()
            until ItemFolder:FindFirstChild(v.Name)
            for i_1,v_1 in next, WireEvent:GetChildren() do --lazy
                if v_1:IsA("BasePart") and v_1.Name:find("Wire") and ItemFolder:FindFirstChild("Wire") then
                    local timeout = 0
                    repeat
                        lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = v_1.CFrame
                        rs.Heartbeat:Wait()
                        if v_1:FindFirstChildWhichIsA("RemoteEvent") then
                            v_1:FindFirstChildWhichIsA("RemoteEvent"):FireServer()
                        end
                        timeout += 1
                    until not ItemFolder:FindFirstChild("Wire") or timeout >= 120
                end
            end
        end
    end
end

local function Batteries() --100% NOT COPY PASTED FROM WIRES REAL!!!!
    for i,v in next, folder:GetChildren() do
        if v:IsA("Model") and v.Name == "Battery" then
            local BatteryPart = v:WaitForChild("Item")
            repeat
                lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = BatteryPart.CFrame
                if v and BatteryPart and BatteryPart:FindFirstChildWhichIsA("ProximityPrompt") then
                    fireproximityprompt(BatteryPart:FindFirstChildWhichIsA("ProximityPrompt"))
                end
                rs.Heartbeat:Wait()
            until ItemFolder:FindFirstChild(v.Name)
            for i_1,v_1 in next, BatteryEvent:GetChildren() do
                if v_1:IsA("Model") and v_1.Name:find("Battery") and v_1:WaitForChild("Trigger") and v_1:WaitForChild("Trigger"):FindFirstChildWhichIsA("RemoteEvent") and ItemFolder:FindFirstChild("Battery") then
                    local v_1 = v_1:WaitForChild("Trigger")
                    local timeout = 0
                    repeat
                        lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = v_1.CFrame
                        rs.Heartbeat:Wait()
                        if v_1:FindFirstChildWhichIsA("RemoteEvent") then
                            v_1:FindFirstChildWhichIsA("RemoteEvent"):FireServer()
                        end
                        timeout += 1
                    until not ItemFolder:FindFirstChild("Battery") or timeout >= 120
                end
            end
        end
    end
end

local function pipes()
    for i,v in next, PipeEvent:GetChildren() do
        if v:IsA("Model") then
            local Trigger = v:WaitForChild("Trigger")
            repeat
                lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = Trigger.CFrame
                rs.Heartbeat:Wait()
                if Trigger:FindFirstChildWhichIsA("RemoteEvent") then
                    Trigger:FindFirstChildWhichIsA("RemoteEvent"):FireServer()
                end
            until not Trigger:FindFirstChildWhichIsA("RemoteEvent")
        end
    end
end

local function getfinalcode()
    local finalcode = ""
    local codebuttons  = {}
    
    for i,v in next, FinalCodeEvent:GetChildren() do
        if v:IsA("BasePart") then
            if v.Name:find("Number") then
                finalcode = finalcode..v:FindFirstChild("SurfaceGui"):FindFirstChild("Symbol").Text
            elseif v.Name:find("Symbol") then
                codebuttons[v:FindFirstChild("SurfaceGui"):FindFirstChild("TextLabel").Text] = v
            end
        end
    end

    for i = 1,#finalcode do
        local Part = codebuttons[finalcode:sub(i,i)]
    
        lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = Part.CFrame
        wait(1)
        anchoredcheck()
        Part:FindFirstChildWhichIsA("RemoteEvent"):FireServer()
    end

    return finalcode
end

local BlueSafeDoor = SafeEvents:WaitForChild("BlueSafe"):WaitForChild("Door")
local bluekey = folder:WaitForChild("BlueKey"):WaitForChild("Item")
local PurpleKey = folder:WaitForChild("PurpleKey"):WaitForChild("Item")
local Screwdriver = folder:WaitForChild("Screwdriver"):WaitForChild("Item")

getcode()
repeat task.wait() until bluekey.Transparency == 0
Collect(BlueSafeDoor,bluekey)
Collect(BlueSafeDoor,folder:WaitForChild("BlueWire"):WaitForChild("Item"))
depositwire("BlueWire")
Wires()
Collect(WireEvent:WaitForChild("Door"),folder:WaitForChild("GreenKey"):WaitForChild("Item"))
Collect(SafeEvents:WaitForChild("GreenSafe"):WaitForChild("Door"),folder:WaitForChild("GreenWire"):WaitForChild("Item"))
depositwire("GreenWire")
local hint = Instance.new("Hint",game:FindService("CoreGui"))
hint.Text = "Please complete the color task to continue automation"
repeat task.wait() until PurpleKey.Transparency == 0
hint:Destroy()
Collect(ColorEvent:WaitForChild("Door"),PurpleKey)
Collect(SafeEvents:WaitForChild("PurpleSafe"):WaitForChild("Door"),folder:WaitForChild("PurpleWire"):WaitForChild("Item"))
depositwire("PurpleWire")
Batteries()
Collect(Screwdriver,Screwdriver)
pipes()
getfinalcode()
