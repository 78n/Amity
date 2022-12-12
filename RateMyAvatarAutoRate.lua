local configs = getgenv().configs or {
    autoserverhop = "true",
    rating = "1"
}

local rating = tostring(configs["rating"])
local numrating = tonumber(rating)
local autoserverhop = tostring(configs["autoserverhop"])

local Players = game:FindService("Players")
repeat task.wait() until Players.LocalPlayer
local lp = Players.LocalPlayer
local PostRating = game:GetService("ReplicatedStorage"):WaitForChild("PostRating")

local function rate(plr)
    if plr ~= lp then
        PostRating:FireServer(plr,numrating)
    end
end

Players.PlayerAdded:Connect(rate)
for i,v in next, Players:GetPlayers() do
    rate(v)
end

if autoserverhop:match("true") then
    local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport
    if syn then request = syn.request end

    if queueteleport and request then
        local http = game:GetService("HttpService")
        local PlaceId = game.PlaceId
        local servers = {}
        
        local function jsone(str) return http:JSONEncode(str) end
        local function jsond(str) return http:JSONDecode(str) end

        queueteleport(("getgenv().configs = {autoserverhop = %s,rating = %s} loadstring(game:HttpGet('https://raw.githubusercontent.com/78n/Amity/main/RateMyAvatarAutoRate.lua'))()"):format(autoserverhop,rating))
        local TeleportService = game:GetService("TeleportService")
    
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
