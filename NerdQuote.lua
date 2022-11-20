local ReplicatedStorage = game:FindService("ReplicatedStorage")
local ChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
local OnMessageEvent = ChatEvents:WaitForChild("OnMessageDoneFiltering")
local SayMessageRequest = ChatEvents:WaitForChild("SayMessageRequest")

if not SayMessageRequest:IsA("RemoteEvent") or not OnMessageEvent:IsA("RemoteEvent") then return end

local ChatLegth = require(game:FindService("Chat"):WaitForChild("ClientChatModules"):WaitForChild("ChatSettings")).MaximumMessageLength
local lp = game:FindService("Players").LocalPlayer.Name

OnMessageEvent.OnClientEvent:Connect(function(data)
    if not data then return end
    local player = tostring(data.FromSpeaker)
    if player == lp then return end
    local message = tostring(data.Message)
    if (message):len() <= (ChatLegth-7) then
        SayMessageRequest:FireServer(('\"%s\"%s'):format(message,"🤓"),tostring(data.OriginalChannel))
    end
end)
