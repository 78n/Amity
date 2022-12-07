local configs = _G.configs or {
    autoserverhop = false,
    nonametag = false
}

repeat task.wait() until game:IsLoaded()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:FindService("Players")
local rs = game:FindService("RunService")
local Heartbeat = rs.Heartbeat
local lp = Players.LocalPlayer
local OuterCity = workspace:WaitForChild("OuterCity")
local PlayerService = ReplicatedStorage:WaitForChild("DragonEngine"):WaitForChild("Network"):WaitForChild("Service_Endpoints"):WaitForChild("PlayerService")
local setregion = PlayerService:WaitForChild("SetState_IsInOuterCity")
local CollectCoin = ReplicatedStorage:WaitForChild("Network"):WaitForChild("CoinCollected")

PlayerService:WaitForChild("SetState_WantsToCompete"):InvokeServer(false)

repeat task.wait() until lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid") and lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart
local RootPart = lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart

if configs["nonametag"] then
    for i,v in next, RootPart:GetChildren() do
        if v:IsA("BillboardGui") then
            v:Destroy()
        end
    end
end

if firetouchinterest then --no idea why you wouldnt have firetouchinterest
    local function touchchest(model)
        for i,v in next, model:GetDescendants() do
            if v:IsA("TouchTransmitter") and v.Parent:IsA("BasePart") then
                if not RootPart then break end
                setregion:InvokeServer(true)
                pcall(function()
                    firetouchinterest(RootPart,v.Parent,0) --randomly errors
                end)
            end
        end
    end
    
    OuterCity.ChildAdded:Connect(function(v)
        if v:IsA("Model") and v.Name:find("SmallChest") then
            repeat
                touchchest(v)
                wait(1)
            until not v
        end
    end)
    
    for i,v in next, OuterCity:GetChildren() do
        if v:IsA("Model") then
            touchchest(v)
        end
    end
end

for i,v in next, OuterCity:WaitForChild("OuterCityRing1Obstacles"):WaitForChild("Coins"):GetChildren() do
    if v:IsA("BasePart") then
        setregion:InvokeServer(true)
        repeat
            if not RootPart then break end
            RootPart.CFrame = v.CFrame
            Heartbeat:Wait()
            if v:FindFirstChildWhichIsA("IntValue") then
                CollectCoin:FireServer(v:FindFirstChildWhichIsA("IntValue").Value)
            end
        until not v:FindFirstChildWhichIsA("IntValue")
    end
end

if configs["autoserverhop"] then
    local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport
    if syn then request = syn.request end

    if queueteleport and request then
        local PlaceId = game.PlaceId
        local http = game:GetService("HttpService")
        local function jsone(str) return http:JSONEncode(str) end
        local function jsond(str) return http:JSONDecode(str) end
        queueteleport([[loadstring(game:HttpGet('https://raw.githubusercontent.com/78n/Amity/main/RBBattles.lua'))()]])
        local TeleportService = game:GetService("TeleportService")
    
        local servers = {}
        local cursor = ''
    
        while cursor and #servers == 0 do
            task.wait()
            local req = request({
                Url = ('https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100&cursor=%s'):format(PlaceId,cursor)
            })
            local body = jsond(req.Body)
    
            if body and body.data then
                task.spawn(function()
                    for i,v in next, body.data do
                        if type(v) == 'table' and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers then
                            table.insert(servers, 1, v.id)
                        end 
                    end
                end)
    
                if body.nextPageCursor then
                    cursor = body.nextPageCursor
                end
            end
        end
    
        while #servers > 0 do
            TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], lp)
            task.wait(1)
        end
    end
end
