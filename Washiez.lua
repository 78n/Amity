local Players = game:GetService("Players")
local heartbeat = game:GetService("RunService").Heartbeat
local lp = Players.LocalPlayer
local backpack = lp:FindFirstChildWhichIsA("Backpack")

if tostring(game.PlaceId):match(6884042552) then
    local app = game:GetService("ReplicatedStorage").Application.InvokeServer
    
    local ans = {
        "Answer4",
        "Answer2",
        "Answer1",
        "Answer4",
        "Answer2"
    }
    
    for i = 0,#ans do
        app({ans[i],i})
    end
    return
end

local path = function()
    for i,v in next, game:GetService("Workspace"):GetDescendants() do
        if v:IsA("ProximityPrompt") and v.ObjectText:match("Ice Cream Cone") then
            return v.Parent
        end
    end
end

local part = path()
local proximityprompt = part:FindFirstChildWhichIsA("ProximityPrompt")
local oldpos = lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame

repeat
    lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = part.CFrame
    heartbeat:Wait()
    fireproximityprompt(proximityprompt)
until #backpack:GetChildren() >= 300

lp.Character:FindFirstChild("RightHand"):Destroy()
lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = oldpos
heartbeat:Wait()

for i,v in next, backpack:GetChildren() do
    if v:IsA("Tool") then
        v.Parent = lp.Character
    end
end
