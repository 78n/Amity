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

local hitbox = function(target_char)
    local humanoid = WaitForChildWhichIsA(target_char,"Humanoid")
    repeat task.wait() until humanoid.RootPart
    local hrp = humanoid.RootPart
    
    hrp.Size = Vector3.new(size,size,size)
    hrp.CanCollide = false
    hrp:GetPropertyChangedSignal('CanCollide'):Connect(function()
        hrp.CanCollide = false
    end)
end
    

for i,v in next, Players:GetPlayers() do
    if v ~= lp then
        if v.Character then
            hitbox(v.Character)
        end
        v.CharacterAdded:Connect(function(char)
            hitbox(char)
        end)
    end
end

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(char)
        hitbox(char)
    end)
end)
