local Players = game:GetService("Players")
local rs = game:GetService("RunService")
local lp = Players.LocalPlayer
local backpack = lp:FindFirstChildWhichIsA("Backpack")

local function path()
    for i,v in next, game:GetService("Workspace"):GetDescendants() do
        if v:IsA("ProximityPrompt") and v.Parent:IsA("MeshPart") then
            return v.Parent
        end
    end
end

local part = path()
local proximityprompt = part:FindFirstChildWhichIsA("ProximityPrompt")
local oldpos = lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame

repeat
    lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = part.CFrame
    rs.Heartbeat:Wait()
    fireproximityprompt(proximityprompt)
until #backpack:GetChildren() >= 300

lp.Character:FindFirstChild("RightHand"):Destroy()
lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = oldpos
rs.Heartbeat:Wait()

for i,v in next, backpack:GetChildren() do
    if v:IsA("Tool") then
        v.Parent = lp.Character
    end
end
