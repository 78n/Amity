--If you got this script from robloxscripts.com use v3rmillion instead they did not get permission to post it there
local PlaceId = game.PlaceId
local games = {
    [11702621548] = loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/Amity/main/RBBattlesPiggy.lua")),
    [6447798030] = loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/Amity/main/RBBattlesFNF.lua")),
    [11775705000] = loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/Amity/main/RBBattlesShoppingWars.lua")),
    [11704734733] = loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/Amity/main/RBBattlesWackyWizards.lua")),
    [7227293156] = loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/Amity/main/RBBattlesTowerofHell.lua")),
    [11828780714] = loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/Amity/main/RBBattlesArsenal.lua")),
    [9049840490] = loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/Amity/main/RBBattlesSonicSpeedSimulator.lua")),
    [920587237] = loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/Amity/main/RBBattlesAdoptMe.lua"))
}

if games[PlaceId] then
    return games[PlaceId]()
end
warn(("Game (%s) not supported yet"):format(PlaceId))
