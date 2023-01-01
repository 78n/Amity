if syn and syn.request then request = syn.request end
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport
assert(typeof(request) and typeof(queueteleport) and typeof(isfile) and typeof(makefolder) and typeof(isfolder) and typeof(readfile) and typeof(writefile) == 'function',"Missing functions")

local game = game
local PlaceId = game.PlaceId
local JobId = game.JobId
local PlaceIdString = tostring(PlaceId)

local folderpath = "ServerHoper"
local PlaceFolder = folderpath.."\\"..PlaceIdString
local JobIdStorage = PlaceFolder.."\\JobIdStorage.json"
local CodeToExecute = PlaceFolder.."\\Code.lua"
local data
local code

local Players = game:FindService("Players")
local http = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local function jsone(str) return http:JSONEncode(str) end
local function jsond(str) return http:JSONDecode(str) end

if not isfolder(folderpath) then
    makefolder(folderpath)
    print("Created Folder",folderpath)
end

if not isfolder(PlaceFolder) then
    makefolder(PlaceFolder)
    print("Created PlaceFolder",PlaceFolder)
end

if isfile(JobIdStorage) then
    data = jsond(readfile(JobIdStorage))
else
    data = {
        JobIds = {}
    }
    writefile(JobIdStorage,jsone(data))
    print("Created JobIdStorage",JobIdStorage)
end

if not isfile(CodeToExecute) then
    writefile(CodeToExecute,"")
    print("Created CodeToExecute",CodeToExecute)
    return 
end
code = loadstring(readfile(CodeToExecute))

if not table.find(data['JobIds'],JobId) then
    table.insert(data['JobIds'],JobId)
end

repeat task.wait() until game:IsLoaded() and Players.LocalPlayer

local lp = Players.LocalPlayer

local servers = {}
local cursor = ''

while cursor and #servers <= 0 do
    local req = request({Url = ("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100&cursor%s"):format(PlaceId,cursor)})
    local body = jsond(req.Body)
    
    if body and body.data then
        coroutine.wrap(function()
            for i,v in next, body.data do
                if typeof(v) == 'table' and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and not table.find(data['JobIds'],v.id) then
                    table.insert(servers,1,v.id)
                end
            end
        end)()
        
        if body.nextPageCursor then
            cursor = body.nextPageCursor
        end
    end
    task.wait()
end

for i,v in next, data["JobIds"] do
    if not servers[v] then
        table.remove(data,i)
    end
end

writefile(JobIdStorage,jsone(data))

while #servers > 0 do
    local random = servers[math.random(1,#servers)]
    
    TeleportService:TeleportToPlaceInstance(PlaceId,random,lp)
    task.wait(1)
end
