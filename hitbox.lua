local Players = game:GetService("Players")
local lp = Players.LocalPlayer
getgenv().size = 30 --size of hitbox in studs

local WaitForChildWhichIsA = function(instance, classtype)
	local target = instance:FindFirstChildWhichIsA(classtype)
	while not target or not target:IsA(classtype) do
		target = instance.ChildAdded:Wait()	
	end
	return target
end

for i,v in next, Players:GetPlayers() do
    if v ~= lp then
        if v and v.Character and v.Character:FindFirstChildWhichIsA('Humanoid') and v.Character:FindFirstChildWhichIsA('Humanoid').RootPart then
            local humanoid = v.Character:FindFirstChildWhichIsA('Humanoid')
            local hrp = humanoid.RootPart
            hrp.Size = Vector3.new(size,size,size)
            hrp.CanCollide = false
            hrp:GetPropertyChangedSignal('CanCollide'):Connect(function()
                hrp.CanCollide = false
            end)
        end
        v.CharacterAdded:Connect(function(char)
            local humanoid = WaitForChildWhichIsA(char,'Humanoid')
            
            repeat task.wait() until humanoid.RootPart
            
            humanoid.RootPart.Size = Vector3.new(size,size,size)
            humanoid.RootPart.CanCollide = false
            humanoid.RootPart:GetPropertyChangedSignal('CanCollide'):Connect(function()
                humanoid.RootPart.CanCollide = false
            end)
        end)
    end
end

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(char)
        local humanoid = WaitForChildWhichIsA(char,'Humanoid')
        
        repeat task.wait() until humanoid.RootPart
        
        humanoid.RootPart.Size = Vector3.new(size,size,size)
        humanoid.RootPart.CanCollide = false
        humanoid.RootPart:GetPropertyChangedSignal('CanCollide'):Connect(function()
            humanoid.RootPart.CanCollide = false
        end)
    end)
end)
