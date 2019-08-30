local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_enginekiller") 
 
vRP.defInventoryItem({"enginekiller", "EngineKiller", "Destroy the engine of the car", function(args) 
    local choices = {}
	
	choices["Foloseste"] = {function(player,choice,mod)
		local user_id = vRP.getUserId({player})
        if user_id ~= nil then
            vRP.tryGetInventoryItem({user_id, "enginekiller", 1, true})
            TriggerClientEvent('use', player)
            vRPclient.notify(player,{"You are now destroyng the engine of the car"} ) 
            vRP.closeMenu({player})
        end
    end}
   
    return choices
end, 0.05})  
