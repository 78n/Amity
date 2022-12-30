--If you got this script from robloxscripts.com use v3rmillion instead they did not get permission to post it there
local PlaceId = game.PlaceId
local games = {
    [11702621548] = "https://raw.githubusercontent.com/78n/Amity/main/RBBattlesPiggy.lua",
    [6447798030] = "https://raw.githubusercontent.com/78n/Amity/main/RBBattlesFNF.lua",
    [11775705000] = "https://raw.githubusercontent.com/78n/Amity/main/RBBattlesShoppingWars.lua",
    [11704734733] = "https://raw.githubusercontent.com/78n/Amity/main/RBBattlesWackyWizards.lua",
    [7227293156] = "https://raw.githubusercontent.com/78n/Amity/main/RBBattlesTowerofHell.lua",
    [11828780714] = "https://raw.githubusercontent.com/78n/Amity/main/RBBattlesArsenal.lua",
    [9049840490] = "https://raw.githubusercontent.com/78n/Amity/main/RBBattlesSonicSpeedSimulator.lua",
    [920587237] = "https://raw.githubusercontent.com/78n/Amity/main/RBBattlesAdoptMe.lua",
    [537413528] = "https://raw.githubusercontent.com/78n/Amity/main/RBBattlesBuildABoatForTreasure.lua",
    [606849621] = "https://raw.githubusercontent.com/78n/Amity/main/RBBattlesJailBreak.lua",
    [3145447020] = 'https://raw.githubusercontent.com/78n/Amity/main/RBBattlesMountEverest.lua'
}

if games[PlaceId] then
    return loadstring(game:HttpGet(games[PlaceId]))()
end
warn(("Game (%s) not supported yet"):format(PlaceId))
