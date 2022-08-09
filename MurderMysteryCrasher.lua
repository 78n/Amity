--[[
    Made by: NoobSploit#0001
    V3rmillion: https://v3rmillion.net/member.php?action=profile&uid=2566454
]]

game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)
local Players = game:GetService('Players')
local lp = Players.LocalPlayer
local items = {}

local function paths()
    for i,v in next, lp:FindFirstChildWhichIsA("PlayerGui").MainGUI.Game.Inventory.Main.Weapons.Items.Container:GetChildren() do
        return v
    end
end

for i,v in next, paths().Container:GetChildren() do
    if v:IsA("Frame") then
        table.insert(items,v.ItemName:FindFirstChildWhichIsA('TextLabel').Text)
    end
end

while wait() do
    for i,v in next, items do
        game:GetService("ReplicatedStorage").Remotes.Inventory.Equip:FireServer(v,"Weapons")
    end
end
