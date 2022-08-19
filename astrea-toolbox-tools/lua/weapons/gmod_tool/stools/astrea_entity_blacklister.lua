-- Credit to NercoLive (https://steamcommunity.com/id/NercoLive/) for making this tool --

TOOL.Category = "Astrea"
TOOL.Name = "Entity Blacklister"

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
	--{ name = "reload" }
}

if CLIENT then
	language.Add( "tool.astrea_entity_blacklister.name", "Entity Blacklister" )
	language.Add( "tool.astrea_entity_blacklister.desc", "Adds/Removes the entity you are looking at from the blacklist" )
	language.Add( "tool.astrea_entity_blacklister.left", "Adds an entity to the blacklist" )
	language.Add( "tool.astrea_entity_blacklister.right", "Removes an entity from the blacklist")
	--language.Add( "tool.astrea_entity_blacklister.reload", "Checks if the entity is in the blacklist")
end

-- Left click adds the entity you are looking at to the blacklist
function TOOL:LeftClick( trace )
	local ply = self:GetOwner()
	if not AstreaToolbox.Config.DefaultAdmins.UserGroups[ply:GetUserGroup()] and not AstreaToolbox.Config.DefaultAdmins.Players[ply:SteamID64()] then return end

	local ent = trace.Entity
	if ( !IsValid( ent ) ) then return false end -- The entity is valid and isn't worldspawn

	local ent_class = ent:GetClass()
	AstreaToolbox.Core.AddToList("ent_blacklist_list", ent_class)
	AstreaToolbox.Core.Message(ply, "Added entity to the blacklist.", AstreaToolbox.Core.Translated("props_prefix"))

	return true
end

-- right click removes the entity you are looking at to the blacklist
function TOOL:RightClick( trace )
	local ply = self:GetOwner()
	if not AstreaToolbox.Config.DefaultAdmins.UserGroups[ply:GetUserGroup()] and not AstreaToolbox.Config.DefaultAdmins.Players[ply:SteamID64()] then return end

	local ent = trace.Entity
	if ( !IsValid( ent ) ) then return false end -- The entity is valid and isn't worldspawn

	local ent_class = ent:GetClass()
	AstreaToolbox.Core.RemoveFromList("ent_blacklist_list", ent_class, 65535)
	AstreaToolbox.Core.Message(ply, "Removed entity from the blacklist.", AstreaToolbox.Core.Translated("props_prefix"))

	return true
end
/* --Disabled for now as the tool acts weirdly when printing messages to the chat
function TOOL:Reload(trace)
	local ply = self:GetOwner()
	if not AstreaToolbox.Config.DefaultAdmins.UserGroups[ply:GetUserGroup()] and not AstreaToolbox.Config.DefaultAdmins.Players[ply:SteamID64()] then return end

	local ent = trace.Entity
	if ( !IsValid( ent ) ) then return false end -- The entity is valid and isn't worldspawn

	local ent_class = ent:GetClass()
    local entities = AstreaToolbox.Core.GetSetting("ent_blacklist_list")

    local whitelist = AstreaToolbox.Core.GetSetting("ent_blacklist_reverse")
    
    if (whitelist and not entities[ent_class]) or (not whitelist and entities[ent_class]) then 
        AstreaToolbox.Core.Message(ply, "This entity is in the blacklist", AstreaToolbox.Core.Translated("props_prefix"))
    else
    	AstreaToolbox.Core.Message(ply, "This entity is not in the blacklist", AstreaToolbox.Core.Translated("props_prefix"))
    end
	
	return true
end
*/