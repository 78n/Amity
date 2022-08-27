local placeid = game.PlaceId

local games = {
    [7014716500] = "Added Announcement\nJoin the discord to suggest what you want added\nhttps://discord.gg/YQ9HFqFkf6"
}

if games[placeid] then
    return games[placeid]
end
