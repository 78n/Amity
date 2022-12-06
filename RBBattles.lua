local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:FindService("Players")
local rs = game:FindService("RunService")
local Heartbeat = rs.Heartbeat
local lp = Players.LocalPlayer
local OuterCity = workspace:WaitForChild("OuterCity")
local PlayerService = ReplicatedStorage:WaitForChild("DragonEngine"):WaitForChild("Network"):WaitForChild("Service_Endpoints"):WaitForChild("PlayerService")
local setregion = PlayerService:WaitForChild("SetState_IsInOuterCity")
local CollectCoin = ReplicatedStorage:WaitForChild("Network"):WaitForChild("CoinCollected")

PlayerService:WaitForChild("SetState_WantsToCompete"):InvokeServer(false)

repeat task.wait() until lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid") and lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart
local RootPart = lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart

local function touchchest(model)
    for i,v in next, model:GetDescendants() do
        if v:IsA("TouchTransmitter") and v.Parent:IsA("BasePart") then
            if not RootPart then break end
            setregion:InvokeServer(true)
            pcall(function()
                firetouchinterest(RootPart,v.Parent,0) --randomly errors
            end)
        end
    end
end

OuterCity.ChildAdded:Connect(function(v)
    if v:IsA("Model") and v.Name:find("SmallChest") then
        repeat
            touchchest(v)
            wait(1)
        until not v
    end
end)

for i,v in next, OuterCity:GetChildren() do
    if v:IsA("Model") then
        touchchest(v)
    end
end

for i,v in next, OuterCity:WaitForChild("OuterCityRing1Obstacles"):WaitForChild("Coins"):GetChildren() do
    if v:IsA("BasePart") then
        setregion:InvokeServer(true)
        repeat
            if not RootPart then break end
            RootPart.CFrame = v.CFrame
            Heartbeat:Wait()
            if v:FindFirstChildWhichIsA("IntValue") then
                CollectCoin:FireServer(v:FindFirstChildWhichIsA("IntValue").Value)
            end
        until not v:FindFirstChildWhichIsA("IntValue")
    end
end
