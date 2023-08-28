if KillAll then KillAll() end

local Run = true

local KillAll = setmetatable(configs or {
    whitelist = {},
    AutoToxic = true,
    ResponseList = {"<user> is such a noob","Imagine dying <user>","lol <user> just died","Alt F4 already <user>"}
},{__call = function()
    Run = false
end})

getgenv().KillAll = KillAll

local cloneref = cloneref or function(obj) return obj end

local SayMessageRequest = cloneref(game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"))
local Players = cloneref(game:GetService("Players"))
local lp = cloneref(Players.LocalPlayer)

local function getchar(plr)
    return (plr or lp).Character
end

local function gethumanoid(plr)
    local char = plr and plr:IsA("Model") and plr or getchar(plr)
    return (char and char:FindFirstChildWhichIsA("Humanoid")),char
end

local function gettool(plr)
    local char = plr and plr:IsA("Model") and plr or getchar(plr)
    return (char and char:FindFirstChildWhichIsA("Tool")),char
end

local function GetDamageRemoteFromTool(Tool)
    return Tool and Tool:FindFirstChildWhichIsA("RemoteEvent",true)
end

local function IsValidMember(obj,target)
    return obj:IsDescendantOf(target or game)
end

local function IsAlive(Humanoid)
    return Humanoid and (IsValidMember(Humanoid) and Humanoid.Health > 0)
end

local function GetHumanoids()
    local Humanoids = {}
    for i,v in Players:GetPlayers() do
        if not table.find(KillAll.whitelist,v.Name) then
            local Humanoid,char = gethumanoid(v)
            if IsAlive(Humanoid) then
                Humanoids[char] = Humanoid
            end
        end
    end
    return Humanoids
end

table.insert(KillAll.whitelist,lp.Name)

while Run do
    for char,Humanoid in GetHumanoids() do
        local DamageRemote = GetDamageRemoteFromTool(gettool())

        if DamageRemote then
            if IsValidMember(char) and not char:FindFirstChildWhichIsA("ForceField") then
                if IsAlive(Humanoid) then
                    local lpchar = getchar()
                    local InvalidMember = false
                    repeat
                        if Run and IsValidMember(lpchar) and IsValidMember(DamageRemote,lpchar) then
                            DamageRemote:FireServer(Humanoid)
                            task.wait()
                        else
                            InvalidMember = true
                            break
                        end
                    until not IsAlive(Humanoid)
                    if not InvalidMember then
                        local Player = char.Name
                        warn("Successfully killed:",Player)
                        if KillAll.ResponseList then
                            SayMessageRequest:FireServer(KillAll.ResponseList[math.random(#KillAll.ResponseList)]:gsub("<user>",Player),"All")
                        end
                    else
                        warn("DamageRemote is no longer a valid member of LocalPlayer's Character")
                    end
                end
            end
        else
            break
        end
    end
    task.wait()
end
