getgenv().hitboxsize = 10 --studs
local Players = game:FindService("Players")
local rs = game:FindService("RunService")
local lp = Players.LocalPlayer
local connections = {}

local function hitbox(plr)
    local plrname = plr.Name
    local size = getgenv().hitboxsize
    if not connections[plr] or not connections["SteppedLoop_"..plrname] then
        connections[plr] = plr.CharacterAdded:Connect(function(char)
            repeat task.wait() until char:FindFirstChildWhichIsA("Humanoid") and char:FindFirstChildWhichIsA("Humanoid").RootPart
            hitbox(plr)
        end)
        connections["SteppedLoop_"..plrname] = rs.Stepped:Connect(function()
            if plr.Character then
                for i,v in next, plr.Character:GetDescendants() do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end
    repeat task.wait() until plr.Character and plr.Character:FindFirstChildWhichIsA("Humanoid") and plr.Character:FindFirstChildWhichIsA("Humanoid").RootPart
    plr.Character:FindFirstChildWhichIsA("Humanoid").RootPart.Size = Vector3.new(size,size,size)
end

for i,v in next, Players:GetPlayers() do
    if v ~= lp then
        hitbox(v)
    end
end

Players.PlayerAdded:Connect(hitbox)

Players.PlayerRemoving:Connect(function(plr)
    local plrname = plr.Name
    if connections[plr] then
        connections[plr]:Disconnect()
    end
    if connections["SteppedLoop_"..plrname] then
        connections["SteppedLoop_"..plrname]:Disconnect()
    end
end)
