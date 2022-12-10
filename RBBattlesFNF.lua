local SoundService = game:GetService("SoundService")
local BadgeService = game:GetService("BadgeService")
local Players = game:FindService("Players")
local rs = game:FindService("RunService")
repeat task.wait() until Players.LocalPlayer
local lp = Players.LocalPlayer
local hahafunnyremote = game:GetService("ReplicatedStorage"):WaitForChild("RF")
local Platform = workspace:WaitForChild("Map"):WaitForChild("Stages"):WaitForChild("EventStage"):WaitForChild("Pads"):WaitForChild("PadPart")

repeat
    if lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid") and lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart then
        lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = Platform.CFrame
    end
    rs.Heartbeat:Wait()
until SoundService:FindFirstChild("rbxassetid://11772514365")

for i = 1,1000 do
    task.spawn(function()
        hahafunnyremote:InvokeServer({"Server","RoundManager","UpdateScore"},{350})
    end)
end
