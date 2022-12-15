local function rename(remotename,hashedremote)
    hashedremote.Name = remotename
end

table.foreach(getupvalue(require(game:GetService("ReplicatedStorage"):WaitForChild("Fsys")).load("RouterClient").init,4),rename)
