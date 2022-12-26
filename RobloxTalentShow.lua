if syn and syn.request then request = syn.request end
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport
local TeleportService = game:GetService("TeleportService")
local http = game:GetService("HttpService")
local rs = game:FindService("RunService")
local Players = game:FindService("Players")
repeat task.wait() until Players.LocalPlayer --localplayer wouldnt be created :(
local lp = Players.LocalPlayer
local PlaceId = game.PlaceId
local cursor = ''
local servers = {}

local ObstacleCourses = workspace:WaitForChild("ObstacleCourses")
local Teleports = ObstacleCourses:WaitForChild("Teleports")

local function GetRoot()
    repeat task.wait() until lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid") and lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart
    return lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart
end

local function jsond(str)
    return http:JSONDecode(str)
end

local function collectrep(BasePart)
    local Teleport = tostring(BasePart:WaitForChild("Teleport").Value)
    local TeleportBasePart = Teleports:WaitForChild(Teleport)
    local debounce = 0

    repeat
        GetRoot().CFrame = BasePart.CFrame --* CFrame.new(5,0,0)
        rs.Heartbeat:Wait()
        debounce += 1
    until debounce > 60 and lp:DistanceFromCharacter(TeleportBasePart.Position) >= 1
end

for i,v in next, ObstacleCourses:GetChildren() do
    if v:IsA("Model") and v.Name:find("ObstacleCourse") then
        repeat task.wait() until v:FindFirstChildWhichIsA("BasePart")
        collectrep(v:FindFirstChildWhichIsA("BasePart"))
    end
end

if not request or not queueteleport then return end

while cursor and #servers == 0 do
    local req = request({Url = ('https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100&cursor=%s'):format(PlaceId,cursor)})
    local body = jsond(req.Body)
    
    if body and body.data then
        coroutine.wrap(function()
            for i,v in next, body.data do
                if type(v) == 'table' and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers then
                    table.insert(servers, 1, v.id)
                end 
            end
        end)()
    
        if body.nextPageCursor then
            cursor = body.nextPageCursor
        end
    end
    task.wait()
end

queueteleport([[loadstring(game:HttpGet('https://raw.githubusercontent.com/78n/Amity/main/RobloxTalentShow.lua'))()]])

while #servers > 0 do
    TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], lp)
    task.wait(1)
end
