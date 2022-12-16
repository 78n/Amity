local rs = game:FindService("RunService")
local lp = game:FindService("Players").LocalPlayer
local End = workspace:WaitForChild("Map"):WaitForChild("Ignore"):WaitForChild("Rooms"):WaitForChild("9"):WaitForChild("Blockers"):WaitForChild("End")

repeat task.wait() until lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid") and lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart
repeat
    if lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid") and lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart then
        lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = End.CFrame * CFrame.new(-5,0,0)
        rs.Heartbeat:Wait()
        lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = End.CFrame * CFrame.new(5,0,0)
    end
    rs.Heartbeat:Wait()
until not lp.Character
