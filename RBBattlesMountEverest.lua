local lp = game:FindService("Players").LocalPlayer
game:GetService("ReplicatedStorage"):WaitForChild("VitalityBridge"):FireServer("dmg",{dmg=0/0,r="falling"})
lp.Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 50
lp.Character:FindFirstChildWhichIsA("Humanoid").JumpHeight = 15
lp.Character:FindFirstChildWhichIsA("Humanoid"):GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    lp.Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 50
end)
lp.Character:FindFirstChildWhichIsA("Humanoid"):GetPropertyChangedSignal("JumpHeight"):Connect(function()
    lp.Character:FindFirstChildWhichIsA("Humanoid").JumpHeight = 15
end)
lp.Character:WaitForChild("FlingPreventer").Disabled = true
lp:GetMouse().KeyDown:Connect(function(Key)
    if Key == " " then
        lp.Character:FindFirstChildWhichIsA('Humanoid'):ChangeState(3)
    end
end)
