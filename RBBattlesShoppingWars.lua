local lp = game:FindService("Players").LocalPlayer
local rs = game:FindService("RunService")

local Items = workspace:WaitForChild("Items")
local state = true

local function Collect(v)
    if v:IsA("Model") and v:WaitForChild("Root") then
        repeat
            fireclickdetector(v:FindFirstChild("Root"):FindFirstChildWhichIsA("ClickDetector"))
            wait(0.1)
        until not v or not v:FindFirstChild("Root") or not state
    end
end

Items.DescendantAdded:Connect(function(v)
    task.spawn(Collect,v)
end)

task.spawn(function()
    for i,v in next, Items:GetDescendants() do
        if v:IsA("Model") and v:WaitForChild("Root") then
            local debounce = 0
            repeat
                fireclickdetector(v:FindFirstChild("Root"):FindFirstChildWhichIsA("ClickDetector"))
                wait(0.1)
                debounce += 1
            until not v or not v:FindFirstChild("Root") or debounce >= 20 or not state
            if v and v:WaitForChild("Root") then
                task.spawn(Collect,v)
            end
        end
    end
end)
local Stands = workspace:WaitForChild("CashierStands"):WaitForChild("Stands")
local Cash1 = Stands:WaitForChild("Cashier1"):WaitForChild("Touch")
local Cash2 = Stands:WaitForChild("Cashier2"):WaitForChild("Touch")
local UI = lp:WaitForChild("PlayerGui"):WaitForChild("KeyRoomOpen")

repeat
    print("Looping until UI enabled",UI.Enabled)
    if lp and lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid") and lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart then
        lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = Cash1.CFrame
        rs.RenderStepped:Wait()
    end
    if lp and lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid") and lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart then
        lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = Cash2.CFrame
    end
    rs.RenderStepped:Wait()
until UI.Enabled
state = false

local function FindEscapePodRoot()
    for i,v in next, workspace:WaitForChild("EscapeFolder"):GetChildren() do
        if v:FindFirstChild("EscapePod") and v:FindFirstChild("EscapePod"):FindFirstChild("Root") then
            return v:FindFirstChild("EscapePod"):FindFirstChild("Root")
        end
    end
end

local function firepp(BasePart,ProximityPrompt)
    if lp and lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid") and lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart then
        lp.Character:FindFirstChildWhichIsA("Humanoid").RootPart.CFrame = BasePart.CFrame
    end
    rs.Heartbeat:Wait()
    fireproximityprompt(ProximityPrompt)
end

local Keycard = workspace:WaitForChild("KeyRoom"):WaitForChild("Keycard"):WaitForChild("Root")

repeat
    print("Getting keycard",Keycard)
    firepp(Keycard,Keycard:FindFirstChildWhichIsA("ProximityPrompt"))
until lp.Character and lp.Character:FindFirstChild("Keycard")

local EscapePod = FindEscapePodRoot()

repeat
    print("Escaping",EscapePod)
    pcall(function()
        firepp(EscapePod,EscapePod:FindFirstChildWhichIsA("Attachment"):FindFirstChildWhichIsA("ProximityPrompt"))
    end)
    task.wait()
until not EscapePod
