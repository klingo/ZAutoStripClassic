local ZAS = CreateFrame("Frame")

ZAutoStripClassicEnabled = nil

ZAS:RegisterEvent("ADDON_LOADED")
ZAS:RegisterEvent("PLAYER_REGEN_ENABLED")

ZAS:SetScript("OnEvent", function(self, event, ...)
    return self[event](self, event, ...)
end)

SLASH_ZAUTOSTRIP1 = "/zautostrip";
function SlashCmdList.ZAUTOSTRIP(msg, editBox)
	if msg == "display" then
		if ZAutoStrip:IsVisible() then
			ZAutoStrip:Hide()
			ZAutoStripClassicOptions[1] = false
			AutoCastShine_AutoCastStop(ZAutoStripShine)
		else
			ZAutoStrip:Show()
			ZAutoStripClassicOptions[1] = true
			if ZAutoStripClassicEnabled then
				AutoCastShine_AutoCastStart(ZAutoStripShine)
			end
		end
	else
		if ZAutoStripClassicEnabled then
			DEFAULT_CHAT_FRAME:AddMessage("You will no longer strip when you leave combat.",0,1,1)
			ZAutoStripClassicEnabled = nil
			if ZAutoStrip:IsVisible() then 
				AutoCastShine_AutoCastStop(ZAutoStripShine)
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("Next time you exit combat, you will strip.",0,1,1)
			ZAutoStripClassicEnabled = 1
			if ZAutoStrip:IsVisible() then
				AutoCastShine_AutoCastStart(ZAutoStripShine)
			end
		end
	end
end

-- ----------------------------------------------------------

function ZAutoStripUnequipValuables2(i)
	local a=PickupInventoryItem
	local b=GetInventoryItemLink
	if i == 1 then
		if not b("player",16) then
			return true
		end
		a(16)	-- Main Hand
	elseif i == 2 then
		if not b("player",17) then
			return true
		end
		a(17)	-- Off Hand
	elseif i == 3 then
		if not b("player",18) then
			return true
		end
		a(18)	-- Ranged
	elseif i == 4 then
		if not b("player",5) then
			return true
		end
		a(5)	-- Chest
	elseif i == 5 then
		if not b("player",7) then
			return true
		end
		a(7)	-- Legs
	elseif i == 6 then
		if not b("player",1) then
			return true
		end
		a(1)	-- Head
	elseif i == 7 then
		if not b("player",3) then
			return true
		end
		a(3)	-- Shoulders
	elseif i == 8 then
		if not b("player",10) then
			return true
		end
		a(10)	-- Gloves
	elseif i == 9 then
		if not b("player",8) then
			return true
		end
		a(8)	-- Boots
	elseif i == 10 then
		if not b("player",6) then
			return true
		end
		a(6)	-- Belt
	elseif i == 11 then
		if not b("player",9) then
			return true
		end
		a(9)	-- Bracers
	end
	return false
end

function ZAutoStripUnequipValuables()
	ZAutoStripClassicEnabled = nil
	AutoCastShine_AutoCastStop(ZAutoStripShine)
	local count = 1
	local a=PickupContainerItem
	for i=1,GetContainerNumSlots(0) do
		if not GetContainerItemLink(0,i) then
			if count <= 11 then
				if ZAutoStripUnequipValuables2(count) then
					i = i - 1
				else
					a(0,i)
				end
				count = count + 1
			else
				i = 99
			end
		end
	end
	if count > 11 then
		return
	end
	for i=1,GetContainerNumSlots(1) do
		if not GetContainerItemLink(1,i) then
			if count <= 11 then
				if ZAutoStripUnequipValuables2(count) then
					i = i - 1
				else
					a(1,i)
				end
				count = count + 1
			else
				i = 99
			end
		end
	end
	if count > 11 then
		return
	end
	for i=1,GetContainerNumSlots(2) do
		if not GetContainerItemLink(2,i) then
			if count <= 11 then
				if ZAutoStripUnequipValuables2(count) then
					i = i - 1
				else
					a(2,i)
				end
				count = count + 1
			else
				i = 99
			end
		end
	end
	if count > 11 then
		return
	end
	for i=1,GetContainerNumSlots(3) do
		if not GetContainerItemLink(3,i) then
			if count <= 11 then
				if ZAutoStripUnequipValuables2(count) then
					i = i - 1
				else
					a(3,i)
				end
				count = count + 1
			else
				i = 99
			end
		end
	end
	if count > 11 then
		return
	end
	for i=1,GetContainerNumSlots(4) do
		if not GetContainerItemLink(4,i) then
			if count <= 11 then
				if ZAutoStripUnequipValuables2(count) then
					i = i - 1
				else
					a(4,i)
				end
				count = count + 1
			else
				i = 99
			end
		end
	end
end

-- ----------------------------------------------------------

function ZAS:ADDON_LOADED(event, addonName)
	if addonName == "ZAutoStripClassic" then
		if ZAutoStripClassicOptions == nil then
			ZAutoStripClassicOptions = {false}
		end	
	
		if ZAutoStripClassicOptions[1] then
			ZAutoStrip:Show()
		end
		ZAS:UnregisterEvent("ADDON_LOADED")
	end
end

function ZAS:PLAYER_REGEN_ENABLED(event)
	if ZAutoStripClassicEnabled then
		ZAutoStripUnequipValuables()
	end
end

