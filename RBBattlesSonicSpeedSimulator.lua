local msg = Instance.new("Hint",game:FindService("CoreGui"))
msg.Text = "\nDO NOT DELETE THE BADGE FROM YOUR INVENTORY THEY WILL NOT REAWARD IT FROM WHAT IVE TESTED"
local Services = game:GetService("ReplicatedStorage"):WaitForChild("Knit"):WaitForChild("Services")
local RF = Services:WaitForChild("ZoneService"):WaitForChild("RF")
RF:WaitForChild("RequestTeleportToZone"):InvokeServer("RB Battles Obby")
local OnStateSwitch = Services:WaitForChild("MapStateService"):WaitForChild("RE"):WaitForChild("OnStateSwitch")

for i = 1,25 do
    OnStateSwitch:FireServer("RBBattlesSecuritySwitch",tostring(i),"Attacked","Broken")
    task.wait() -- doesnt always count all the switches
end

Services:WaitForChild("ZoneService"):WaitForChild("RF"):WaitForChild("FinishObby"):InvokeServer("RB Battles Obby",true)
