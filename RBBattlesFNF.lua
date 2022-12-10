local SoundService = game:GetService("SoundService")
local BadgeService = game:GetService("BadgeService")
local Heartbeat = game:FindService("RunService").Heartbeat
local hahafunnyremote = game:GetService("ReplicatedStorage"):WaitForChild("RF")
local Platform = workspace:WaitForChild("Map"):WaitForChild("Stages"):WaitForChild("EventStage"):WaitForChild("Pads"):WaitForChild("PadPart")

repeat
    if lp and lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid") and lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart then
        lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = Platform.CFrame
    end
    Heartbeat:Wait()
until SoundService:FindFirstChild("rbxassetid://11772514365")

for i = 1,1000 do
    task.spawn(function()
        hahafunnyremote:InvokeServer({"Server","RoundManager","UpdateScore"},{350})
    end)
end
