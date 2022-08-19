-- Credit to NercoLive (https://steamcommunity.com/id/NercoLive/) for making this tool --

TOOL.Category = "Astrea"
TOOL.Name = "Model Blacklister"

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
	--{ name = "reload" }
}

if CLIENT then
	language.Add( "tool.astrea_model_blacklister.name", "Model Blacklister" )
	language.Add( "tool.astrea_model_blacklister.desc", "Adds/Removes a prop from the blacklist" )
	language.Add( "tool.astrea_model_blacklister.left", "Adds a prop to the blacklist" )
	language.Add( "tool.astrea_model_blacklister.right", "Removes a prop from the blacklist")
	--language.Add( "tool.astrea_model_blacklister.reload", "Checks if the prop is in the blacklist")
end

-- Left click adds the model you are looking at to the blacklist
function TOOL:LeftClick( trace )
	local ply = self:GetOwner()
	if not AstreaToolbox.Config.DefaultAdmins.UserGroups[ply:GetUserGroup()] and not AstreaToolbox.Config.DefaultAdmins.Players[ply:SteamID64()] then return end

	local ent = trace.Entity
	if ( !IsValid( ent ) ) then return false end -- The entity is valid and isn't worldspawn

	local model = ent:GetModel()
	AstreaToolbox.Core.AddToList("prop_blacklist_list", model)
	AstreaToolbox.Core.Message(ply, "Added model to the blacklist.", AstreaToolbox.Core.Translated("props_prefix"))

	return true
end

-- right click removes the model you are looking at to the blacklist
function TOOL:RightClick( trace )
	local ply = self:GetOwner()
	if not AstreaToolbox.Config.DefaultAdmins.UserGroups[ply:GetUserGroup()] and not AstreaToolbox.Config.DefaultAdmins.Players[ply:SteamID64()] then return end

	local ent = trace.Entity
	if ( !IsValid( ent ) ) then return false end -- The entity is valid and isn't worldspawn

	local model = ent:GetModel()
	AstreaToolbox.Core.RemoveFromList("prop_blacklist_list", model, 65535)
	AstreaToolbox.Core.Message(ply, "Removed model from the blacklist.", AstreaToolbox.Core.Translated("props_prefix"))

	return true
end
/* --Disabled for now as the tool acts weirdly when printing messages to the chat
function TOOL:Reload(trace)
	local ply = self:GetOwner()
	if not AstreaToolbox.Config.DefaultAdmins.UserGroups[ply:GetUserGroup()] and not AstreaToolbox.Config.DefaultAdmins.Players[ply:SteamID64()] then return end

	local ent = trace.Entity
	if ( !IsValid( ent ) ) then return false end -- The entity is valid and isn't worldspawn

	local model = string.lower(ent:GetModel())
    local models = AstreaToolbox.Core.GetSetting("prop_blacklist_list")

    local whitelist = AstreaToolbox.Core.GetSetting("prop_blacklist_reverse")

    if (whitelist and not (models[model])) or (not whitelist and (models[model])) then 
        AstreaToolbox.Core.Message(ply, "This model is in the blacklist", AstreaToolbox.Core.Translated("props_prefix"))
    else
    	AstreaToolbox.Core.Message(ply, "This model is not in the blacklist", AstreaToolbox.Core.Translated("props_prefix"))
    end 
	
	return true
end
*/