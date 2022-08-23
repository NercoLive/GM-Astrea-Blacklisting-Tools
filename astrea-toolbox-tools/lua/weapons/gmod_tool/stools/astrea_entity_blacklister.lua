-- Credit to NercoLive (https://steamcommunity.com/id/NercoLive/) for making this tool --

TOOL.Category = "Astrea"
TOOL.Name = "Entity Blacklister"

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
	{ name = "reload" }
}

if CLIENT then
	language.Add( "tool.astrea_entity_blacklister.name", "Entity Blacklister" )
	language.Add( "tool.astrea_entity_blacklister.desc", "Adds/Removes the entity you are looking at from the blacklist" )
	language.Add( "tool.astrea_entity_blacklister.left", "Adds an entity to the blacklist. Shoot a blacklisted entity to remove it" )
	language.Add( "tool.astrea_entity_blacklister.right", "Removes an entity from the blacklist")
	language.Add( "tool.astrea_entity_blacklister.reload", "Checks if the entity is in the blacklist")
end

-- Left click adds the entity you are looking at to the blacklist
function TOOL:LeftClick( trace )
	if not trace then return end 

	local ent = trace.Entity
	if ( !IsValid( ent ) ) then return false end

	local ply = self:GetOwner()
	if not AstreaToolbox.Config.DefaultAdmins.UserGroups[ply:GetUserGroup()] and not AstreaToolbox.Config.DefaultAdmins.Players[ply:SteamID64()] then return end

	local ent_class = ent:GetClass()
	local entities = AstreaToolbox.Core.GetSetting("ent_blacklist_list")

	if (enitities and entities[ent_class]) then
		ent:Remove()
	else
		AstreaToolbox.Core.AddToList("ent_blacklist_list", ent_class)
		--AstreaToolbox.Core.Message(ply, "Added entity to the blacklist.", AstreaToolbox.Core.Translated("props_prefix"))
		AstreaToolbox.Core.Notify(ply, "Added entity to the blacklist.", 0, 2)
	end

	return true
end

-- right click removes the entity you are looking at from the blacklist
function TOOL:RightClick( trace )
	if not trace then return end 

	local ent = trace.Entity
	if ( !IsValid( ent ) ) then return false end -- The entity is valid and isn't worldspawn

	local ply = self:GetOwner()
	if not AstreaToolbox.Config.DefaultAdmins.UserGroups[ply:GetUserGroup()] and not AstreaToolbox.Config.DefaultAdmins.Players[ply:SteamID64()] then return end

	local ent_class = ent:GetClass()
	AstreaToolbox.Core.RemoveFromList("ent_blacklist_list", ent_class, 65535)
	--AstreaToolbox.Core.Message(ply, "Removed entity from the blacklist.", AstreaToolbox.Core.Translated("props_prefix"))
	AstreaToolbox.Core.Notify(ply, "Removed entity from the blacklist.", 1, 2)

	return true
end

function TOOL:Reload(trace)
	if not trace then return end 

	local ent = trace.Entity
	if ( !IsValid( ent ) ) then return false end

	local ply = self:GetOwner()
	if not AstreaToolbox.Config.DefaultAdmins.UserGroups[ply:GetUserGroup()] and not AstreaToolbox.Config.DefaultAdmins.Players[ply:SteamID64()] then return end

	local ent_class = ent:GetClass()
    local entities = AstreaToolbox.Core.GetSetting("ent_blacklist_list")
   
    if (entities and entities[ent_class]) then 
        --AstreaToolbox.Core.Message(ply, "This entity is in the blacklist", AstreaToolbox.Core.Translated("props_prefix"))
		AstreaToolbox.Core.Notify(ply, "This entity is in the blacklist", 0, 2)
    else
    	--AstreaToolbox.Core.Message(ply, "This entity is not in the blacklist", AstreaToolbox.Core.Translated("props_prefix"))
		AstreaToolbox.Core.Notify(ply, "This entity is not in the blacklist", 1, 2)
    end
	
	return true
end
