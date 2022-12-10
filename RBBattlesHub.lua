local PlaceId = game.PlaceId
local games = {
    [6447798030] = loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/Amity/main/RBBattlesFNF.lua"))
}

if games[PlaceId] then
    return games[PlaceId]()
end
warn(("Game (%s) not supported yet"):format(PlaceId))
