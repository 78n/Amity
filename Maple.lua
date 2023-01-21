local hint = Instance.new("Hint",Instance.new("Folder",game:GetService("CoreGui")))
hint.Text = "\nYou can get the script without going through ads here:\nhttp://gg.gg/mscript"
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local rs = game:GetService("RunService")
local lp = Players.LocalPlayer

ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("RolesService"):WaitForChild("__comm__"):WaitForChild("RE"):WaitForChild("SetRole"):FireServer("Janitor")
if not lp.Backpack:FindFirstChild("Mop") then
    ReplicatedStorage:WaitForChild("Events"):WaitForChild("Equip"):FireServer(ReplicatedStorage:WaitForChild("Tools"):WaitForChild("Mop"))
end

local Garbage = workspace:WaitForChild("Garbage")
workspace.FallenPartsDestroyHeight = 0/0 --lazy
repeat task.wait() lp.Character:FindFirstChildWhichIsA("Humanoid"):UnequipTools() until lp.Backpack:FindFirstChild("Mop")
local Mop = lp.Backpack:FindFirstChild("Mop")
local Bottom = Mop:WaitForChild("Bottom")

if not hint then lp["\75\105\99\107"](lp,"Do not") end
hint:GetPropertyChangedSignal("Parent"):Connect(function()
    lp.Kick(lp,"Do not touch my hint >:O")
end)

lp.Character:FindFirstChildWhichIsA("Humanoid"):GetPropertyChangedSignal("Sit"):Connect(function() --antisit
    rs.Heartbeat:Wait()
    lp.Character:FindFirstChildWhichIsA("Humanoid").Sit = false
end)

local currentlycleaning = false
local function clean(Spill)
    if Spill:IsA("BasePart") then
        if currentlycleaning then repeat task.wait() until not currentlycleaning end
        currentlycleaning = true 
        local oldpos = lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame
        repeat
            Mop.Parent = lp.Character
            lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = Spill.CFrame
            firetouchinterest(Bottom,Spill,0)
            Mop:Activate()
            firetouchinterest(Bottom,Spill,1)
            rs.Heartbeat:Wait()
        until not Spill or not Spill.Parent
        currentlycleaning = false
        lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = oldpos
    end
end

Garbage.ChildAdded:Connect(clean)
for i,v in next, Garbage:GetChildren() do
    clean(v)
end
