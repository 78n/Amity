local cloneref = cloneref or function(...) return ... end

if autoarrest then autoarrest() end

if not isfolder("JailBreak") then
	makefolder("JailBreak")
end

if not isfolder("JailBreak/RemoteAddresses") then
	makefolder("JailBreak/RemoteAddresses")
end

if not isfile("JailBreak/RemoteAddresses/ArrestAddress.txt") then
	writefile("JailBreak/RemoteAddresses/ArrestAddress.txt", "")
end

local Run = true
local Players = cloneref(game:GetService("Players"))
local lp = cloneref(Players.LocalPlayer)
local Backpack = cloneref(lp:WaitForChild("Folder"))
local MaxArrest = rawget(require(game:GetService("ReplicatedStorage"):WaitForChild("Game"):WaitForChild("ItemConfig"):WaitForChild("Handcuffs")),"ArrestDistance")

if not type(MaxArrest) == "number" then
   warn("MaxArrest was not a number")
   MaxArrest = 10
end

local FunctionHandler, CommunicationRemote, EventTable = (function()
	for i,v in getgc(false) do
		if type(v) == "function" and islclosure(v) and debug.info(v,"n") == "EventFireServer" then
			local upvalues = debug.getupvalues(v)
			
			if typeof(upvalues[2]) == "Instance" and type(upvalues[3]) == "table" then
				return v, cloneref(upvalues[2]), upvalues[3]
			end
		end
	end
end)()

if not (FunctionHandler and CommunicationRemote and EventTable) then
	return warn("Failed to fetch Upvalue data")
end

local ArrestRemoteAddress = rawget(EventTable, readfile("JailBreak/RemoteAddresses/ArrestAddress.txt"))

if not ArrestRemoteAddress then
	local thread = coroutine.running()
	
	local BindableFunction = Instance.new("BindableFunction") -- Fluxus doesnt allow C closures for hookfunction anymore [very cool! thank you fluxus!]
	
	local info = Instance.new("Hint", game:GetService("CoreGui"))
	info.Text = "Failed to retrieve Arrest Address | Please Arrest someone"
	
	function BindableFunction.OnInvoke(address)
		if rawget(EventTable, address) then
			ArrestRemoteAddress = address
			coroutine.resume(thread)
			return true
		end
		return false
	end
	
	local old
	old = hookfunction(FunctionHandler, function(...)
		if select("#", ...) == 2 then
			local address,plrname = ...
			
			if type(address) == "string" and type(plrname) == "string" then
				if Players:FindFirstChild(plrname) then
					BindableFunction:Invoke(address)
					return
				end
			end
		end
		return old(...)
	end)
	
	getgenv().autoarrest = function()
		hookfunction(FunctionHandler, old)
	end
	
	coroutine.yield()
	autoarrest()
	writefile("JailBreak/RemoteAddresses/ArrestAddress.txt", ArrestRemoteAddress)
	info.Text = `Successfully retrieved Arrest Address: \"{ArrestRemoteAddress}\"`
	
	task.delay(10, function()
		info:Destroy()
	end)
end

EventTable = nil

local Ignorelist = OverlapParams.new()

local function HasHandCuffs(char)
   return char and char:FindFirstChild("Handcuffs") ~= nil
end

local function IsArrestable(plr)
   if not HasHandCuffs(plr.Character) then
       if plr:GetAttribute("HasEscaped") then
           return true
       elseif plr.Team and plr.Team.Name == "Prisoner" then
           local Items = cloneref(plr:FindFirstChild("Folder"))
           if Items then
               if Items:FindFirstChild("MansionInvite") then
                   return #Items:GetChildren() > 1
               end
               return #Items:GetChildren() > 0
           end
       end
   end
end

local function getchar(plr,yield)
   plr = plr or lp
   local char = plr.Character or yield and plr.CharacterAdded:Wait()
   return char and cloneref(char)
end

local function GetPlayers()
   local PlayerList = {}
   for i,v in Players:GetPlayers() do
       if IsArrestable(v) then
           table.insert(PlayerList,getchar(v))
       end
   end
   return PlayerList
end

EventTable = nil
Ignorelist.FilterType = Enum.RaycastFilterType.Include

getgenv().autoarrest = setmetatable({},{__call = function() Run = false end})

while Run do
   	local Handcuffs = Backpack:FindFirstChild("Handcuffs") and cloneref(Backpack:FindFirstChild("Handcuffs"))

   	if Handcuffs and Handcuffs:GetAttribute("InventoryItemEquipped") then
       local char = getchar(nil,true)
       local Humanoid = char and char:FindFirstChildWhichIsA("Humanoid")
       local RootPart = Humanoid and Humanoid.RootPart
       if RootPart then
           Ignorelist.FilterDescendantsInstances = GetPlayers()

           for i,v in workspace:GetPartBoundsInRadius(RootPart.CFrame.Position,MaxArrest,Ignorelist) do
               local Model = v:FindFirstAncestorWhichIsA("Model")

               if not HasHandCuffs(Model) then
                   local Player = Players:GetPlayerFromCharacter(Model)

                   if Player then
                       CommunicationRemote:FireServer(ArrestRemoteAddress,Player.Name)
                   end
               end
           end
       end
   end
   task.wait()
end
