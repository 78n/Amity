local shareddata = getupvalue(getupvalue(getrawmetatable(require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Client"):WaitForChild("Network"))).__index,1).Invoke,2)
local hashstorage = getupvalue(getupvalue(shareddata,2),1)
local remotestorage = getupvalue(getupvalue(shareddata,1),1)

for i = 1,#hashstorage do
    for i,v in next, hashstorage[i] do
        hashstorage[v] = i
    end
end

for i = 1,#remotestorage do
    for i,v in next, remotestorage[i] do
        if hashstorage[i] then
            v.Name = hashstorage[i]
        else
            warn("Remote's that were not beatified:",i,v,hashstorage[i])
        end
    end
end
