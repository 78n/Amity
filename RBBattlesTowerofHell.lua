local tower = workspace:WaitForChild("tower")
local sections = tower:WaitForChild("sections")
local lp = game:FindService("Players").LocalPlayer

for i,v in next, sections:GetChildren() do
    if v:IsA("Model") and v.Name:find("eventItem") and v:WaitForChild("haloPedastal") and v:FindFirstChild("haloPedastal"):FindFirstChild("haloPart") then
        local haloPart = v:FindFirstChild("haloPedastal"):FindFirstChild("haloPart")
        repeat task.wait()
            print("looping")
            firetouchinterest(lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart,haloPart,0)
        until haloPart.Transparency == 1
    end
end

repeat
    if lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid") and lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart then
        lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = sections:WaitForChild("finishEvent"):WaitForChild("door"):WaitForChild("doorActivate").CFrame * CFrame.new(0,50,0)
    end
    task.wait()
until not game
