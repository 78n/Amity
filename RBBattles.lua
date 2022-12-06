local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:FindService("Players")
local rs = game:FindService("RunService")
local lp = Players.LocalPlayer
local setstate = ReplicatedStorage:WaitForChild("DragonEngine"):WaitForChild("Network"):WaitForChild("Service_Endpoints"):WaitForChild("PlayerService"):WaitForChild("SetState_IsInOuterCity")
local CollectCoin = ReplicatedStorage:WaitForChild("Network"):WaitForChild("CoinCollected")

for i,v in next, workspace:WaitForChild("OuterCity"):WaitForChild("OuterCityRing1Obstacles"):WaitForChild("Coins"):GetChildren() do
    if v:IsA("BasePart") then
        setstate:InvokeServer(true) --idk
        repeat
            lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = v.CFrame
            rs.Heartbeat:Wait()
            if v:FindFirstChildWhichIsA("IntValue") then
                CollectCoin:FireServer(v:FindFirstChildWhichIsA("IntValue").Value)
            end
        until not v:FindFirstChildWhichIsA("IntValue")
    end
end
    
--poop autochest thing I made like 3 hours ago im not going to bother debugging it right now so ima just put it in a pcall
pcall(function()
    for i,v in next, workspace.OuterCity:GetChildren() do
        if v.Name:find("Chest") then
            setstate:InvokeServer(true)
            lp.Character.HumanoidRootPart.CFrame = v.Hitbox.CFrame
            rs.Heartbeat:Wait()
        end
    end
end)
