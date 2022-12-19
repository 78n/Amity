local hint = Instance.new("Hint",game:FindService("CoreGui"))
hint.Text = "Go to the main map"
local lp = game:FindService("Players").LocalPlayer
local CommitCollection = getupvalue(require(game:GetService("ReplicatedStorage"):WaitForChild("Fsys")).load("RouterClient").init,4)["JournalAPI/CommitCollection"]

local MainMap = workspace:WaitForChild("Interiors"):WaitForChild("MainMap/Default")
hint:Destroy()
for i,v in next, MainMap:WaitForChild("Podiums"):GetChildren() do
    if v:IsA("Model") then
        repeat task.wait() until lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid") and lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart
        firetouchinterest(lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart,v:WaitForChild("Crystal"),0)
    end
end

game:FindService("RunService").Heartbeat:Connect(function()
    repeat task.wait() until lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid") and lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart
    lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = MainMap:WaitForChild("TrophyRig"):WaitForChild("RootPart").CFrame
    CommitCollection:FireServer({pet_accessories = {rb_battles_trophy_hat = {date_acquired = os.time()}}})
end)
