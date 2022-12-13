local lp = game:FindService("Players").LocalPlayer
local EndZone = workspace:WaitForChild("ObbyFolder"):WaitForChild("EndZone")

repeat
    if lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid") and lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart then
        firetouchinterest(lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart,EndZone,0)
    end
    task.wait()
until not game
