local connections = configs and configs.connections
if connections then
    for i,v in connections do
        v:Disconnect() 
    end
end

getgenv().configs = getgenv().configs or {
    connections = {},
    Size = Vector3.new(10,10,10),
    DeathCheck = true
}

local Players = cloneref(game:GetService("Players"))
local lp = Players.LocalPlayer
local Ignorelist = OverlapParams.new()
Ignorelist.FilterType = Enum.RaycastFilterType.Include

local function GetTouchInterest(Tool)
    return Tool and Tool:FindFirstChildWhichIsA("TouchTransmitter",true)
end

local function GetCharacters(LocalPlayerChar)
    local Characters = {}
    for i,v in Players:GetPlayers() do
        table.insert(Characters,v.Character)
    end
    table.remove(Characters,table.find(Characters,LocalPlayerChar))
    return Characters
end

table.insert(getgenv().configs.connections,game:GetService("RunService").Heartbeat:Connect(function()
    local char = lp.Character
    local Tool = char and char:FindFirstChildWhichIsA("Tool")
    local TouchInterest = Tool and GetTouchInterest(Tool)
    
    if TouchInterest then
        local TouchPart = TouchInterest.Parent
        local Characters = GetCharacters(char)
        Ignorelist.FilterDescendantsInstances = Characters
        local InstancesInBox = workspace:GetPartBoundsInBox(TouchPart.CFrame,TouchPart.Size + configs.Size,Ignorelist)

        for i,v in InstancesInBox do
            local Character = v:FindFirstAncestorWhichIsA("Model")

            if table.find(Characters,Character) then
                if configs.DeathCheck then
                    local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
                    if Humanoid and Humanoid.Health <= 0 then
                        return
                    end
                end
                Tool:Activate()
                firetouchinterest(TouchPart,v,1)
                firetouchinterest(TouchPart,v,0)
            end
        end
    end
end))
