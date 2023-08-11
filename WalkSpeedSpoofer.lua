--[[
    Credits:
        Alias | Discord | (V3rmillion)

        engo | joeengo | (https://v3rmillion.net/member.php?action=profile&uid=1127047): Thank you for making me the detections,
        Amity | winterpark | (https://v3rmillion.net/member.php?action=profile&uid=2566454): For making the script

]]

local setspeed = 100 --Adding this for the script kiddies if you're a developer you can just remove this line

local WalkSpeedSpoof = getgenv().WalkSpeedSpoof
local Disable = WalkSpeedSpoof and WalkSpeedSpoof.Disable
if Disable then
    Disable()
end

local cloneref = cloneref or function(...)
    return ...
end

local WalkSpeedSpoof = {}

local Players = cloneref(game:GetService("Players"))
if not Players.LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
end
local lp = cloneref(Players.LocalPlayer)

local split = string.split
local find = table.find

local GetDebugIdHandler = Instance.new("BindableFunction")
local TempHumanoid = Instance.new("Humanoid")

local FakeHumanoids = setmetatable({},{__mode = "v"})
local cachedhumanoids = {}

local CurrentHumanoidDebugId
local CurrentHumanoid
local newindexhook
local indexhook

function GetDebugIdHandler.OnInvoke(obj: Instance): string
    return obj:GetDebugId()
end

local function GetDebugId(obj: Instance): string
    return GetDebugIdHandler:Invoke(obj)
end

local function GetWalkSpeed(obj: any): number
    TempHumanoid.WalkSpeed = obj
    return TempHumanoid.WalkSpeed
end

local OldInstancenew
OldInstancenew = hookfunction(Instance.new,newcclosure(function(classname,...)
    local obj = old(classname,...)
    if typeof(obj) == "Instance" and obj:IsA("Humanoid") then
        table.insert(FakeHumanoids,obj)
    end
    return obj
end))

indexhook = hookmetamethod(game,"__index",function(self,index)
    if not checkcaller() and typeof(self) == "Instance" then
        if self:IsA("Humanoid") and not find(FakeHumanoids,self) then
            local DebugId = GetDebugId(self)
            local cached = cachedhumanoids[DebugId]

            if self:IsDescendantOf(lp.Character) or cached then
                if type(index) == "string" then
                    local cleanindex = split(index,"\0")[1]

                    if cleanindex == "WalkSpeed" then
                        if not cached then
                            cachedhumanoids[DebugId] = {
                                currentindex = indexhook(self,index),
                                lastnewindex = nil
                            }
                            cached = cachedhumanoids[DebugId]
                        end

                        if not (CurrentHumanoid and CurrentHumanoid:IsDescendantOf(game)) then
                            CurrentHumanoid = cloneref(self)
                        end

                        return cached.lastnewindex or cached.currentindex
                    end
                end
            end
        end
    end

    return indexhook(self,index)
end)

newindexhook = hookmetamethod(game,"__newindex",function(self,index,newindex)
    if not checkcaller() and typeof(self) == "Instance" then
        if self:IsA("Humanoid") and not find(FakeHumanoids,self) then
            local DebugId = GetDebugId(self)
            local cached = cachedhumanoids[DebugId]

            if self:IsDescendantOf(lp.Character) or cached then
                if type(index) == "string" then
                    local cleanindex = split(index,"\0")[1]

                    if cleanindex == "WalkSpeed" then
                        if not cached then
                            cachedhumanoids[DebugId] = {
                                currentindex = indexhook(self,index),
                                lastnewindex = nil
                            }
                            cached = cachedhumanoids[DebugId]
                        end

                        if not (CurrentHumanoid and CurrentHumanoid:IsDescendantOf(game)) then
                            CurrentHumanoid = cloneref(self)
                        end
                        cached.lastnewindex = GetWalkSpeed(newindex)
                        return CurrentHumanoid.WalkSpeed
                    end
                end
            end
        end
    end
    
    return newindexhook(self,index,newindex)
end)

function WalkSpeedSpoof:Disable()
    WalkSpeedSpoof:RestoreWalkSpeed()
    hookmetamethod(game,"__index",indexhook)
    hookmetamethod(game,"__newindex",newindexhook)
    hookfunction(Instance.new,OldInstancenew)
    GetDebugIdHandler:Destroy()
    TempHumanoid:Destroy()
    table.clear(WalkSpeedSpoof)
    getgenv().WalkSpeedSpoof = nil
end

function WalkSpeedSpoof:GetHumanoid()
    return CurrentHumanoid or (function()
        local char = lp.Character
        local Humanoid = char and char:FindFirstChildWhichIsA("Humanoid") or nil

        return Humanoid and cloneref(Humanoid)
    end)()
end

function WalkSpeedSpoof:SetWalkSpeed(speed)
    local Humanoid = WalkSpeedSpoof:GetHumanoid()

    if Humanoid then
        local connections = {}
        local function AddConnectionsFromSignal(Signal)
            for i,v in getconnections(Signal) do
                if v.State then
                    v:Disable()
                    table.insert(connections,v)
                end
            end
        end
        AddConnectionsFromSignal(Humanoid.Changed)
        AddConnectionsFromSignal(Humanoid:GetPropertyChangedSignal("WalkSpeed"))
        Humanoid.WalkSpeed = speed
        for i,v in connections do
            v:Enable()
        end
    end
end

function WalkSpeedSpoof:RestoreWalkSpeed()
    local Humanoid = WalkSpeedSpoof:GetHumanoid()
    
    if Humanoid then
        local cached = cachedhumanoids[Humanoid:GetDebugId()]

        if cached then
            WalkSpeedSpoof:SetWalkSpeed(cached.lastnewindex or cached.currentindex)
        end
    end
end

getgenv().WalkSpeedSpoof = WalkSpeedSpoof

if setspeed then
    WalkSpeedSpoof:SetWalkSpeed(setspeed)
end
