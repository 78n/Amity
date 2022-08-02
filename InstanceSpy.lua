local old
old = hookfunction(Instance.new,function(instance,parent)
    if checkcaller() then
        rconsoleprint("@@LIGHT_GREEN@@")
        rconsoleprint(("New Instance: %s\n"):format(instance))
        if parent then
            rconsoleprint("@@YELLOW@@")
            rconsoleprint(("Instance Parent: %s\n"):format(tostring(parent)))
        end
        return old(instance,parent)
    end
    return old(instance,parent)
end)
